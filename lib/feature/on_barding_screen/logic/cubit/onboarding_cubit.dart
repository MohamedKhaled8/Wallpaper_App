import 'dart:math';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:logger/logger.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/config/app_logger.dart';
import 'package:wallapp/core/utils/dependency/get_it.dart';
import 'package:wallapp/feature/splash_screen/logic/cubit/auth_cubit.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  int currentPageIndex = 0;
  double progress = 0.0;
  final AuthCubit authCubit = getIt<AuthCubit>();
  final PageController pageController = PageController();
  ViewState viewState = ViewState.idel;
  final Logger logger = Logger();
  final firebaseAuth = FirebaseAuth.instance;
  OnboardingCubit() : super(OnboardingInitial());

  void changePage(int index) {
    emit(OnboardingPageChanged(index));
  }

  void nextPage() {
    if (currentPageIndex < 2) {
      currentPageIndex++;
      emit(OnboardingPageChanged(currentPageIndex));
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    viewState = ViewState.busy;
    emit(OnboardingInitial());
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final authResponse = await firebaseAuth.signInWithCredential(credential);

      if (googleAuth == null) {
        viewState = ViewState.error;
        emit(OnboardingError());
      } else {
        viewState = ViewState.success;
        emit(OnboardingSuccess());
        await authCubit.setLoggedIn(true);
      }

      appLogger('Successfully signed in with Google');
      return authResponse;
    } catch (e) {
      viewState = ViewState.error;
      emit(OnboardingError());
      appLogger('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signIn();
    appLogger('Signed out');
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
