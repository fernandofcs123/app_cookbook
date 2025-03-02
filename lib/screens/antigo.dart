import 'package:app_cookbook/models/video_model.dart';
import 'package:app_cookbook/widgets/video_card.dart';
import 'package:flutter/material.dart';

class VideoFeedPage extends StatelessWidget{
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
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: videos.map((video) => VideoCard(video: video)).toList(),
      ),






      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        
        
        
      //   child: ListView(
      //     children: [
      //       SizedBox(height: 10),
      //       Center(
      //         child: Text(
      //           "Em Destaque",
      //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      //         ),
      //       ),
      //       SizedBox(height: 10),
      //       Column(
      //         children: videos.map(video) => VideoCard(video: video)).toList(),
      //       ),
      //   ),
      );
    }
  }