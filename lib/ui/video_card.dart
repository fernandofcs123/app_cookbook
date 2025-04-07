import 'package:app_cookbook/models/video_model.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final VideoModel video;

  const VideoCard({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(video.profileImage),
                ),
                const SizedBox(width: 10),
                Text(
                  video.username,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 180,
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