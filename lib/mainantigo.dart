import 'package:app_cookbook/screens/video_feed_page.dart';
import 'package:flutter/material.dart';

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
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color.fromRGBO(205, 175, 149, 1),
      //   ),
      //   useMaterial3: true,
      // ),
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

  // Lista de telas que serão mostradas ao alternar na Navigation Bar
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Página Inicial', style: TextStyle(fontSize: 20))),
    Center(child: Text('Receitas', style: TextStyle(fontSize: 20))),
    Center(child: Text('Configurações', style: TextStyle(fontSize: 20))),
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
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(205, 175, 149, 1),
          elevation: 0,
          title: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10), 
              const Text(
                'Cook 📖 Book',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold
                ),
              ),
              
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),

                child:SizedBox(
                  height: 40,
                  child: TextField(
                  decoration: InputDecoration(
                    hintText: "Pesquisar receitas...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
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

      
    body: _widgetOptions[_selectedIndex], // Exibe o conteúdo da página ativa
    bottomNavigationBar: BottomNavigationBar(
      iconSize: 30,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Text("📖", style: TextStyle(fontSize: 24)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
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
      selectedItemColor: Colors.brown[700], // Cor do item selecionado
      unselectedItemColor: Colors.grey[600],
      backgroundColor: const Color.fromRGBO(205, 175, 149, 1), // Cor dos itens não selecionados
      onTap: _onItemTapped,
    ),
  );
}
}

