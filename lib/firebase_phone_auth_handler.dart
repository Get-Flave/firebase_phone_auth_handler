library firebase_phone_auth_handler;

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_handler/src/service.dart';
import 'package:firebase_phone_auth_handler/src/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebasePhoneAuthHandler extends StatelessWidget {
  const FirebasePhoneAuthHandler({
    required this.phoneNumber,
    required this.builder,
    this.onLoginFailed,
    this.onLoginSuccess,
    this.timeOutDuration = FirebasePhoneAuthService.TIME_OUT_DURATION,
  });

  /// {@template phoneNumber}
  /// The phone number to which the OTP is to be sent.
  ///
  /// The phone number should also contain the country code.
  ///
  /// Example: +919876543210 where +91 is the country code and 9876543210 is the number.
  /// {@endtemplate}
  final String phoneNumber;

  /// {@template onLoginSuccess}
  /// This callback is triggered when the phone number is verified and the user is
  /// signed in successfully. The function provides [UserCredential] which contains
  /// essential user information.
  /// {@endtemplate}
  final FutureOr<void> Function(UserCredential)? onLoginSuccess;

  /// {@template onLoginFailed}
  /// This callback is triggered if the phone verification fails. The callback provides
  /// [FirebaseAuthException] which contains information about the error.
  /// {@endtemplate}
  final FutureOr<void> Function(FirebaseAuthException)? onLoginFailed;

  /// {@template timeOutDuration}
  /// The maximum amount of time you are willing to wait for SMS
  /// auto-retrieval to be completed by the library.
  ///
  /// Maximum allowed value is 2 minutes.
  ///
  /// Defaults to [FirebasePhoneAuthService.TIME_OUT_DURATION].
  /// {@endtemplate}
  final Duration timeOutDuration;

  /// {@template builder}
  /// The widget returned by the `builder` is rendered on to the screen and
  /// builder is called every time a value changes i.e. either the timerCount or any
  /// other value.
  /// {@endtemplate}
  final Widget Function(FirebasePhoneAuthService) builder;

  /// FIXME: Provider error
  /// {@template signOut}
  /// Signs out the current user.
  /// {@endtemplate}
  // static Future<void> signOut(BuildContext context) =>
  //     Provider.of<FirebasePhoneAuthService>(context, listen: false).signOut();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebasePhoneAuthService()),
      ],
      child: FirebasePhoneAuthWidget(
        phoneNumber: this.phoneNumber,
        timeOutDuration: this.timeOutDuration,
        onLoginSuccess: this.onLoginSuccess,
        onLoginFailed: this.onLoginFailed,
        builder: this.builder,
      ),
    );
  }
}
