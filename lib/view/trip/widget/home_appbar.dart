import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 5); // Tăng chiều cao của AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          child: Icon(
            Icons.qr_code_scanner_rounded,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          onTap: () {
            // Hành động cho nút menu
          },
        ),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Màu shadow
              spreadRadius: 1, // Độ lan tỏa của shadow
              blurRadius: 4, // Độ mờ của shadow
              offset: const Offset(0, 2), // Độ lệch của shadow
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm địa điểm',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // Hành động cho nút yêu thích
              },
            ),
          ],
        ),
      ),
    );
  }
}
