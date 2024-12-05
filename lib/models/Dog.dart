import 'package:projectadopet/models/Owner.dart';

class Dog {
  final int id;
  final String name;
  final double age;
  final String gender;
  final String color;
  final double weight;
  final String distance;
  final String imageUrl;
  final String description;
  final Owner owner;

  Dog(
    this.id,
    this.name,
    this.age,
    this.gender,
    this.color,
    this.weight,
    this.distance,
    this.imageUrl,
    this.description,
    this.owner,
  );
}
