import 'package:flutter/material.dart';
import 'package:supabase_chat/services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                AuthServices().googleSignIn();
              },
              child: Text("Login With Google"),
            ),
          ],
        ),
      ),
    );
  }
}
