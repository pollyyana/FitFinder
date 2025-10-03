import 'dart:convert';

class PersonalModel {
  final String id;
  final String name;
  final String bio;
  final List<String> specialties;
  final double rating;
  final String city;
  final String state;
  final String photoUrl;
  final String whatsapp;
  final double price;
  PersonalModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.specialties,
    required this.rating,
    required this.city,
    required this.state,
    required this.photoUrl,
    required this.whatsapp,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'specialties': specialties,
      'rating': rating,
      'city': city,
      'state': state,
      'photoUrl': photoUrl,
      'whatsapp': whatsapp,
      'price': price,
    };
  }

  factory PersonalModel.fromMap(Map<String, dynamic> map) {
    return PersonalModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      specialties: List<String>.from(map['specialties'] ?? const []),
      rating: map['rating']?.toDouble() ?? 0.0,
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      whatsapp: map['whatsapp'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalModel.fromJson(String source) =>
      PersonalModel.fromMap(json.decode(source));
}
