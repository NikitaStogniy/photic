import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB25MtJwyHKM20tMHXKQZK1aZ-MznzCF14",
            authDomain: "photicus.firebaseapp.com",
            projectId: "photicus",
            storageBucket: "photicus.appspot.com",
            messagingSenderId: "909582697749",
            appId: "1:909582697749:web:b49b3ee9b110e2498c151c"));
  } else {
    await Firebase.initializeApp();
  }
}
