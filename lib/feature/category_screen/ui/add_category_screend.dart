import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/widgets/build_app_bar.dart';
import 'package:wallapp/feature/Admin/logic/cubit/admin_cubit.dart';
import 'package:wallapp/core/utils/widgets/custom_loading_widgets.dart';
import 'package:wallapp/feature/category_screen/logic/cubit/category_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/add_category_content_widgets.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Scaffold(
            appBar: buildAppBar(title: const Text("Add Category")),
            body: state is AdminLoading
                ? const CustomLoadingWidget()
                : const AddCategoryContentWidget());
      },
    );
  }
}
