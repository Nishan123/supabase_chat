import 'package:flutter/material.dart';
import 'package:supabase_chat/controller/user_controller.dart';
import 'package:supabase_chat/screens/chat_screen.dart';
import 'package:supabase_chat/screens/profile_screen.dart';
import 'package:supabase_chat/services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supabase Chat"),
        actions: [
          IconButton(
            onPressed: () {
              AuthServices().logOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
            },
            icon: Icon(Icons.person_rounded),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: UserController().getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error Occoured"));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatScreen(user: users[index],)),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.black38,
                    backgroundImage: NetworkImage(user.profileUrl),
                    radius: 20,
                  ),
                  title: Text(user.fullName),
                  subtitle: Text("Last message..."),
                  trailing: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
