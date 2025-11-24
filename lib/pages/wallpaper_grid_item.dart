import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/wallpaper.dart';
import 'full_screen_page.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';



class WallpaperGridItem extends StatelessWidget{
  final Wallpaper wallpaper;

  const WallpaperGridItem({super.key , required this.wallpaper});

 @override
  Widget build(BuildContext context){
    final heroTag = 'wallpaper-${wallpaper.id}';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
           MaterialPageRoute(
            builder: (_) => FullScreenPage(wallpaper: wallpaper),
            ),
           );
      },
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            key: ValueKey(wallpaper.id), // Hero ile birlikte cache’yi korur
            imageUrl: wallpaper.imageUrl,
            cacheManager: DefaultCacheManager(),
            fit: BoxFit.cover,
            placeholder: (context , url )=> 
                const SizedBox.shrink(),
            errorWidget: (context, url , error) =>
                const Icon(Icons.broken_image , size: 48),
            fadeInDuration: Duration.zero,
          ),
        ),
      ),
    );
  }

}
