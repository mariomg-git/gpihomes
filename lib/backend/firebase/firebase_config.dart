import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCxQth-MdaAZiriOmOTinAj5362UUWNN9g",
            authDomain: "gpi-homes-6j0y9b.firebaseapp.com",
            projectId: "gpi-homes-6j0y9b",
            storageBucket: "gpi-homes-6j0y9b.appspot.com",
            messagingSenderId: "71591595877",
            appId: "1:71591595877:web:75442cb04057f88726db8c"));
  } else {
    await Firebase.initializeApp();
  }
}
