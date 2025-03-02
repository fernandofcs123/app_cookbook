import 'package:app_cookbook/screens/video_feed_page.dart';
import 'package:flutter/material.dart';
import 'screens/video_feed_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cook Book',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    VideoFeedPage(),
    Center(child: Text('Publicar Receita', style: TextStyle(fontSize: 20))),
    Center(child: Text('Perfil', style: TextStyle(fontSize: 20))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(205, 175, 149, 1),
          elevation: 0,
          title: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Cook 📖 Book',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Pesquisar receitas...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

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
