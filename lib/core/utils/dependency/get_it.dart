import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallapp/feature/splash_screen/logic/cubit/auth_cubit.dart';
import 'package:wallapp/core/utils/firebase/firebase_favorite_data_source.dart';
import 'package:wallapp/feature/setting/repository/setting_repository_imp.dart';
import 'package:wallapp/feature/home/data/repository/home_allpaper_repository.dart';
import 'package:wallapp/feature/download/data/repository/download_repository_imp.dart';
import 'package:wallapp/feature/favorite_screend.art/data/repository/favorite_repository_imp.dart';
import 'package:wallapp/feature/category_screen/data/repository/category_repository_category.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<WallpaperRepository>(WallpaperRepository());
  getIt.registerSingleton<CategoryRepositoryCategory>(
      CategoryRepositoryCategory());
  getIt.registerSingleton<FirebaseFavoriteDataSource>(
      FirebaseFavoriteDataSource());
  getIt.registerSingleton<SettingRepositoryImp>(SettingRepositoryImp());

  getIt.registerSingleton<FavoriteRepositoryImpl>(
      FavoriteRepositoryImpl(getIt<FirebaseFavoriteDataSource>()));
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerLazySingleton<DownloadRepositoryImp>(
      () => DownloadRepositoryImp());
  getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit());
}
