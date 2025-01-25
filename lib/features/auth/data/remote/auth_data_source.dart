import 'dart:convert';

import 'package:dapple/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract interface class AuthDataSource {
  Future<String> signUpWithEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<String> loginWithEmail({
    required String email,
    required String password,
  });

  Future<String> test();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth;

  AuthDataSourceImpl(this.firebaseAuth);

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
  Future<String> loginWithEmail(
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

    String? uid;
    await firebaseAuth.currentUser?.getIdToken(true).then((idToken) {
      // Send token to your backend via HTTPS
      debugPrint("ID Token: $idToken");
      uid = idToken;
    }).catchError((error) {
      // Handle error
      debugPrint("Error: $error");
    });
    final serverUrl = dotenv.env['BACKEND_URL'];
    final response = await http.post(Uri.parse("$serverUrl/auth/login"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          <String, String>{'email': email, 'firebaseToken': uid!},
        ));

    debugPrint("User created: ${response.body}");
    return "User logged in successfully";
  }

  @override
  Future<String> signUpWithEmail(
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
    String? uid;
    await firebaseAuth.currentUser?.getIdToken(true).then((idToken) {
      // Send token to your backend via HTTPS
      debugPrint("ID Token: $idToken");
      uid = idToken;
    }).catchError((error) {
      // Handle error
      debugPrint("Error: $error");
    });
    final serverUrl = dotenv.env['BACKEND_URL'];
    final response = await http.post(Uri.parse("$serverUrl/auth/register"),
        headers: {
          'Content-type': 'application/json',
          'Accept': '*/*',
        },
        body: jsonEncode(
          <String, String>{
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'firebaseToken': uid!
          },
        ));

    debugPrint("User created: ${response.body}");

    return "User created successfully";
  }
}
