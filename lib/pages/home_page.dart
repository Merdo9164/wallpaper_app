import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/wallpaper_grid_item.dart';
import '../models/wallpaper.dart';
import '../services/wallpaper_api.dart';



class HomePage extends StatelessWidget{
     HomePage({super.key});

    final api = WallpaperApi(baseUrl: 'https://wagaxis.com');

   @override
    Widget build(BuildContext context){
      
        return Scaffold(
            appBar: AppBar(title: Text('Wallpapers')),
            body : FutureBuilder<List<Wallpaper>>(
                future : api.getAllWallpapers(),
                builder : (context , snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                    }else if (snapshot.hasError){
                        return Center(child: Text('Error: ${snapshot.error}'));
                    }else if (!snapshot.hasData || snapshot.data!.isEmpty){
                        return Center(child: Text('No wallpapers found'));
                    }else {
                        final wallpapers = snapshot.data!;
                        
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
                },
            ),
        );
    }
}

    
    

