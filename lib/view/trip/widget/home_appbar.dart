import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 5); // Tăng chiều cao của AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 2,
        title: Text(
          'Màn hình chính',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).primaryColor),
        ));
  }
}
