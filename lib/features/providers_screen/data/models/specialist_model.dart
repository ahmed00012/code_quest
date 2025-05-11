import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialistModel {
  final String id;
  final String name;
  final String bio;
  final String specialization;
  final String gender;
  final String image;
  final List<Availability> availability;

  SpecialistModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.specialization,
    required this.gender,
    required this.image,
    required this.availability,
  });

  factory SpecialistModel.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SpecialistModel(
      id: doc.id,
      name: data['name'],
      specialization: data['specialization'],
      bio: data['bio'] ?? '',
      image: data['image'] ?? '',
      gender: data['gender'] ?? '',
      availability: List<Availability>.from(
          data['availability'].map((e) => Availability.fromJson(e)).toList()),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'availability': List<dynamic>.from(availability.map((x) => x.toJson())),
    };
  }
}

class Availability {
   String? date;
   bool available;


  Availability({
    required this.date,
    required this.available,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      date: (json['time'] ?? json['date']).toDate().toString(),
      available: json['available'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'date': Timestamp.fromDate(DateTime.parse(date!)),
      'available': available,
    };
  }
}
