import 'package:flutter/material.dart';
import 'package:scan_card/User/ContactCarte.dart';

class ContactUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: const EdgeInsets.symmetric(vertical: 1),
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF21396A)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 90, right: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('image/Ellipse.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Salut , Aoua SOW ", //$nom  $prenom
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      
            //bloc du milieu
            Expanded(
                child: Container(
              height: 200,
              width: 500,
              decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 1, right: 1),
                                    prefixIcon: const Icon(Icons.search),
                                    hintText: "Recherche Contact",
                                    hintStyle:
                                        const TextStyle(color: Color(0xFF000000)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF2C2C2C))),
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(243, 243, 243, 243),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "Soumettre un ticket",
                                  style: TextStyle(fontSize: 14),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContactCarte()),
                                    );
                                  },
                                  icon: const Icon(Icons.add_circle_rounded,
                                      color: Color(0xFFF9754E), size: 40),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 34),
                  ],
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }
}


