import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../services/wallpaper_service.dart';

class FullScreenPage extends StatelessWidget {
  final Wallpaper wallpaper;

  const FullScreenPage({super.key, required this.wallpaper});

  Future<void> _setWallpaper(BuildContext context) async {
    try {
      final imagePath = await WallpaperService.downloadImage(wallpaper.imageUrl);

      await WallpaperService.setHomeWallpaper(imagePath);
      await WallpaperService.setLockScreenWallpaper(imagePath);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wallpaper ayarlandı!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final heroTag = 'wallpaper-${wallpaper.id}';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          wallpaper.title.isNotEmpty ? wallpaper.title : 'Wallpaper',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: heroTag,
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 1.0,
                maxScale: 4.0,
                child: wallpaper.imageUrl.isNotEmpty
                    ? Image.network(
                        wallpaper.imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white));
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Icon(Icons.broken_image,
                                  color: Colors.white, size: 64));
                        },
                      )
                    : const Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.white, size: 64),
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: FloatingActionButton.extended(
              onPressed: () => _setWallpaper(context),
              label: const Text('Set Wallpaper'),
              icon: const Icon(Icons.wallpaper),
            ),
          ),
        ],
      ),
    );
  }
}
