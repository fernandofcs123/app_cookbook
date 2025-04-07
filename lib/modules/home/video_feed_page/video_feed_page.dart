import 'package:app_cookbook/models/video_model.dart';
import 'package:app_cookbook/ui/video_card.dart';
import 'package:flutter/material.dart';

class VideoFeedPage extends StatelessWidget {
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
      username: "Amadeu", 
      title: "Pamonha de milho",
      likes: 41, 
      comments: 2, 
      shares: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(205, 175, 149, 1),
            padding: const EdgeInsets.fromLTRB(15,5,15,20),
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Pesquisa",
                  border: InputBorder.none,
                  icon: const Icon(Icons.search, color: Colors.black54,),
                ),
                onChanged: (value) {

                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                children: [
                  const SizedBox(height: 15),
                  Column(
                    children: videos.map((video) => VideoCard(video: video)).toList(),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}