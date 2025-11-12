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
            body : Center(
                child: Text('........'),
            ),
        );
    }
    
}
