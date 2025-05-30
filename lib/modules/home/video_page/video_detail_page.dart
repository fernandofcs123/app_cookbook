import 'package:app_cookbook/modules/home/video_page/full_screen_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:video_player/video_player.dart';
import 'package:app_cookbook/models/video_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel video;
  const VideoDetailPage({super.key, required this.video});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _descricaoExpandida = false;

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
        builder: (context) =>
            FullScreenVideoPlayer(videoUrl: widget.video.videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(205, 175, 149, 1),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
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
                                    shadows: [
                                      Shadow(blurRadius: 10, color: Colors.black)
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: IconButton(
                                  icon: const Icon(Icons.fullscreen,
                                      color: Colors.white),
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
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _descricaoExpandida = !_descricaoExpandida;
                          });
                        },
                        child: AnimatedCrossFade(
                          firstChild: Text(
                            widget.video.descricao,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              height: 1.5,
                            ),
                          ),
                          secondChild: Text(
                            widget.video.descricao,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              height: 1.5,
                            ),
                          ),
                          crossFadeState: _descricaoExpandida
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ),

                      /// 🔽 Novo: busca a imagem de perfil e nome do autor
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('usuarios')
                            .doc(widget.video.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          final userData = snapshot.data?.data() as Map<String, dynamic>?;

                          final photoUrl = userData?['photoUrl'];
                          final nome = userData?['nome'] ?? widget.video.username;

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                                  ? NetworkImage(photoUrl)
                                  : const AssetImage('assets/icons/perfil.png') as ImageProvider,
                            ),
                            title: Text(
                              nome,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                      ),

                      const Divider(
                        height: 32,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      ExpansionTile(
                        title: const Text(
                          "Receita",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              widget.video.receita,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: const Text(
                          "Informações nutricionais",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: MarkdownBody(data: widget.video.nutricao),
                          ),
                        ],
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
