import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:restaurant_dashboard/app/utils/constance.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DevicesAndPlatform extends StatelessWidget {
  DevicesAndPlatform({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(12)),
      child: SfCircularChart(
        title: const ChartTitle(
            alignment: ChartAlignment.near,
            text: 'Devices / Platforms',
            textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                fontFamily: AppConstance.appFontName,
                color: AppColors.textColor)),
        legend: MediaQuery.of(context).size.width > 1000
            ? const Legend(
                isVisible: true,
              )
            : const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CircularSeries>[
          DoughnutSeries<PieChartData, String>(
            dataSource: _pieChartData,
            xValueMapper: (PieChartData data, _) => data.month,
            yValueMapper: (PieChartData data, _) => data.value1,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            pointColorMapper: (PieChartData data, _) => data.color,
            innerRadius: "45",
            radius: "30",
          ),
        ],
      ),
    );
  }

  final List<PieChartData> _pieChartData = [
    PieChartData('Tablet', 30, 20, AppColors.primary),
    PieChartData('Tablet', 40, 25, const Color(0xff73818D)),
    PieChartData('Desktop', 20, 30, const Color(0xff0993A7)),
  ];
}

class PieChartData {
  final String month;
  final double value1;
  final double value2;
  final Color color;

  PieChartData(this.month, this.value1, this.value2, this.color);
}
