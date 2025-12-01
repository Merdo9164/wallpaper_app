import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/layout/main_layout.dart';
import '../providers/wallpaper_providers.dart';
import 'splash_screen.dart';

class InitPage extends ConsumerWidget{
  const InitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final asyncValue = ref.watch(wallpapersFutureProvider);

    return asyncValue.when(
        loading: () => const SplashScreen(),

        error: (error , stack) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text(
              'Bir Hata Oluştu:\n$error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        data: (wallpapers){
          return MainLayout();
        },
      );
  }
}