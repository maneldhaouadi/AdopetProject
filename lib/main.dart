import 'package:flutter/material.dart';
import 'package:projectadopet/screens/PetListScreen.dart';

void main() {
  runApp(ProjectAdopetApp());
}

class ProjectAdopetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Adopet',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PetListScreen(),
    );
  }
}

