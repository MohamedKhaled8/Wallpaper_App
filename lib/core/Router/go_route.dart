import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/feature/home/ui/home_screen.dart';
import 'package:wallapp/feature/Admin/ui/admin_screen.dart';
import '../../feature/wallpeper/ui/view_wall_page_screen.dart';
import 'package:wallapp/feature/setting/ui/setting_screen.dart';
import 'package:wallapp/feature/download/ui/download_screen.dart';
import 'package:wallapp/feature/search_screen/ui/serch_screen.dart';
import 'package:wallapp/feature/splash_screen/ui/splash_screen.dart';
import 'package:wallapp/feature/wallpeper/ui/add_wallpeper_Screen.dart';
import 'package:wallapp/feature/category_screen/ui/category_screen.dart';
import 'package:wallapp/feature/splash_screen/logic/cubit/auth_cubit.dart';
import '../../feature/on_barding_screen/logic/cubit/onboarding_cubit.dart';
import 'package:wallapp/feature/search_screen/logic/cubit/search_cubit.dart';
import 'package:wallapp/feature/on_barding_screen/ui/on_barding_screen.dart';
import 'package:wallapp/feature/favorite_screend.art/ui/favorite_screen.dart';
import 'package:wallapp/feature/category_screen/ui/view_category_screen.dart';
import 'package:wallapp/feature/category_screen/ui/add_category_screend.dart';
import 'package:wallapp/feature/category_screen/logic/cubit/category_cubit.dart';
import 'package:wallapp/feature/download/logic/cubit/download_wallpaper_cubit.dart';
import 'package:wallapp/feature/bottom_navigation_bar/ui/bottom_navigation_bar.dart';
import 'package:wallapp/feature/favorite_screend.art/logic/cubit/favorite_cubit.dart';
import '../../feature/bottom_navigation_bar/logic/cubit/bottom_navigation_bar_cubit.dart';

abstract class AppRouter {
  static const onBardingScreen = '/on_boarding';
  static const bottomNavigationBar = '/bottomNavigationBar';
  static const homeScreen = '/homeScreen';
  static const adminScreen = '/homeScreen';
  static const addCategoryScreen = '/addCategoryScreen';
  static const addWallpeperScreen = '/addWallpeperScreen';
  static const categoryScreen = '/categoryScreen';
  static const viewCategoryScreen = '/viewCategoryScreen';
  static const searchScreen = '/searchScreen';
  static const favoriteScreen = '/favoriteScreen';
  static const settingsScreen = '/settingsScreen';
  static const downloadScreen = '/downloadScreen';
  static const viewWallPageScreen = '/viewWallPageScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit()..checkIfLoggedIn(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: onBardingScreen,
        builder: (context, state) => BlocProvider(
          create: (_) => OnboardingCubit(),
          child: const OnBardingScreen(),
        ),
      ),
      GoRoute(
        path: bottomNavigationBar,
        builder: (context, state) => BlocProvider(
          create: (context) => BottomNavigationBarCubit(),
          child: const BottomNavigationBarScreen(),
        ),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: adminScreen,
        builder: (context, state) => const AdminScreen(),
      ),
      GoRoute(
        path: addCategoryScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => CategoryCubit(),
          child: const AddCategoryScreen(),
        ),
      ),
      GoRoute(
        path: addWallpeperScreen,
        builder: (context, state) => const AddWallpeperScreen(),
      ),
      GoRoute(
        path: favoriteScreen,
        builder: (context, state) => const FavoriteScreen(),
      ),
      GoRoute(
        path: settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: downloadScreen,
        builder: (context, state) {
          final isAutoChangeSelection = (state.extra ?? false) as bool;
          return BlocProvider(
            create: (context) =>
                DownloadWallpaperCubit(isLocalFile: false, url: '')
                  ..getDownloadFiles(),
            child: DownloadScreen(isAutoChangeSelection: isAutoChangeSelection),
          );
        },
      ),
      GoRoute(
        path: viewWallPageScreen,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final id = data['wallpaperId'] as String;
          return BlocProvider(
            create: (context) => FavoriteCubit()..retrieveFavoriteById(id),
            child: ViewWallPageScreen(
              url: data['wallpaperUrl'] as String,
              categoryName: data['categoryName'] as String? ?? '',
              wallpaperId: data['wallpaperId'] as String,
              showFaouriteIcon: data['show_icon'] as bool? ?? false,
              isLocalFile: data['isLocalFile'] as bool? ?? false,
            ),
          );
        },
      ),
      GoRoute(
        path: searchScreen,
        builder: (context, state) {
          final query = state.uri.queryParameters['query'] ?? '';
          return BlocProvider(
            create: (context) => SearchCubit()..search(query),
            child: const SearchScreen(),
          );
        },
      ),
      GoRoute(
          path: categoryScreen,
          builder: (context, state) {
            final isAdmin = (state.extra as Map)['is_admin'];
            return CategoryScreen(
              isAdmin: isAdmin,
            );
          }),
      GoRoute(
          path: viewCategoryScreen,
          builder: (context, state) {
            final data = (state.extra as Map);

            return BlocProvider(
              create: (context) => CategoryCubit()
                ..fechWallpaperByCategory(data['categoryName']),
              child: ViewCategoryScreen(
                categoryName: data['categoryName'],
              ),
            );
          }),
    ],
  );
}
