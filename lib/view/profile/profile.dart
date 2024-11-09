import 'package:f_journey/core/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileWidget extends StatefulWidget {
  final String profileImageUrl;
  final String name;
  final String email;
  const ProfileWidget(
      {super.key,
      required this.profileImageUrl,
      required this.name,
      required this.email});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.profileImageUrl),
            ),
            const SizedBox(height: 16),
            // Name
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Email
            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Đăng xuất'),
              onTap: () async {
                // Perform logout action
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                context.go(RouteName.getStarted);
              },
            ),
          ],
        ),
      ),
    );
  }
}
