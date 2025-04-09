import 'package:flutter/material.dart';
import 'package:supabase_chat/services/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFlaXhvYW54aG5zeW14aW1jaG94Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMzgwMjIsImV4cCI6MjA1OTYxNDAyMn0.zX8RGI6gwpJoGPOtgKUqezbDiSRT9Q8OyoOYGVHmA0s",
    url: "https://aeixoanxhnsymximchox.supabase.co",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supabase Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      home: AuthGate(),
    );
  }
}
