import 'package:app_cookbook/modules/home/perfil_page/perfil_page.dart';
import 'package:app_cookbook/modules/home/publicar_page/publicar_page.dart';
import 'package:app_cookbook/modules/home/video_feed_page/video_feed_page.dart';
import 'package:app_cookbook/ui/appbar_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    VideoFeedPage(),
    PublicarPage(),
    PerfilPage(),
    // Center(child: Text('Perfil', style: TextStyle(fontSize: 20))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),

      body: _widgetOptions[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Text("📖", style: TextStyle(fontSize: 24)),
          label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow_outlined),
            label: 'Publicar',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
            width: 30,
            height: 30,
            child: Image.asset('assets/icons/perfil.png')
          ),
          label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown[700],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: const Color.fromRGBO(205, 175, 149, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}