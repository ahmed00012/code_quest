import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../providers_screen/data/models/specialist_model.dart';

class AppointmentsModel {
   String id;
   String? date;
   SpecialistModel? specialist;
   String specialistId;
   String user;

  AppointmentsModel({
    required this.id,
    this.date,
    this.specialist,
    required this.user,
    required this.specialistId,
  });

  factory AppointmentsModel.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    final reference = doc.reference.get();
    return AppointmentsModel(
      id: doc.id,
      user: data['user'] ?? '',
      date: data['date'] ?? '',
      specialistId: data['specialist_id'] ?? '',
    );
  }
}
