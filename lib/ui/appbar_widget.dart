import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarWidget({super.key, this.title = 'Cook 📖 Book'});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(205, 175, 149, 1),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: GoogleFonts.cinzel(
          fontSize: 24, 
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

          // title: SafeArea(
          //   child: Column(
          //     children: [
          //       const SizedBox(height: 10),
          //       const Text(
          //         'Cook 📖 Book',
          //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //       ),
          //       const SizedBox(height: 10),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //         child: SizedBox(
          //           height: 40,
          //           child: TextField(
          //             decoration: InputDecoration(
          //               hintText: "Pesquisar receitas...",
          //               prefixIcon: const Icon(Icons.search),
          //               border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.circular(12),
          //               ),
          //               contentPadding: const EdgeInsets.symmetric(vertical: 10),
          //               filled: true,
          //               fillColor: Colors.white,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),