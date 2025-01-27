import 'dart:convert';

import 'package:dapple/core/error/exceptions.dart';
import 'package:dapple/features/auth/data/local/user_data_source.dart';
import 'package:dapple/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract interface class AuthDataSource {
  Future<UserModel> signUpWithEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> loginWithGoogle({required bool isSignUp});

  Future<String> test();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final UserDataSource userDataSource;

  AuthDataSourceImpl(this.firebaseAuth, this.googleSignIn, this.userDataSource);

  final serverUrl = dotenv.env['BACKEND_URL'];

  @override
  Future<String> test() async {
    final serverUrl = dotenv.env['BACKEND_URL'];
    final response = await http.get(
      Uri.parse("$serverUrl/auth/hello"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    debugPrint("Test: ${response.body}");
    return "Test";
  }

  @override
  Future<UserModel> loginWithGoogle({required bool isSignUp}) async {
    User? user;
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      debugPrint("Account present");
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        user = userCredential.user;

        debugPrint(user.toString());

        await firebaseAuth.currentUser?.getIdToken(true).then((idToken) async {
          // Send token to your backend via HTTPS
          final name = user?.displayName ?? "";
          String firstName = name.split(" ")[0];
          String lastName = name.split(" ")[1];
          http.Response response;
          if (isSignUp) {
            response = await http.post(Uri.parse("$serverUrl/auth/register"),
                headers: {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                },
                body: jsonEncode(
                  <String, String>{
                    "firstName": firstName,
                    "lastName": lastName,
                    'email': user?.email ?? "",
                    'firebaseToken': idToken!
                  },
                ));
          } else {
            response = await http.post(Uri.parse("$serverUrl/auth/login"),
                headers: {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                },
                body: jsonEncode(
                  <String, String>{
                    'email': user?.email ?? "",
                    'firebaseToken': idToken!
                  },
                ));
            if (response.statusCode > 300) {
              throw ServerException("Create an account with Google first");
            }
          }
          debugPrint(idToken);
          var json = jsonDecode(response.body);
          debugPrint(json.toString());
          if (response.statusCode < 300) {
            userDataSource.saveUserDetails(json["token"], json["firstName"],
                json["xp"], json["level"], json["section"]);

            return UserModel.fromJson(json);
          } else {
            throw ServerException(json["error"]);
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          throw ServerException(
              "The account already exists with a different credential");
        } else if (e.code == 'invalid-credential') {
          throw ServerException("The credential provided is invalid");
        }
      } catch (e) {
        throw ServerException(
            "An error occurred while signing in with Google.\n ${e.toString()}");
      }
    } else {
      debugPrint("Google Sign In Failed");
      throw ServerException("Google Sign In Failed");
    }
    return UserModel.empty();
  }

  @override
  Future<UserModel> loginWithEmail(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("User logged in: ${credential.user!}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ServerException("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        throw ServerException("Wrong password provided for that user.");
      }
    }

    await firebaseAuth.currentUser?.getIdToken(true).then((idToken) async {
      // Send token to your backend via HTTPS
      http.Response response =
          await http.post(Uri.parse("$serverUrl/auth/login"),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode(
                <String, String>{'email': email, 'firebaseToken': idToken!},
              ));

      var json = jsonDecode(response.body);
      if (response.statusCode < 300) {
        userDataSource.saveUserDetails(json["token"], json["firstName"],
            json["xp"], json["level"], json["section"]);

        return UserModel.fromJson(json);
      } else {
        throw ServerException(json["error"]);
      }
    }).catchError((error) {
      // Handle error
      debugPrint("Error: $error");
      throw ServerException(error.toString());
    });
    return UserModel.empty();
  }

  @override
  Future<UserModel> signUpWithEmail(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("User created: ${credential.user!}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ServerException("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw ServerException("The account already exists for that email.");
      }
    } catch (e) {
      throw ServerException(
          "An error occurred while creating the account.\n ${e.toString()}");
    }
    await firebaseAuth.currentUser?.getIdToken(true).then((idToken) async {
      // Send token to your backend via HTTPS
      http.Response response =
          await http.post(Uri.parse("$serverUrl/auth/register"),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode(
                <String, String>{
                  'firstName': firstName,
                  'lastName': lastName,
                  'email': email,
                  'firebaseToken': idToken!
                },
              ));

      var json = jsonDecode(response.body);
      if (response.statusCode < 300) {
        userDataSource.saveUserDetails(json["token"], json["firstName"],
            json["xp"], json["level"], json["section"]);

        return UserModel.fromJson(json);
      } else {
        throw ServerException(json["error"]);
      }
    }).catchError((error) {
      // Handle error
      debugPrint("Error: $error");
      throw ServerException(error.toString());
    });
    return UserModel.empty();
  }
}
