import 'package:flutter/material.dart';

final String url =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/2020-02-17_Encontro_com_T%C3%A9cnico_do_Flamengo%2C_Jorge_Jesus_%28cropped%29.jpg/640px-2020-02-17_Encontro_com_T%C3%A9cnico_do_Flamengo%2C_Jorge_Jesus_%28cropped%29.jpg';
final String video1 =
    'https://www.shutterstock.com/image-photo/mix-food-assorted-table-600nw-2503190997.jpg';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image(width: 400, height: 100, image: NetworkImage(url)),
                    Column(
                      children: <Widget>[
                        Text('Jorge Jesus', style: TextStyle(fontSize: 50)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 179, 179, 172),
                            fixedSize: const Size(90, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Seguir'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: [
                        Image(
                          width: 400,
                          height: 400,
                          image: NetworkImage(video1),
                        ),
                        Text("Video 1", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          width: 400,
                          height: 400,
                          image: NetworkImage(video1),
                        ),
                        Text("Video 2", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          width: 400,
                          height: 400,
                          image: NetworkImage(video1),
                        ),
                        Text("Video 3", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: [
                        Image(
                          width: 400,
                          height: 400,
                          image: NetworkImage(video1),
                        ),
                        Text("Video 4", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          width: 400,
                          height: 400,
                          image: NetworkImage(video1),
                        ),
                        Text("Video 5", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          width: 400,
                          height: 400,
                          image: NetworkImage(video1),
                        ),
                        Text("Video 6", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
