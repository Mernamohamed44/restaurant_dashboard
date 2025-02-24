import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';

class ColorBrand extends StatefulWidget {
  const ColorBrand({super.key});

  @override
  State<ColorBrand> createState() => _ColorBrandState();
}

class _ColorBrandState extends State<ColorBrand> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomTextFormField(
                      controller: cubit.blackController,
                      title: 'Black',
                      titleFontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CustomTextFormField(
                      controller: cubit.whiteController,
                      title: 'White',
                      titleFontSize: 14,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomTextFormField(
                      controller: cubit.primaryController,
                      title: 'Primary',
                      titleFontSize: 14,
                      onChanged: (value) {
                        cubit.onChangePrimary();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: CustomTextFormField(
                      controller: cubit.secondaryController,
                      title: 'Secondary',
                      titleFontSize: 14,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: cubit.focusTextOnLightController,
                title: 'Focus Text  on Light',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: cubit.defaultTextOnLightController,
                title: 'Default Text  on Light',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: cubit.disabledTextOnLightController,
                title: 'Diabled Text  on Light',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: cubit.focusTextOnDarkController,
                title: 'Focus Text  on Dark',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: cubit.defaultTextOnDarkController,
                title: 'Default Text  on Dark',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: cubit.disabledTextOnDarkController,
                title: 'Diabled Text  on Dark',
                titleFontSize: 14,
              ),
            ],
          ),
        );
      },
    );
  }
}
