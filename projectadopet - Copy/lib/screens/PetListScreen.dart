import 'package:flutter/material.dart';
import 'package:projectadopet/data/DogService.dart';
import 'package:projectadopet/models/Dog.dart';
import 'package:projectadopet/screens/AddDogScren.dart';
import 'package:projectadopet/screens/PetitDetailScreen.dart';
import 'package:projectadopet/screens/UpdateDogScreen.dart';

class PetListScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  final DogService dogService = DogService();
  late Future<List<Dog>> _dogList;

  @override
  void initState() {
    super.initState();
    _dogList = dogService.fetchDogs();
  }

  void _reloadDogList() {
    setState(() {
      _dogList = dogService.fetchDogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets Available for Adoption'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddDogScreen()),
                  ).then((_) {
                    _reloadDogList();
                  });
                },
                child: Text('Add New Dog'),
              ),
            ),
            FutureBuilder<List<Dog>>(
              future: _dogList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No pets available for adoption.'));
                }

                final pets = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              child: Image.network(pet.imageUrl, fit: BoxFit.cover),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                pet.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: pet.gender == "Male" ? Colors.blue[50] : Colors.pink[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  pet.gender,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: pet.gender == "Male" ? Colors.blue : Colors.pink,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                "${pet.age} yrs | Playful",
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, color: Colors.red, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    pet.distance,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(Icons.access_time, color: Colors.grey, size: 16),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "12 min ago",
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetDetailScreen(pet: pet),
                              ),
                            );
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateDogScreen(pet: pet),
                                    ),
                                  ).then((updatedDog) {
                                    if (updatedDog != null) {
                                      setState(() {
                                        final index = pets.indexOf(pet);
                                        if (index != -1) {
                                          pets[index] = updatedDog;
                                        }
                                      });
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  bool confirmDelete = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Confirm Deletion"),
                                      content: Text("Are you sure you want to delete ${pet.name}?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, true),
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirmDelete) {
                                    await dogService.deleteDog(pet.id);
                                    _reloadDogList();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
