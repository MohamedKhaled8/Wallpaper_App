import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/utils/config/enum.dart';
import 'package:wallapp/core/utils/config/space.dart';
import '../../Admin/widgets/custom_wallpepr_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/core/utils/widgets/build_app_bar.dart';
import 'package:wallapp/feature/search_screen/logic/cubit/search_cubit.dart';
import 'package:wallapp/feature/category_screen/widgets/add_category_widges/custom_empty_widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      
      builder: (context, state) {
        var cubit = context.read<SearchCubit>();
        return Scaffold(
          appBar: buildAppBar(
              title: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            margin: EdgeInsets.symmetric(horizontal: 10.r),
            height: 30.h,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.r)),
            child: TextFormField(
              controller: cubit.searchController,
              onChanged: (value) {
                cubit.searchQuery = value;
              },
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  cubit.search(value);
                }
              },
              textInputAction: TextInputAction.search,
              style: const TextStyle(color: ColorsManger.white),
              decoration: const InputDecoration(
                  isDense: true, border: InputBorder.none),
            ),
          )),
          body: Padding(
            padding: EdgeInsets.all(10.0.r),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Simple Exaomde",
                        style: TextStyle(
                          color: ColorsManger.white,
                        ),
                      ),
                      verticalSpace(20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children:
                            List.generate(cubit.sampleSearch.length, (index) {
                          final data = cubit.sampleSearch[index];
                          final isSelected = index == cubit.selectedIndex;

                          return InkWell(
                            onTap: () {
                              cubit.updateSelectedIndex(index);
                              cubit.searchController.text = data;
                              cubit.searchQuery = data;
                              cubit.search(data);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0.r),
                              child: Container(
                                padding: EdgeInsets.all(8.0.r),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.transparent,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Text(
                                  data,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  child: cubit.searchList.isEmpty &&
                          cubit.viewState == ViewState.success
                      ? const CustomEmpetyWidgets(
                          title: "No categoryWallpaper wallpaper")
                      : Padding(
                          padding: EdgeInsets.all(10.0.r),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.5,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: cubit.searchList.length,
                            itemBuilder: (context, index) {
                              final wallpaper = cubit.searchList[index];
                              debugPrint(
                                  "Displaying wallpaper URL: ${wallpaper.wallpaperImage}");
                              return CustomWallpperWidgets(
                                onTap: () {},
                                url: wallpaper.wallpaperImage,
                              );
                            },
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
