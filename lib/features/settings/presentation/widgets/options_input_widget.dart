import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text_form_field.dart';
import 'package:restaurant_dashboard/features/settings/presentation/cubit/settings_cubit.dart';

import '../../../../app/widget/custom_text.dart';

class OptionInputWidget extends StatelessWidget {
  const OptionInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit=context.read<SettingsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Please Enter Your options',
              color: AppColors.primary,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            const SizedBox(height: 5),
            cubit.buildOptionsTextField(0),

            ...cubit.optionsTextField,
          ],
        );
      },
    );
  }
}
