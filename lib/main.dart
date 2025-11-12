import 'package:flutter/material.dart';
import 'models/wallpaper.dart';
import 'services/wallpaper_api.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final api = WallpaperApi(baseUrl: 'http://192.168.1.104:5266');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Wallpapers')),
        body: FutureBuilder<List<Wallpaper>>(
          future: api.getAllWallpapers(),
          builder: (context ,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child:CircularProgressIndicator());
            }else if(snapshot.hasError){
              return Center(child: Text('Error: ${snapshot.error}'));
            }else if (snapshot.hasData){
              final wallpapers = snapshot.data!;
              return ListView.builder(
                itemCount: wallpapers.length,
                itemBuilder: (context, index){
                  final wallpaper = wallpapers[index];
                  return ListTile(
                    title: Text(wallpaper.title),
                    leading: Image.network(wallpaper.url),
                  );
                },
              );
            }else {
              return Center(child: Text('No wallpapers found'));
            }
          },
        ),
      ),
    );
  }
}
