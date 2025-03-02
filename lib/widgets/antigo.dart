import 'package:app_cookbook/models/video_model.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget{
  final VideoModel video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return Column(
      children: [
        Text(video.title),
      ],
    );
    
    
    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 20.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         height: 180,
    //         color: Colors.black,
    //         child: Center(
    //           child: Icon(Icons.play_arrow, size: 50, color: Colors.white,),
    //         ),
    //       ),
    //       SizedBox(height: 8),
    //       Row(
    //         children: [
    //           CircleAvatar(
    //             backgroundImage: NetworkImage(video.profileImage),
    //             radius: 12,
    //           ),
    //           SizedBox(width: 8),
    //           Text(
    //             video.username,
    //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //           ),
    //           SizedBox(height: 5),
    //           Row(
    //             children: [
    //               Icon(Icons.thumb_up_alt_outlined, size:20),
    //               SizedBox(width: 4),
    //               Text(video.likes.toString()),
    //               SizedBox(width: 20),
    //               Icon(Icons.mode_edit_outlined, size: 20),
    //               SizedBox(width: 4),
    //               Text(video.comments.toString()),
    //               SizedBox(width: 20),
    //               Icon(Icons.share_outlined, size: 20),
    //               SizedBox(width: 4),
    //               Text(video.shares.toString()),
    //         ],
    //       ),
    //     ],
    //   ),
    //     ],
    //   ),
    // );
  }
}