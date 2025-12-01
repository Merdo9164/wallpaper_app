import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/pages/home_page.dart';
import 'package:wallpaper_app/components/app_drawer.dart';

enum AppScreen{
  home,
  favorites,
  settings,
}

final pageProvider = StateProvider<AppScreen>((ref) => AppScreen.home);

class MainLayout extends ConsumerWidget{
  const MainLayout({super.key});


  Widget _getBodyContent(AppScreen activePage){
    switch(activePage){
      case AppScreen.home:
        return const HomePage();
      case AppScreen.favorites:
        return const FavoritesPage();
      case AppScreen.settings:
        return const SettingsPage();
    }
  }

  String _getTitle(AppScreen activePage){
    switch(activePage){
      case AppScreen.home:
        return 'Tüm Duvar Kağıtları';
      case AppScreen.favorites:
        return 'Favorilerim';
      case AppScreen.settings:
        return 'Ayarlar';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePage = ref.watch(pageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(activePage)),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),

      drawer: AppDrawer(activePage: activePage),

      body: _getBodyContent(activePage),
    );
  }
}

class FavoritesPage extends StatelessWidget{
  const FavoritesPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite,size: 48, color: Colors.pink),
        Text('Favori Duvar Kağıtları Listesi'),
      ],
    ));
  }
}

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.settings,size: 48, color: Colors.grey),
        Text('Ayarlar'),
      ],
    ));
  }
}