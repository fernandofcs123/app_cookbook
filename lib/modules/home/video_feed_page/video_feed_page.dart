import 'package:app_cookbook/models/video_model.dart';
import 'package:app_cookbook/modules/home/video_page/video_detail_page.dart';
import 'package:app_cookbook/ui/video_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoFeedPage extends StatefulWidget {
  const VideoFeedPage({Key? key}) : super(key: key);

  @override
  State<VideoFeedPage> createState() => _VideoFeedPageState();
}

class _VideoFeedPageState extends State<VideoFeedPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchText = '';
  late Stream<QuerySnapshot> _feedStream;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() => _searchText = _searchCtrl.text.trim().toLowerCase());
    });
    _refreshFeed(); // Inicializa o stream
  }

  void _refreshFeed() {
    setState(() {
      _feedStream = FirebaseFirestore.instance
        .collection('videos')
        .orderBy('data', descending: true)
        .snapshots();
    });
  }

  Future<void> _handleRefresh() async {
    // Aguarda um pequeno tempo só para mostrar a animação
    await Future.delayed(const Duration(milliseconds: 500));
    _refreshFeed(); // Atualiza o stream
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _feedStream,
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text('Erro: ${snap.error}'));
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final videos = snap.data!.docs
            .map((doc) => VideoModel.fromDoc(doc))
            .where((v) {
              final lcTitle = v.titulo.toLowerCase();
              final lcDesc  = v.descricao.toLowerCase();
              return _searchText.isEmpty
                  || lcTitle.contains(_searchText)
                  || lcDesc.contains(_searchText);
            }).toList();

          return RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView.builder(
              itemCount: videos.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _buildSearchBar();

                final video = videos[index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoDetailPage(video: video),
                      ),
                    ),
                    child: VideoCard(video: video),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      color: const Color.fromRGBO(205, 175, 149, 1),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchCtrl,
          decoration: InputDecoration(
            hintText: "Pesquisar vídeos",
            prefixIcon: const Icon(Icons.search, color: Colors.black54),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
