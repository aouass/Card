import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE6E9ED),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.people, size: 40, color: Colors.black),
                    title: Text('Utilisateurs'),
                    subtitle: Text('281\n+55% than last week'),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: ListTile(
                    leading:
                        Icon(Icons.bar_chart, size: 40, color: Colors.blue),
                    title: Text('Les utilisateurs d\'aujourd\'hui'),
                    subtitle: Text('2,300\n+3% than last week'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Statistique d\'utilisation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(100),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 3),
                          FlSpot(1, 1),
                          FlSpot(2, 4),
                          FlSpot(3, 3),
                          FlSpot(4, 5),
                          FlSpot(5, 2),
                          FlSpot(6, 6),
                          FlSpot(7, 3),
                          FlSpot(8, 4),
                          FlSpot(9, 3),
                          FlSpot(10, 5),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 4,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
