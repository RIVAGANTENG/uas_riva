import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasbih/page/page_login.dart';
import 'package:tasbih/page/page_tasbih.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBrrniofvfZKdx-KXpQu46becIHHzG-nCI",
        authDomain: "tasbih-e1455.firebaseapp.com",
        projectId: "tasbih-e1455",
        storageBucket: "tasbih-e1455.firebasestorage.app",
        messagingSenderId: "911007585799",
        appId: "1:911007585799:web:dd8a89e1d0cedd1aadbca2",
        measurementId: "G-N9XLLPS3ZF"
    ),
  );
  await GetStorage.init(); // Inisialisasi GetStorage
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Debugging: Cetak status autentikasi
          print('User logged in: ${snapshot.hasData}');
          if (snapshot.hasData) {
            return const PageTasbih();
          }
          return const LoginPage();
        },
      ),
    );
  }
}