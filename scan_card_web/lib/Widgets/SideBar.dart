import 'package:flutter/material.dart';
import 'package:scan_card_web/Admin/Dashboard.dart';
import 'package:scan_card_web/Admin/Deconnexion.dart';
import 'package:scan_card_web/Admin/ParametreAdmin.dart';
import 'package:scan_card_web/Admin/ProfileAdmin.dart';
import 'package:scan_card_web/Admin/Utilisateur.dart';
import 'package:scan_card_web/Constante/Color.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int indexSelect = 0;

  final List<Widget> pages = [
    DashboardPage(),
    ProfileAdmin(),
    Utilisateur(),
    ParametreAdmin(),
    Deconnexion()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Navig(
              indexSelect: indexSelect,
              onItemSelected: (index) {
                setState(() {
                  indexSelect = index; // Mettre à jour la sélection
                });
              },
            ),
          ),
          Expanded(
              flex: 7,
              child: IndexedStack(
                index: indexSelect,
                children: pages,
              )),
        ],
      ),
    );
  }
}

class Navig extends StatelessWidget {
  final int indexSelect;
  final ValueChanged<int> onItemSelected;

  const Navig({
    super.key,
    required this.indexSelect,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topCenter, // Début du gradient (en haut)
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF3E3D45).withOpacity(0.5), // Couleur avec opacité
            const Color(0xFF202020).withOpacity(0.5), // Couleur avec opacité
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  'Images/Logo_ScanCard.png',
                  height: 200,
                  width: 200,
                ),
              )),
          Container(
            width: 250,
            height: 1,
            color: Colors.white,
          ),
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('Images/Ellipse.png'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Aoua Sow",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 250,
            height: 1,
            color: Colors.white,
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onItemSelected(index); // Gérer la sélection
                      },
                      child: SideScroll(
                        index: index,
                        cone: _getIcon(
                            index), // Icône spécifique pour chaque item
                        texte: _getText(
                            index), // Texte spécifique pour chaque item
                        isSelected: indexSelect == index,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Icon _getIcon(int index) {
    switch (index) {
      case 0:
        return const Icon(
          Icons.dashboard,
          color: Colors.white,
        );
      case 1:
        return const Icon(Icons.person, color: Colors.white);
      case 2:
        return const Icon(Icons.people, color: Colors.white);
      case 3:
        return const Icon(Icons.settings, color: Colors.white);
      case 4:
        return const Icon(Icons.logout, color: Colors.white);
      default:
        return const Icon(Icons.help);
    }
  }

  String _getText(int index) {
    switch (index) {
      case 0:
        return "Dashboard";
      case 1:
        return "Profile";
      case 2:
        return "Utilisateurs";
      case 3:
        return "Parametres";
      case 4:
        return "Deconnexion";
      default:
        return "Item $index";
    }
  }

  Widget SideScroll({
    required int index,
    required Icon cone,
    required String texte,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? colorPrimaime : colorSecondaire,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          cone,
          const SizedBox(width: 10),
          Text(
            texte,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
