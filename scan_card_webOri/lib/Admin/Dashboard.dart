import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xFFE6E9ED),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 40, top: 25),
              child: Row(
                children: [
                  Icon(
                    Icons.home_filled,
                    color: Color(0xFF7B809A),
                    size: 40,
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Dashboard",
                      style: TextStyle(color: Color(0xFF7B809A), fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: 130,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0xFF3E3D45),
                                        const Color(0xFF202020),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 16.0, top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Utilisateurs',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    // Utilisation de StreamBuilder pour afficher le nombre d'utilisateurs
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .where('role', isEqualTo: 'utilisateur')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text(
                                            '...',
                                            style: TextStyle(
                                              color: Color(0xFF344767),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }
                                        int userCount = snapshot.data!.docs.length;
                                        return Text(
                                          '$userCount',
                                          style: TextStyle(
                                            color: Color(0xFF344767),
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Color(0xFFF0F2F5)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  '+55%',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'que la semaine dernière',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      height: 130,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF21396A),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.stacked_bar_chart_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 16.0, top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Les utilisateurs d'aujourd'hui",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '2,300',
                                      style: TextStyle(
                                        color: Color(0xFF344767),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(color: Color(0xFFF0F2F5)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  '+3%',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'que la semaine dernière',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 45),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 330,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Statistique d’utilisation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 100,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.grey.withOpacity(0.2),
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 100,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  const months = [
                                    'Jan',
                                    'Feb',
                                    'Mar',
                                    'Apr',
                                    'May',
                                    'Jun',
                                    'Jul',
                                    'Aug',
                                    'Sep',
                                    'Oct',
                                    'Nov',
                                    'Dec'
                                  ];
                                  return Text(
                                    months[value.toInt() % 12],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 0.5,
                            ),
                          ),
                          minX: 0,
                          maxX: 11,
                          minY: 0,
                          maxY: 500,
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 100),
                                FlSpot(1, 200),
                                FlSpot(2, 150),
                                FlSpot(3, 250),
                                FlSpot(4, 300),
                                FlSpot(5, 450),
                                FlSpot(6, 400),
                                FlSpot(7, 300),
                                FlSpot(8, 200),
                                FlSpot(9, 250),
                                FlSpot(10, 350),
                                FlSpot(11, 400),
                              ],
                              isCurved: true,
                              color: Color(0xFF21396A),
                              barWidth: 3,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Color(0xFF21396A).withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
