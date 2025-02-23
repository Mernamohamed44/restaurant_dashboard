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
  void initState() {
    context.read<SettingsCubit>().blackController.text = '#131313';
    context.read<SettingsCubit>().whiteController.text = '#FFFFFF';
    context.read<SettingsCubit>().primaryController.text = '#FFC600';
    context.read<SettingsCubit>().secondaryController.text = '#131313';
    context.read<SettingsCubit>().focusTextOnLightController.text = '#131313';
    context.read<SettingsCubit>().defaultTextOnLightController.text = '#131313';
    context.read<SettingsCubit>().disabledTextOnLightController.text =
        '#131313';
    context.read<SettingsCubit>().focusTextOnDarkController.text = '#FFFFFF';
    context.read<SettingsCubit>().defaultTextOnDarkController.text = '#FFFFFF';
    context.read<SettingsCubit>().disabledTextOnDarkController.text = '#FFFFFF';
    super.initState();
  }

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
                      controller: context.read<SettingsCubit>().blackController,
                      title: 'Black',
                      titleFontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: CustomTextFormField(
                      controller: context.read<SettingsCubit>().whiteController,
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
                      controller:
                          context.read<SettingsCubit>().primaryController,
                      title: 'Primary',
                      titleFontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 1,
                    child: CustomTextFormField(
                      controller:
                          context.read<SettingsCubit>().secondaryController,
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
                controller:
                    context.read<SettingsCubit>().focusTextOnLightController,
                title: 'Focus Text  on Light',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller:
                    context.read<SettingsCubit>().defaultTextOnLightController,
                title: 'Default Text  on Light',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller:
                    context.read<SettingsCubit>().disabledTextOnLightController,
                title: 'Diabled Text  on Light',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller:
                    context.read<SettingsCubit>().focusTextOnDarkController,
                title: 'Focus Text  on Dark',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller:
                    context.read<SettingsCubit>().defaultTextOnDarkController,
                title: 'Default Text  on Dark',
                titleFontSize: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller:
                    context.read<SettingsCubit>().disabledTextOnDarkController,
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
