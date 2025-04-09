import 'package:flutter/material.dart';
import 'package:supabase_chat/screens/home_screen.dart';
import 'package:supabase_chat/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final state = Supabase.instance.client.auth.currentSession;
        if (state != null) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
