import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/helper/extension.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/image_manager.dart';
import 'package:restaurant_dashboard/app/widget/custom_button.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/app/widget/svg_icons.dart';

class SuperCategories extends StatefulWidget {
  SuperCategories({super.key});

  @override
  State<SuperCategories> createState() => _SuperCategoriesState();
}

class _SuperCategoriesState extends State<SuperCategories> {
  @override
  void initState() {
    categories;
    super.initState();
  }

  bool isClicked = false;
  TextEditingController itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Super Categories',
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          const SizedBox(
            height: 5,
          ),
          context.screenWidth > 500
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                          categories.length,
                          (index) => CategoriesContainer(
                                number: categories[index].number,
                                text: categories[index].text,
                              )),
                      isClicked ? buildTextField() : const SizedBox(),
                      const SizedBox(
                        width: 5,
                      ),
                      buildNewButton()
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                        categories.length,
                        (index) => CategoriesContainer(
                              number: categories[index].number,
                              text: categories[index].text,
                            )),
                    const SizedBox(
                      height: 10,
                    ),
                    isClicked ? buildTextField() : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    buildNewButton()
                  ],
                )
        ],
      ),
    );
  }

  Widget buildNewButton() {
    return CustomButton(
      width: context.screenWidth > 500 ? 120 : double.infinity,
      height: 40,
      onTap: () {
        setState(() {
          isClicked = true;
          buildTextField();
          print(isClicked);
        });
      },
      fontColor: AppColors.primary,
      fontSize: 16,
      borderColor: AppColors.primary,
      borderRadius: 20,
      widget: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: AppColors.primary, size: 20),
          SizedBox(
            width: 5,
          ),
          Flexible(
              child: FittedBox(
                  child: CustomText(
                      fontWeight: FontWeight.w700,
                      text: 'New',
                      color: AppColors.primary)))
        ],
      ),
    );
  }

  List<CategoriesContainer> categories = [
    const CategoriesContainer(
      text: 'Untitled',
      number: '0',
    ),
    const CategoriesContainer(
      text: 'food',
      number: '7',
    ),
    const CategoriesContainer(
      text: 'Drinks',
      number: '3',
    ),
    const CategoriesContainer(
      text: 'sweets',
      number: '5',
    ),
  ];

  Widget buildTextField() {
    return SizedBox(
      width: context.screenWidth > 500 ? 120 : double.infinity,
      child: CustomTextFormField(
        textStyle: const TextStyle(fontSize: 12),
        controller: itemController,
        borderColor: AppColors.primary,
        //contentPadding: 5,
        borderRadius: 10,
        maxLines: 1,
        suffixIcon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print(itemController.text);
                setState(() {
                  categories.add(CategoriesContainer(
                      text: itemController.text, number: '4'));
                  itemController.clear();
                });
              },
              child: const CustomText(
                text: 'save',
                textAlign: TextAlign.justify,
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        title: '',
      ),
    );
  }
}

class CategoriesContainer extends StatelessWidget {
  const CategoriesContainer(
      {super.key, required this.text, required this.number});

  final String text;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            CustomText(
              text: text,
              color: AppColors.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 8,
              backgroundColor: AppColors.palePrimary,
              child: CustomText(
                text: number,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            ),
            context.screenWidth > 500
                ? const SizedBox(
                    width: 5,
                  )
                : const Spacer(),
            const SvgIcon(
              icon: ImageManager.dots,
              color: AppColors.textColor,
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
