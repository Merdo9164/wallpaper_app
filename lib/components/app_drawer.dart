import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_app/layout/main_layout.dart';



class AppDrawer extends ConsumerWidget{
  final AppScreen activePage;
  const AppDrawer({required this.activePage, super.key});

  Widget _buildDrawerItem({
    required WidgetRef ref,
    required AppScreen page,
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
          _buildDrawerItem(ref: ref, page: AppScreen.home, icon: Icons.home, title: 'Ana Sayfa'),
          _buildDrawerItem(ref: ref, page: AppScreen.favorites, icon: Icons.favorite, title: 'Favorilerim'),
          _buildDrawerItem(ref: ref, page: AppScreen.settings, icon: Icons.settings, title: 'Ayarlar'),
        ],
      ),
    );
  }
}