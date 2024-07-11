import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/error/dialoge_error.dart';
import 'package:wallapp/core/utils/widgets/build_app_bar.dart';
import 'package:wallapp/core/utils/widgets/custom_loading_widgets.dart';
import 'package:wallapp/feature/category_screen/logic/cubit/category_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_empty_widgets.dart';
import 'package:wallapp/feature/category_screen/widgets/category_screen_widgets/custom_body_category_screen_widget.dart';

class CategoryScreen extends StatelessWidget {
  final bool isAdmin;
  const CategoryScreen({
    Key? key,
    this.isAdmin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..getCategories(context),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoryError) {
            showMessage(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const CustomLoadingWidget();
          } else if (state is CategoryLoaded) {
            var categories = state.categories;
            if (categories.isEmpty) {
              return const CustomEmpetyWidgets(
                title: 'No Available Categories',
              );
            }
            return Scaffold(
              appBar: buildAppBar(title: const Text('Categories')),
              body: CustomBodyCategoryScreenWidgets(
                isAdmin: isAdmin,
                categories: categories,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
