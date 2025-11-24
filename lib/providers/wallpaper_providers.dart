import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wallpaper.dart';
import '../services/wallpaper_api.dart';

final api = WallpaperApi(baseUrl: 'https://wagaxis.com');

final wallpaperApiProvider = Provider((ref)=>api);

final wallpapersFutureProvider = FutureProvider<List<Wallpaper>>((ref) async{
  final apiService = ref.watch(wallpaperApiProvider);

  return apiService.getAllWallpapers();
});