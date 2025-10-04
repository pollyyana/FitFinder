import 'dart:convert';

class PersonalModel {
  final int id;
  final String name;
  final String bio;
  final List<String> specialties;
  final double? rating;
  final String? photoUrl;
  final String whatsapp;
  final double price;
  PersonalModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.specialties,
    this.rating,
    this.photoUrl,
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
      'photoUrl': photoUrl,
      'whatsapp': whatsapp,
      'price': price,
    };
  }

  factory PersonalModel.fromMap(Map<String, dynamic> map) {
    return PersonalModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      specialties: List<String>.from(map['specialties'] ?? const []),
      rating: map['rating']?.toDouble(),
      photoUrl: map['photoUrl'],
      whatsapp: map['whatsapp'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalModel.fromJson(String source) =>
      PersonalModel.fromMap(json.decode(source));
}
