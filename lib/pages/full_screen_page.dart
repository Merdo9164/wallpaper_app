import 'package:flutter/material.dart';
import '../models/wallpaper.dart';

class FullScreenPage extends StatelessWidget{
    final Wallpaper wallpaper;

    const FullScreenPage({super.key , required this.wallpaper});

    @override
    Widget build (BuildContext context){
        final heroTag = 'wallpaper-${wallpaper.id}';

        return Scaffold(
            backgroundColor : Colors.black,
            appBar : AppBar(
                backgroundColor: Colors.black,
                elevation: 0 ,
                title Text(
                    (wallpaper.title.isNotEmpty) ? wallpaper.title : 'Wallpaper',
                    style : const TextStyle(color: Colors.white),
                ),
                iconTheme : const IconThemeData(color : Colors.white),
            ),
            body : Center(
                child: Hero( // tag olarak wallpaper.id kullanıyoruz; böylece listeden geçişte animasyon olur.
                    tag : heroTag,
                    child : InteractiveViewer( // pinch-to-zoom ve pan sağlar
                        panEnabled: true,
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: (wallpaper.url.isNotEmpty)
                            ? Image.network(
                                wallpaper.url,
                                fit : BoxFit.contain,
                                loadingBuilder : (context , child , progress){
                                    if(progress == null) return child;
                                    return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder : (context , error , stackTrace){
                                    return const Center(
                                        child : Icon(Icons.broken_image , color : Colors.white , size: 64),
                                    );
                                },
                            )
                          : const Center(
                            child: Icon(Icons.broken_image, color: Colors.white , size: 64),
                        ),
                    ),
                ),
            ),
        );
    }
}