import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
 
void main() {
  runApp(const MediConnectApp());
}
 
class MediConnectApp extends StatelessWidget {
  const MediConnectApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediConnect',
      debugShowCheckedModeBanner: false,
 
      // Global theme: one place to control the look of the whole app.
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
 
      // ─────────────────────────────────────────────
      // THE ROUTE TABLE — the heart of this lab.
      // Each entry maps a route NAME to a screen WIDGET.
      // ─────────────────────────────────────────────
      initialRoute: '/',          // the first screen shown when the app starts
      routes: {
        '/':         (context) => SplashScreen (),
        '/login':    (context) =>  LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home':     (context) => const HomeScreen(),
        '/chat':     (context) => const ChatScreen(),
      },
    );
  }
}
