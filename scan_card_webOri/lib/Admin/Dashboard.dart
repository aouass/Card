import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE6E9ED),
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
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Dashbord",
                    style: TextStyle(color: Color(0xFF7B809A), fontSize: 25),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 80,
              ),
              Container(
                height: 130,
                width: 350,
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
                                begin: Alignment
                                    .topCenter, // Début du gradient (en haut)
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(
                                      0xFF3E3D45), // Couleur avec opacité
                                  const Color(
                                      0xFF202020), // Couleur avec opacité
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, top: 8.0),
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
                              Text(
                                '281',
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
                    Container(
                      height: 1,
                      width: 350,
                      color: Color(0xFFF0F2F5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
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
              SizedBox(
                width: 150,
              ),
              Container(
                height: 130,
                width: 350,
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
                          padding: const EdgeInsets.only(right: 16.0, top: 8.0),
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
                    Container(
                      height: 1,
                      width: 350,
                      color: Color(0xFFF0F2F5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
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
            ],
          ),

          SizedBox(height: 45,),

          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              height: 330,
              width: 900, // Largeur fixe du conteneur
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
                  SizedBox(
                    width: 880, // Largeur du graphique
                    height: 270, // Hauteur du graphique
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
                            color: Color(0xFF3E5184),
                            barWidth: 2,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF3E5184).withOpacity(0.3),
                                  Color(0xFF3E5184).withOpacity(0),
                                ],
                                stops: [0.5, 1.0],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            dotData: FlDotData(
                              show: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}






































































































// crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                     color: Colors.white,
//                     width: 200, // largeur du conteneur
//                     height: 100,
//                     child: Padding(
//                       padding: const EdgeInsets.all(30.0),
//                       child: Container(
//                         height: 30,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: Color(0xFF3E3D45),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             // Ajoute l'icône centrée dans le conteneur
//                             Icon(
//                               Icons
//                                   .person_pin, // changez l'icône selon vos besoins
//                               color: Colors.white, // couleur de l'icône
//                               size: 40,
//                             ),
//                           ],
//                         ),
//                       ),
//                     )),
//               ),
//               const SizedBox(width: 16),
//               const Expanded(
//                 child: Card(
//                   child: ListTile(
//                     leading:
//                         Icon(Icons.bar_chart, size: 40, color: Colors.blue),
//                     title: Text('Les utilisateurs d\'aujourd\'hui'),
//                     subtitle: Text('2,300\n+3% than last week'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Statistique d\'utilisation',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           // Expanded(
//           //   child: Card(
//           //     child: Padding(
//           //       padding: const EdgeInsets.all(100),
//           //       child: LineChart(
//           //         LineChartData(
//           //           gridData: FlGridData(show: true),
//           //           titlesData: FlTitlesData(
//           //             leftTitles: AxisTitles(
//           //               sideTitles: SideTitles(showTitles: true),
//           //             ),
//           //             bottomTitles: AxisTitles(
//           //               sideTitles: SideTitles(showTitles: true),
//           //             ),
//           //           ),
//           //           borderData: FlBorderData(show: true),
//           //           lineBarsData: [
//           //             LineChartBarData(
//           //               spots: [
//           //                 FlSpot(0, 3),
//           //                 FlSpot(1, 1),
//           //                 FlSpot(2, 4),
//           //                 FlSpot(3, 3),
//           //                 FlSpot(4, 5),
//           //                 FlSpot(5, 2),
//           //                 FlSpot(6, 6),
//           //                 FlSpot(7, 3),
//           //                 FlSpot(8, 4),
//           //                 FlSpot(9, 3),
//           //                 FlSpot(10, 5),
//           //               ],
//           //               isCurved: true,
//           //               color: Colors.blue,
//           //               barWidth: 4,
//           //               isStrokeCapRound: true,
//           //               belowBarData: BarAreaData(
//           //                 show: true,
//           //                 color: Colors.blue.withOpacity(0.3),
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],