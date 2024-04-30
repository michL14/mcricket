import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title = "M'Cricket";

  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title,
            style: GoogleFonts.orbitron(
                textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ))),
        leading: IconButton(
          icon: Image.asset(
              'assets/images/logo.png'), // Remplacez le chemin par le chemin réel de votre image
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        centerTitle: true,
        elevation: 40,
        backgroundColor: Theme.of(context).colorScheme.primary);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
