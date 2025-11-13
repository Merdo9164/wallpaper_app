import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../services/wallpaper_api.dart';
import 'full_screen_page.dart';


class HomePage extends StatefulWidget{
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final api = WallpaperApi(baseUrl: 'http://192.168.1.104:5266');
    late Future<List<Wallpaper>> wallpapersFuture;

    @override
    void initState(){
        super.initState();
        wallpapersFuture = api.getAllWallpapers();
    }
    
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(title: Text('Wallpapers')),
            body : FutureBuilder<List<Wallpaper>>(
                future : wallpapersFuture,
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
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // iki kolon
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                                childAspectRatio: 0.7,
                            ),
                            itemCount: wallpapers.length,
                            itemBuilder: (context, index){
                                final wallpaper = wallpapers[index];
                                final heroTag = 'wallpaper-${wallpaper.id}';
                                return GestureDetector(
                                    onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenPage(wallpaper: wallpaper),
                                            ),
                                        );
                                    },
                                    child : Hero(
                                        tag : heroTag, // (liste ve detay sayfasındaki) yumuşak geçiş animasyonu oluşur
                                        child : ClipRRect( // köşeleri yuvarlat
                                            borderRadius : BorderRadius.circular(12),
                                            child : Image.network(
                                                wallpaper.imageUrl!,
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context,child, progress){
                                                    if ( progress == null) return child;
                                                    return Center (child : CircularProgressIndicator());
                                                },
                                                errorBuilder : (context , error , stackTrace){
                                                    return const Center(
                                                        child : Icon(Icons.broken_image , size: 48),
                                                    );
                                                },
                                            ),
                                        ),
                                    ),
                                );
                            },
                        );
                    }
                },
            ),
        );
    }
    
}
