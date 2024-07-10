import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/error/dialoge_error.dart';
import 'package:wallapp/feature/category_screen/logic/cubit/category_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_button_add_sections.dart';

class SaveButtonWidget extends StatelessWidget {
  const SaveButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButtonAddSections(
      onTap: () async {
    var cubit = context.read<CategoryCubit>();

        if (cubit.categoryName.isEmpty) {
          showMessage(context, "Please add a category name");
          return;
        }

        if (cubit.categoryImage == null) {
          showMessage(context, "Please add a category image");
          return;
        }

        await cubit.saveCategory();
        if (cubit.viewState == ViewState.error) {
          if (context.mounted) {
            showMessage(context, cubit.message);
          }
          return;
        }

        if (cubit.viewState == ViewState.success) {
          if (context.mounted) {
            showMessage(context,
                "Category was successfully saved and available for use",
                isError: false);
          }
        }
      },
    );
  }
}
