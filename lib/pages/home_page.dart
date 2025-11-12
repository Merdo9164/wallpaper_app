import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../services/wallpaper_api.dart';

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
                        fina wallpapers = snapshot.data!;
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
                                return GestureDetector(
                                    onTap: (){
                                        // Tıklama
                                    },
                                    child: wallpaper.url != null
                                        ? Image.network(
                                            wallpaper.url!,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context,child, progress){
                                                if ( progress == null) return child;
                                                return Center (child : CircularProgressIndicator());
                                            },
                                            errorBuilder : (context , error , stackTrace){
                                                return Container(color: Colors.grey[300]);
                                            },
                                          )
                                        : Container(
                                            color: Colors.grey[300],
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
