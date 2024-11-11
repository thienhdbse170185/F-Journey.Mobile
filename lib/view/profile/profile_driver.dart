import 'package:f_journey/core/router.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileDriverWidget extends StatefulWidget {
  final String profileImageUrl;
  final String name;
  final String email;
  final int userId;
  const ProfileDriverWidget(
      {super.key,
      required this.profileImageUrl,
      required this.name,
      required this.email,
      required this.userId});

  @override
  State<ProfileDriverWidget> createState() => _ProfileDriverWidgetState();
}

class _ProfileDriverWidgetState extends State<ProfileDriverWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.go(RouteName.getStarted);
        }
      },
      child: Scaffold(
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
              // Your Trip Action Menu
              ListTile(
                leading: const Icon(Icons.travel_explore),
                title: const Text('Chuyến đi của bạn'),
                onTap: () {
                  // Navigate to the trip details screen
                  context.push(RouteName.tripHistoryDriver,
                      extra: widget.userId);
                },
              ),
              // Logout Action Menu
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Đăng xuất'),
                onTap: () async {
                  context.read<AuthBloc>().add(LogoutStarted());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
