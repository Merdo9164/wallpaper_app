import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/wallpaper_grid_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/wallpaper_providers.dart';



class HomePage extends ConsumerWidget{
     const HomePage({super.key});


   @override
    Widget build(BuildContext context , WidgetRef ref){

        final wallpapersAsyncValue = ref.watch(wallpapersFutureProvider);
      
        return Scaffold(
            appBar: AppBar(title: Text('Wallpapers')),
            body : wallpapersAsyncValue.when(
                 loading: () => const Center(child: CircularProgressIndicator()),
                 
                 error: (error ,stackTrace) =>Center(child: Text('Error: $error')),

                 data: (wallpapers){
                      if(wallpapers.isEmpty){
                        return const Center(child: Text('No wallpapers found'));
                      }

                      return GridView.builder(
                            key: const PageStorageKey('wallpaper_grid'), // sayfa dönüşlerinde rebuild engelle
                            padding: const EdgeInsets.all(8),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // iki kolon
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                                childAspectRatio: 0.7,
                            ),
                            itemCount: wallpapers.length,
                            addAutomaticKeepAlives: true,
                            cacheExtent: 3000,
                            itemBuilder: (context, index){
                                final wallpaper =wallpapers[index];
                                return WallpaperGridItem(
                                    key: ValueKey(wallpaper.id), // rebuild sonrası cached image korunacak
                                    wallpaper: wallpaper);
                            },
                        );
                 }
            ),
        );
    }
}

    
    

