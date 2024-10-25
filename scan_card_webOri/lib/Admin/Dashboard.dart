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
          Row(
            children: [
              Expanded(
                child: Container(
                    color: Colors.white,
                    width: 200, // largeur du conteneur
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFF3E3D45),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ajoute l'icône centrée dans le conteneur
                            Icon(
                              Icons
                                  .person_pin, // changez l'icône selon vos besoins
                              color: Colors.white, // couleur de l'icône
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              const SizedBox(width: 16),
              const Expanded(
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
