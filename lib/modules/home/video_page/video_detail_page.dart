import 'package:app_cookbook/modules/home/video_page/full_screen_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:app_cookbook/models/video_model.dart';

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
    _controller = VideoPlayerController.network(widget.video.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goFullScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPlayer(videoUrl: widget.video.videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24), // espaço pro botão
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título + botão de voltar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.video.titulo,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Player com altura fixa
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 220,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: VideoPlayer(_controller),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                                child: AnimatedOpacity(
                                  opacity: _controller.value.isPlaying ? 0 : 1,
                                  duration: const Duration(milliseconds: 300),
                                  child: const Icon(
                                    Icons.play_circle_fill,
                                    size: 64,
                                    color: Colors.white70,
                                    shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: IconButton(
                                  icon: const Icon(Icons.fullscreen, color: Colors.white),
                                  onPressed: _goFullScreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 220,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),

                // Descrição e autor
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.video.titulo,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.video.descricao,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(widget.video.profileImage),
                        ),
                        title: Text(
                          widget.video.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE97777),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                          label: const Text(
                            "Voltar",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
