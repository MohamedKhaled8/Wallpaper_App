import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/widgets/custom_loading_widgets.dart';
import 'package:wallapp/feature/favorite_screend.art/logic/cubit/favorite_cubit.dart';
import 'package:wallapp/feature/favorite_screend.art/widgets/custom_body_favorite_screen_widgets.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..retrieveFavorite(),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const CustomLoadingWidget();
          } else if (state is FavoriteSuccess) {
            return const CustomBodyFavoriteScreenWidget();
          } else if (state is FavoriteError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
