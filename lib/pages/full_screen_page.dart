import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../services/wallpaper_service.dart';

class FullScreenPage extends StatelessWidget {
  final Wallpaper wallpaper;

  const FullScreenPage({super.key, required this.wallpaper});

  Future<void> _setWallpaper(BuildContext context , int target) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final imagePath = await WallpaperService.downloadImage(wallpaper.imageUrl);

      if (target == 0) {
        await WallpaperService.setLockScreenWallpaper(imagePath);  // kilit ekranına uygula
      } else if (target == 1) {
        await WallpaperService.setHomeWallpaper(imagePath);     // Ana Ekrana uygula
      } else {
        await WallpaperService.setHomeWallpaper(imagePath);       // her ikisinede uygula
        await WallpaperService.setLockScreenWallpaper(imagePath);
      }

      messenger.showSnackBar(
        const SnackBar(content: Text('Wallpaper başarıyla uygulandı!')),
       );
      }
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }
// snackbar gösterim

  void _showOptions (BuildContext context){
    showModalBottomSheet(
      context: context,
      builder : (_){
        return SafeArea(
          child : Column(
            mainAxisSize : MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Kilit ekranı olarak belirle'),
                onTap : (){
                  Navigator.pop(context);
                  _setWallpaper(context , 0);
                },
              ),
              ListTile(
                title: const Text('Ana ekran olarak belirle'),
                onTap: () {
                  Navigator.pop(context);
                  _setWallpaper(context,1);
                },
              ),
              ListTile(
                title: const Text('Her ikisi olarak ayarla'),
                onTap: () {
                  Navigator.pop(context);
                  _setWallpaper(context, 2);
                },
              ),
            ],
          ),
        );
      },
    );
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
                    ? CachedNetworkImage(
                        imageUrl: wallpaper.imageUrl,
                        fadeInDuration: Duration.zero,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ), 
                        errorWidget: (context,url,error) =>const Center(
                          child: Icon(Icons.broken_image , color: Colors.white,size: 64),
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.white, size: 64),
                      ),
              ),
            ),
          ),
          // Alt orta buton
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 50), // ekranın kenarlarından boşluk 
              child : ElevatedButton(
                style : ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.7),  // yarı şeffaf beyaz
                  padding: const EdgeInsets.symmetric(vertical: 15), // yüksekliği arttır
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // köşeleri yuvarlat
                  ),
                ),
                onPressed: () => _showOptions(context),
                child : const Text('Uygula',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
