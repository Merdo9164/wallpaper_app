import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/pages/home_page.dart';

enum Page{
  home,
  favorites,
  settings,
}

final pageProvider = StateProvider<Page>((ref) => Page.home);

class MainLayout extends ConsumerWidget{
  const MainLayout({super.key});


  Widget _getBodyContent(Page activePage){
    switch(activePage){
      case Page.home:
        return const HomePage();
      case Page.favorites:
        return const FavoritesPage();
      case Page.settings:
        return const SettingsPage();
    }
  }

  String _getTitle(Page activePage){
    switch(activePage){
      case Page.home:
        return 'Tüm Duvar Kağıtları';
      case Page.favorites:
        return 'Favorilerim';
      case Page.settings:
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

class AppDrawer extends ConsumerWidget{
  final Page activePage;
  const AppDrawer({required this.activePage, super.key});

  Widget _buildDrawerItem({
    required WidgetRef ref,
    required Page page,
    required IconData icon,
    required String title,
  }) {
    void selectPage(){
      ref.read(pageProvider.notifier).state = page;

      Navigator.of(ref.context).pop();
    }

    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: activePage==page,
      selectedTileColor: Colors.indigo.shade100,
      onTap: selectPage,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text('Menü', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _buildDrawerItem(ref: ref, page: Page.home, icon: Icons.home, title: 'Ana Sayfa'),
          _buildDrawerItem(ref: ref, page: Page.favorites, icon: Icons.favorite, title: 'Favorilerim'),
          _buildDrawerItem(ref: ref, page: Page.settings, icon: Icons.settings, title: 'Ayarlar'),
        ],
      ),
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