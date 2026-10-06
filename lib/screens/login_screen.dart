import 'package:flutter/material.dart';
 
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
 
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
 
class _LoginScreenState extends State<LoginScreen> {
  // The form key gives us access to the Form's state so we can
  // call validate() on ALL fields at once.
  final _formKey = GlobalKey<FormState>();
 
  // Controllers let us READ what the user typed.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
 
  bool _obscurePassword = true; // toggles password visibility
 
  @override
  void dispose() {
    // Always dispose controllers to free memory when the screen closes.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
 
  void _login() {
    // validate() runs every field's validator function.
    // It returns true only if ALL validators return null.
    if (_formKey.currentState!.validate()) {
      // In a real app, you would call your backend API here.
      // For this lab, any valid input "logs in".
 
      // pushNamedAndRemoveUntil:
      //  - pushes '/home'
      //  - the (route) => false part removes EVERY screen underneath.
      // Result: pressing back from Home exits the app instead of
      // returning to the login form. This is standard login behaviour.
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // prevents overflow when keyboard opens
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                const Icon(Icons.medical_services_rounded,
                    size: 70, color: Colors.teal),
                const SizedBox(height: 16),
                const Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to consult a doctor',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 40),
 
                // ── EMAIL FIELD ──
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null; // null means "valid"
                  },
                ),
                const SizedBox(height: 16),
 
                // ── PASSWORD FIELD ──
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
 
                // ── LOGIN BUTTON ──
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
 
                // ── LINK TO REGISTRATION ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        // Plain pushNamed: Register goes ON TOP of Login.
                        // The user can press back to return here.
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
