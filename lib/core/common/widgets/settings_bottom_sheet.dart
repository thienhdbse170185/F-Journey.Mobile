import 'package:f_journey/core/common/cubits/theme_cubit.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void showSettingsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Switch(
                  value: context.watch<ThemeCubit>().state,
                  onChanged: (bool value) {
                    // Directly toggle the theme from the Cubit
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sign Out',
                    style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutStarted());
                    context.pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
