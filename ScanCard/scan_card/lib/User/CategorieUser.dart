import 'package:flutter/material.dart';

class CategorieUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 60,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 6), // changes position
                    ),
                  ],
                ),
                child: Row(children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    iconSize: 25,
                    color: Color(0xFFF9754E),
                  ),
                  const SizedBox(
                    width: 90,
                  ),
                  const Text(
                    "Catégories",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  )
                ])),
            const SizedBox(height: 60),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 6), // changes position
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.groups_outlined,
                    color: Color(0xFF21396A),
                    size: 35,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Text(
                    "Organisations",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    iconSize: 30,
                    color: const Color(0xFFF9754E),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 6), // changes position
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.groups_outlined,
                    color: Color(0xFF21396A),
                    size: 35,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Text(
                    "Entreprise",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    iconSize: 30,
                    color: const Color(0xFFF9754E),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 6), // changes position
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.groups_outlined,
                    color: Color(0xFF21396A),
                    size: 35,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Text(
                    "Freelance",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 62,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    iconSize: 30,
                    color: const Color(0xFFF9754E),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 6), // changes position
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.groups_outlined,
                    color: Color(0xFF21396A),
                    size: 35,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Text(
                    "Professionel",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    iconSize: 30,
                    color: const Color(0xFFF9754E),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 6), // changes position
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.groups_outlined,
                    color: Color(0xFF21396A),
                    size: 35,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Text(
                    "Collègue",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    iconSize: 30,
                    color: const Color(0xFFF9754E),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
