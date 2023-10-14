import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDP6IeR4Ik3rxnWcEUlzh_NjyTPU041Deo",
            authDomain: "photiq-eccd9.firebaseapp.com",
            projectId: "photiq-eccd9",
            storageBucket: "photiq-eccd9.appspot.com",
            messagingSenderId: "829408357407",
            appId: "1:829408357407:web:9f2e355fdf4dde0901392a",
            measurementId: "G-QJGL353QW7"));
  } else {
    await Firebase.initializeApp();
  }
}
