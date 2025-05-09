import 'package:app_cookbook/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel video;

  const VideoDetailPage({Key? key, required this.video}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Inicializa o controller com a URL do Firestore
    _controller = VideoPlayerController.network(widget.video.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {}); 
      _controller.setLooping(false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhe do Vídeo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Player
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(_controller),
                        Center(
                          child: IconButton(
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              size: 64,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const AspectRatio(
                    aspectRatio: 16/9,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),

            const SizedBox(height: 16,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Título
                  Text(
                    widget.video.title,
                    style: const TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 8,),

                  // 3. Descrição
                  Text(
                    widget.video.descricao,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16,),

                  // 4. Quem postou
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.video.profileImage),
                      ),
                      const SizedBox(width: 12,),
                      Text(
                        widget.video.username,
                        style: const TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
