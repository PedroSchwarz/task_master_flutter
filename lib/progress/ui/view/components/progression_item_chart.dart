import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class ProgressionItemChart<T> extends StatelessWidget {
  const ProgressionItemChart({required this.items, required this.builder, this.height, this.width, super.key});

  final List<T> items;
  final PieChartSectionData Function(T) builder;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      width: width ?? 25,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(enabled: false),
          startDegreeOffset: 180,
          borderData: FlBorderData(show: false),
          sectionsSpace: 1,
          centerSpaceRadius: 5,
          sections:
              items.map((item) {
                return builder(item);
              }).toList(),
        ),
      ),
    );
  }
}
