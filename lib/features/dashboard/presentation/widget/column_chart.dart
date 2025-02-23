import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnCart extends StatelessWidget {
  ColumnCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 385,
      decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(12)),
      child: SfCartesianChart(
        title: const ChartTitle(
          text: 'Daily User Visits',
          alignment: ChartAlignment.near,
          textStyle: TextStyle(
            color: AppColors.grey73818D, // Change title text color
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(
            color: AppColors.grey73818D99, // Change x-axis text color
            fontSize: 12,
          ),
        ),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(
            color: AppColors.grey73818D99, // Change x-axis text color
            fontSize: 12,
          ),
        ),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(
          enable: true,
        ),
        series: [
          StackedColumnSeries<ChartData, String>(
            name: 'Visitors per day',
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            dataSource: _chartData,
            xValueMapper: (ChartData sales, _) => sales.month,
            yValueMapper: (ChartData sales, _) => sales.value1,
            dataLabelSettings: const DataLabelSettings(
              isVisible: false,
            ),
            width: 0.4,
            // Adjust column width (reduce for more spacing)
            spacing: 0.3,
          ),
        ],
      ),
    );
  }

  final List<ChartData> _chartData = [
    ChartData('14/11', 120, 20),
    ChartData('15/11', 200, 25),
    ChartData('16/11', 150, 30),
    ChartData('17/11', 70, 10),
    ChartData('18/11', 100, 15),
    ChartData('19/11', 130, 15),
    ChartData('20/11', 130, 15),
    ChartData('21/11', 130, 15),
  ];
}

class ChartData {
  final String month;
  final double value1;
  final double value2;
  final Color color = AppColors.grey73818D99;

  ChartData(this.month, this.value1, this.value2);
}
