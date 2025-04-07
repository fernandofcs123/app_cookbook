class VideoModel {
  final String profileImage;
  final String username;
  final String title;
  final int likes;
  final int comments;
  final int shares;

  VideoModel({
    required this.profileImage,
    required this.username,
    required this.title,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}