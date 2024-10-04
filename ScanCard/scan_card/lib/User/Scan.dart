import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scan_card/Service/Scan_service.dart';
import 'package:scan_card/User/AcceuilUser.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  final ScanService _scanService = ScanService();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),

          // Card frame (similar to the placeholder)
          Center(
            child: Container(
              width: 250,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AcceuilUser()),
                );
              },
            ),
          ),

          // Camera switch button (currently not implemented)
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.cameraswitch_outlined,
                  color: Colors.white, size: 30),
              onPressed: () {
                // Logic to switch cameras could go here
              },
            ),
          ),

          // Text on the left and right of the camera frame
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 2 - 75,
            child: const RotatedBox(
              quarterTurns: 1,
              child: Text(
                "Ce côté vers le bas",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height / 2 - 75,
            child: const RotatedBox(
              quarterTurns: 1,
              child: Text(
                "Ce côté vers le haut",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          // Bottom navigation bar
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade800),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Image button
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, color: Colors.grey, size: 30),
                      Text(
                        'Images',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),

                  // Capture button
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _initializeControllerFuture;
                        final image = await _cameraController.takePicture();
                        final file = File(image.path);

                        // Utilisation du service pour scanner la carte
                        final result = await _scanService.scanCard();

                        if (result != null) {
                          print('Image URL: ${result['url']}');
                          print('Text: ${result['text']}');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 5),
                      ),
                    ),
                  ),

                  // Manual button

                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.grey, size: 30),
                      Text(
                        'Manuelle',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
