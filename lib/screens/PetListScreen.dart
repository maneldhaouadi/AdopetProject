import 'package:flutter/material.dart';
import 'package:projectadopet/data/FakeDogDatabase.dart';
import 'package:projectadopet/screens/PetitDetailScreen.dart';

class PetListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pets = dogList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pets Available for Adoption'),
      ),
      body: ListView.builder(
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
                  child: Image.asset(
                    pet.imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: pet.gender == "Male"
                            ? Colors.blue[50]
                            : Colors.pink[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        pet.gender,
                        style: TextStyle(
                          fontSize: 14,
                          color: pet.gender == "Male"
                              ? Colors.blue
                              : Colors.pink,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
