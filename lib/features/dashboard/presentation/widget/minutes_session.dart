import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/widget/custom_text.dart';
import 'package:speedometer_chart/speedometer_chart.dart';

class MinutesSession extends StatelessWidget {
  const MinutesSession({super.key});

  @override
  Widget build(BuildContext context) {
    double value = 1.43;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SpeedometerChart(
            dimension: 150,
            value: value,
            pointerColor: Colors.white,
            maxValue: 5,
            valueWidget: const Text(
              '1.43',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
            graphColor: const [
              Color.fromRGBO(255, 255, 255, .5),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
          const CustomText(
            text: 'Average Minutes per session',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
