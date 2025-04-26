import 'package:app_cookbook/models/video_model.dart';
import 'package:flutter/material.dart';

class VideoPerfilCard extends StatelessWidget {
  final VideoModel video;

  const VideoPerfilCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 0,
      // color: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.black12,
              child: const Icon(Icons.play_arrow, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              video.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thumb_up_alt_outlined, size: 20),
                    const SizedBox(width: 5),
                    Text(video.likes.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.comment_outlined, size: 20),
                    const SizedBox(width: 5),
                    Text(video.comments.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.share, size: 20),
                    const SizedBox(width: 5),
                    Text(video.shares.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}