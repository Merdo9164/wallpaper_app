import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:wallpaper_app/pages/init_page.dart';

void main() async {
  const envFile = kReleaseMode ? '.env.prod' : '.env';

  await dotenv.load(fileName: envFile);

  
  runApp( 
    const ProviderScope(child: MyApp()),
     );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpaper App',
      home :  InitPage(),
    );
  }
}