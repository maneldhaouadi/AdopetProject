import 'package:flutter/material.dart';
import 'package:projectadopet/models/Dog.dart';
import 'package:projectadopet/data/DogService.dart';

class UpdateDogScreen extends StatefulWidget {
  final Dog pet;

  UpdateDogScreen({required this.pet});

  @override
  _UpdateDogScreenState createState() => _UpdateDogScreenState();
}

class _UpdateDogScreenState extends State<UpdateDogScreen> {
  final DogService dogService = DogService();

  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _colorController;
  late TextEditingController _weightController;
  late TextEditingController _distanceController;
  late TextEditingController _descriptionController;

  String? selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pet.name);
    _ageController = TextEditingController(text: widget.pet.age.toString());
    _colorController = TextEditingController(text: widget.pet.color);
    _weightController = TextEditingController(text: widget.pet.weight.toString());
    _distanceController = TextEditingController(text: widget.pet.distance);
    _descriptionController = TextEditingController(text: widget.pet.description);

    selectedImage = widget.pet.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    List<String> dogImageChoices = [
      'assets/orange_dog.png',
      'assets/blue_dog.png',
      'assets/red_dog.png',
      'assets/yellow_dog.png',
      'assets/white_dog.png',
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Update Dog')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _colorController,
                decoration: InputDecoration(labelText: 'Color'),
              ),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _distanceController,
                decoration: InputDecoration(labelText: 'Distance'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              // Sélecteur d'image pour le chien (comme dans AddDog)
              DropdownButtonFormField<String>(
                value: selectedImage,
                onChanged: (value) {
                  setState(() {
                    selectedImage = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Select Dog Image'),
                items: dogImageChoices
                    .map((image) => DropdownMenuItem(
                          value: image,
                          child: Image.asset(image, width: 50, height: 50),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an image';
                  }
                  return null;
                },
              ),
              if (selectedImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(selectedImage!, width: 100, height: 100),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty && _ageController.text.isNotEmpty) {
                    Dog updatedDog = widget.pet.copyWith(
                      name: _nameController.text,
                      age: double.parse(_ageController.text),
                      color: _colorController.text,
                      weight: double.parse(_weightController.text),
                      distance: _distanceController.text,
                      imageUrl: selectedImage ?? widget.pet.imageUrl,
                      description: _descriptionController.text,
                    );
                    dogService.updateDog(updatedDog);
                    Navigator.pop(context, updatedDog);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields correctly!")),
                    );
                  }
                },
                child: Text('Update Dog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
