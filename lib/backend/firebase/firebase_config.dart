import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBUEI4NjdCvZSuJuev_dS_IU03xKxstoYE",
            authDomain: "photic-3b3a4.firebaseapp.com",
            projectId: "photic-3b3a4",
            storageBucket: "photic-3b3a4.appspot.com",
            messagingSenderId: "818222575960",
            appId: "1:818222575960:web:f117916d495a03bbd5752d"));
  } else {
    await Firebase.initializeApp();
  }
}
