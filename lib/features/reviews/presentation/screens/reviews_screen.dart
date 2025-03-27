import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/dependancy_injection/dependancy_injection.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/admin_scaffold.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/routing/routes.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';
import 'package:restaurant_dashboard/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:restaurant_dashboard/features/reviews/presentation/widgets/review_liat.dart';
import 'package:restaurant_dashboard/features/reviews/presentation/widgets/reviews_container.dart';
import 'package:restaurant_dashboard/features/side_bar.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReviewsCubit>()..getReviews()..countReviews(),
      child: const ReviewsBody(),
    );
  }
}

class ReviewsBody extends StatelessWidget {
  const ReviewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    SideBarWidget sideBar = SideBarWidget();
    final adminScaffoldKey = GlobalKey<AdminScaffoldState>();
    return AdminScaffold(
        sideBar: sideBar.sideBarMenus(context, Routes.reviews),
        key: adminScaffoldKey,
        body: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            toolbarHeight: 68,
            backgroundColor: AppColors.white,
            leadingWidth: 30,
            leading: context.screenWidth < 377
                ? Center(
                    child: InkWell(
                      onTap: () {
                        adminScaffoldKey.currentState!.toggleSidebar();
                      },
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: const SvgIcon(
                        height: 20,
                        color: AppColors.textColor,
                        icon: ImageManager.drawerIcon,
                      ),
                    ),
                  )
                : const SizedBox(),
            titleSpacing: 5,
            title: const CustomText(
              text: 'Customer Reviews',
              color: AppColors.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: SizedBox(
                  width: 150,
                  height: 40,
                  child: DropDownTextField(
                    dropDownIconProperty: IconProperty(
                      icon: Icons.keyboard_arrow_down,
                      size: 24,
                      color: AppColors.textColor,
                    ),
                    textFieldDecoration: InputDecoration(
                      fillColor: AppColors.boldContainerColor,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColors.transparent,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColors.palePrimary,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColors.red,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColors.red,
                        ),
                      ),
                      hintText: 'ALL Reviews',
                      hintStyle: const TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: AppConstance.appFontName,
                      ),
                      errorStyle: const TextStyle(
                        color: AppColors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: AppConstance.appFontName,
                      ),
                    ),
                    clearOption: true,
                    clearIconProperty: IconProperty(color: Colors.green),
                    dropDownList: const [
                      DropDownValueModel(name: 'drinks', value: "value1"),
                      DropDownValueModel(name: 'food', value: "value2"),
                      DropDownValueModel(
                        name: 'sweets',
                        value: "value3",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: context.screenWidth < 500
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.boldContainerColor,
                            child: SvgIcon(
                              icon: ImageManager.search,
                              color: AppColors.textColor,
                              height: 20,
                            )),
                      )
                    : SizedBox(
                        width: 200,
                        child: CustomTextFormField(
                          borderColor: AppColors.containerColor,
                          hintText: 'Search',
                          titleFontSize: 12,
                          filledColor: AppColors.boldContainerColor,
                          prefixIcon: GestureDetector(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: SvgIcon(
                                icon: ImageManager.search,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 10),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: const Color.fromRGBO(115, 129, 141, 0.16),
                height: 1,
              ),
            ),
          ),
          body: BlocBuilder<ReviewsCubit, ReviewsState>(
            builder: (context, state) {
              final reviews = context.read<ReviewsCubit>().reviews;
              final reviewsCount = context.read<ReviewsCubit>().reviewsCount;
              if (state is ReviewsDataLoadingState) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primary,
                ));
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      ReviewsContainer(
                        reviewsCount: reviewsCount,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const CustomText(
                            text: 'Review List',
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              height: 1, // Thickness of the line
                              color:
                                  const Color.fromRGBO(115, 129, 141, 0.16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ReviewList(
                          reviews: reviews,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
