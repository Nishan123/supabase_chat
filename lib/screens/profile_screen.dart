import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_chat/controller/user_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profilePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: UserController().getProfileData(
              Supabase.instance.client.auth.currentUser!.id.toString(),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text("Error Occoured");
              } else {
                final userData = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await _profilePicker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          await UserController().updateProfilePic(
                            File(image.path),
                          );
                          setState(() {});
                        }
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(userData!.profileUrl),
                      ),
                    ),
                    Text("Email: ${userData.gmail}"),
                    Text("Username: ${userData.fullName}"),
                    Text("Joined From: ${userData.joinedAt.toString()}"),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
