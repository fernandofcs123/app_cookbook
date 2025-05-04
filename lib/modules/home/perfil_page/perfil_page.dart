import 'package:app_cookbook/models/video_model.dart';
import 'package:app_cookbook/ui/elevated_button_widget.dart';
import 'package:app_cookbook/ui/video_perfil_card.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  PerfilPage({super.key});

  final List<VideoModel> videos = [
    VideoModel(
      profileImage: "https://via.placeholder.com/50", 
      username: "Jorge Jesus", 
      title: "Estrogonofe de carne", 
      likes: 100, 
      comments: 8, 
      shares: 2,
    ),
    VideoModel(
      profileImage: "https://via.placeholder.com/50", 
      username: "Jorge Jesus", 
      title: "Estrogonofe de carne", 
      likes: 100, 
      comments: 8, 
      shares: 2,
    ),
    VideoModel(
      profileImage: "https://via.placeholder.com/50", 
      username: "Jorge Jesus", 
      title: "Estrogonofe de carne", 
      likes: 100, 
      comments: 8, 
      shares: 2,
    ),
    VideoModel(
      profileImage: "https://via.placeholder.com/50", 
      username: "Jorge Jesus", 
      title: "Estrogonofe de frango", 
      likes: 100, 
      comments: 8, 
      shares: 2,
    ),
    VideoModel(
      profileImage: "https://via.placeholder.com/50", 
      username: "Jorge Jesus", 
      title: "Estrogonofe de frango", 
      likes: 100, 
      comments: 8, 
      shares: 2,
    ),
    VideoModel(
      profileImage: "https://via.placeholder.com/50", 
      username: "Jorge Jesus", 
      title: "Estrogonofe de frango", 
      likes: 100, 
      comments: 8, 
      shares: 2,
    ),
    VideoModel(
      profileImage: "https://via.placeholder.com/50", 
      username: "Amadeu", 
      title: "Pamonha de milho",
      likes: 41, 
      comments: 2, 
      shares: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                ),
                const SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Jorge Jesus",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4,),
                    const Text("@JorgeJ"),

                  ],
                ),
                const Spacer(),
                ElevatedbuttonWidget(nome: 'Seguir',metodo: () {},),
                
              ],
            ),
            
          ),
          const SizedBox(height: 24,),

          const Text(
            "Vídeos",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                for (int i =0; i < videos.length; i+=2)
                  Row(
                    children: [
                      Expanded(
                        child: VideoPerfilCard(video: videos[i]),
                      ),
                      const SizedBox(width: 8,),
                      if (i+1 < videos.length)
                        Expanded(
                          child: VideoPerfilCard(video: videos[i+1]),
                        )
                      else
                        const Expanded(child: SizedBox()),

                    ],
                  )
              ],
            ),
          ),
          const SizedBox(height: 24,)
        ],
      ),
    );
  }
}