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
    required int age,
    required String gender,
    required String profession,
    required List<String> socialChallenges,
    required List<String> socialSettings,
  });

  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> loginWithGoogle();

  Future<UserModel> test();

  Future<UserModel> signUpWithGoogle({
    required int age,
    required String gender,
    required String profession,
    required List<String> socialChallenges,
    required List<String> socialSettings,
  });
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final UserDataSource userDataSource;

  AuthDataSourceImpl(this.firebaseAuth, this.googleSignIn, this.userDataSource);

  final serverUrl = dotenv.env['BACKEND_URL']! + "/api";

  @override
  Future<UserModel> test() async {
    http.Response response = await http.get(
      Uri.parse("https://dummyjson.com/c/9f0b-4cbf-4f3e-bb9c"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    var json = jsonDecode(response.body);
    print(response.body.toString());
    if (response.statusCode < 300) {
      await userDataSource.saveUserDetails(
          json["token"], json["firstName"], json["xp"]);
      final user = UserModel.fromJson(json);
      return user;
    }
    return UserModel.empty();
  }

  @override
  Future<UserModel> loginWithGoogle() async {
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

        late http.Response response;

        await firebaseAuth.currentUser?.getIdToken(true).then((idToken) async {
          // Send token to your backend via HTTPS
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
        });
        if (response.statusCode > 300) {
          throw ServerException("Create an account with Google first");
        }
        var json = jsonDecode(response.body);
        debugPrint(json.toString());
        if (response.statusCode < 300) {
          await userDataSource.saveUserDetails(
              json["token"], json["firstName"], json["xp"]);

          final user = UserModel.fromJson(json);
          return user;
        } else {
          throw ServerException(json["error"]);
        }
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
    late http.Response response;
    await firebaseAuth.currentUser?.getIdToken(true).then((idToken) async {
      // Send token to your backend via HTTPS
      debugPrint(idToken);
      response = await http.post(Uri.parse("$serverUrl/auth/login"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(
            <String, String>{'email': email, 'firebaseToken': idToken!},
          ));
    }).catchError((error) {
      // Handle error
      debugPrint("Error: $error");
      throw ServerException(error.toString());
    });

    var json = jsonDecode(response.body);
    print(json.toString());
    if (response.statusCode < 300) {
      await userDataSource.saveUserDetails(
          json["token"], json["firstName"], json["xp"]);

      final user = UserModel.fromJson(json);
      return user;
    } else {
      throw ServerException(json["error"]);
    }
  }

  @override
  Future<UserModel> signUpWithEmail(
      {required String firstName,
      required String lastName,
      required String email,
      required String password,
      required int age,
      required String gender,
      required String profession,
      required List<String> socialChallenges,
      required List<String> socialSettings}) async {
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

    late http.Response? response;
    await firebaseAuth.currentUser?.getIdToken(true).then((idToken) async {
      // Send token to your backend via HTTPS
      debugPrint(idToken);

      response = await http.post(Uri.parse("$serverUrl/auth/register"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(
            <String, Object>{
              'firstName': firstName,
              'lastName': lastName,
              'email': email,
              'firebaseToken': idToken!,
              'age': age,
              'gender': gender,
              'profession': profession,
              "socialChallenges": socialChallenges,
              "strugglingSocialSetting": socialSettings
            },
          ));
    }).catchError((error) {
      // Handle error
      debugPrint("Error: $error");
      throw ServerException(error.toString());
    });
    if (response == null) {
      throw ServerException("An error occurred while creating the account.");
    }
    print(response!.body.toString());
    var json = jsonDecode(response!.body);

    if (response!.statusCode < 300) {
      await userDataSource.saveUserDetails(
          json["token"], json["firstName"], json["xp"]);

      final user = UserModel.fromJson(json);
      return user;
    } else {
      throw ServerException(json["error"]);
    }
  }

  @override
  Future<UserModel> signUpWithGoogle({
    required int age,
    required String gender,
    required String profession,
    required List<String> socialChallenges,
    required List<String> socialSettings,
  }) async {
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
        final name = user?.displayName ?? "";
        String firstName = name.split(" ")[0];
        String lastName = name.split(" ")[1];

        late http.Response response;
        await firebaseAuth.currentUser?.getIdToken(true).then((idToken) async {
          // Send token to your backend via HTTPS
          print(idToken);
          response = await http.post(Uri.parse("$serverUrl/auth/register"),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode(
                <String, Object>{
                  "firstName": firstName,
                  "lastName": lastName,
                  'email': user?.email ?? "",
                  'firebaseToken': idToken!,
                  'age': age,
                  'gender': gender,
                  'profession': profession,
                  "socialChallenges": socialChallenges,
                  "strugglingSocialSetting": socialSettings
                },
              ));
        }).catchError((error) {
          throw ServerException(error.toString());
        });
        var json = jsonDecode(response.body);
        if (response.statusCode < 300) {
          await userDataSource.saveUserDetails(
              json["token"], json["firstName"], json["xp"]);

          final user = UserModel.fromJson(json);
          return user;
        } else {
          throw ServerException(json["error"]);
        }
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
}
