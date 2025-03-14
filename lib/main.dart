import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CookBookScreen(),
    );
  }
}

class CookBookScreen extends StatefulWidget {
  @override
  _CookBookScreenState createState() => _CookBookScreenState();
}

class _CookBookScreenState extends State<CookBookScreen> {
  // Variáveis para controlar os checkboxes
  bool salgado = false;
  bool doce = false;
  bool agridoce = false;
  bool fit = false;
  bool saudavel = false;
  bool rapido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.book), // Ícone de livro
            SizedBox(width: 8), // Espaçamento
            Text('Cook Book'), // Título
          ],
        ),
        backgroundColor: Colors.brown[300], // Cor de fundo aproximada
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.brown[200], // Cor do card aproximada
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filtros',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CheckboxListTile(
                      title: Text('Salgado'),
                      value: salgado,
                      onChanged: (value) {
                        setState(() {
                          salgado = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Doce'),
                      value: doce,
                      onChanged: (value) {
                        setState(() {
                          doce = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Agridoce'),
                      value: agridoce,
                      onChanged: (value) {
                        setState(() {
                          agridoce = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Fit'),
                      value: fit,
                      onChanged: (value) {
                        setState(() {
                          fit = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Saudável'),
                      value: saudavel,
                      onChanged: (value) {
                        setState(() {
                          saudavel = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Rápido'),
                      value: rapido,
                      onChanged: (value) {
                        setState(() {
                          rapido = value!;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para "Criar"
                            print('Criar pressionado');
                          },
                          child: Text('Criar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para "Voltar"
                            print('Voltar pressionado');
                          },
                          child: Text('Voltar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Lógica para "Publicar"
                print('Publicar pressionado');
              },
              child: Text('Publicar'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Postar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}