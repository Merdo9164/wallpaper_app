class Wallpaper {
  final String id;
  final String title;
  final String imageUrl;

  Wallpaper({required this.id, required this.title, required this.imageUrl});

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
