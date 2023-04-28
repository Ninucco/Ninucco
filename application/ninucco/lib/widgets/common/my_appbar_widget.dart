import 'package:flutter/material.dart';

class MyAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const MyAppbarWidget({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon:
            const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        titleText,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
