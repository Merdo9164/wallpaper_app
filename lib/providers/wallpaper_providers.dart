import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wallpaper.dart';
import '../services/wallpaper_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl =dotenv.env['BASE_URL'] ?? '';

final api = WallpaperApi(baseUrl: baseUrl);

final wallpaperApiProvider = Provider((ref)=>api);

final wallpapersFutureProvider = FutureProvider<List<Wallpaper>>((ref) async{
  final apiService = ref.watch(wallpaperApiProvider);

  return apiService.getAllWallpapers();
});