import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticTab extends StatelessWidget {
  final double containerWidth;

  final Map<String, int> userActivity; 

  const StatisticTab(
      {Key? key, required this.containerWidth, required this.userActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Статистика настроений',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito-bold',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: containerWidth,
                height: 200,
                child: BarChart(
                  BarChartData(
                    titlesData: const FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    barGroups: [
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(toY: 3, color: Colors.orange),
                      ]),
                      BarChartGroupData(x: 2, barRods: [
                        BarChartRodData(toY: 2, color: Colors.orange),
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(toY: 5, color: Colors.orange),
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const Text(
                'Уровень стресса',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito-bold',
                ),
              ),
              const SizedBox(height: 20),
              _buildBarChart(),
              const SizedBox(height: 20),
              const Text(
                'График активности',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito-bold',
                ),
              ),
              const SizedBox(height: 20),
              _buildActivityChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return SizedBox(
      width: containerWidth,
      height: 200,
      child: BarChart(
        BarChartData(
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: [
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: 3, color: Colors.orange),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(toY: 2, color: Colors.orange),
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(toY: 5, color: Colors.orange),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityChart() {
    List<BarChartGroupData> barGroups = [];
    int index = 0;

    userActivity.forEach((date, count) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(toY: count.toDouble(), color: Colors.orange),
          ],
        ),
      );
      index++;
    });

    return SizedBox(
      width: containerWidth,
      height: 200,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      userActivity.keys.elementAt(value.toInt()),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: barGroups,
        ),
      ),
    );
  }
}
