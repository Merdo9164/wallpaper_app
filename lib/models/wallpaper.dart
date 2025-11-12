class Wallpaper {
  final String id;
  final String title;
  final String url;

  Wallpaper({required this.id, required this.title, required this.url});

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
