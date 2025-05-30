import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/local_storage/storage_helper.dart';
import '../../../../core/utils/constants.dart';
import '../models/specialist_model.dart';

abstract class SpecialistsRemoteDataSource {
  Future<List<SpecialistModel>> fetchSpecialists();
  Future<int> appointmentsCount();
  Future<bool> bookAppointment({
    required String user,
    required String date,
    required String specialistId,
    required SpecialistModel specialistModel,
  });
}

class SpecialistsRemoteDataSourceImpl implements SpecialistsRemoteDataSource {
  @override
  Future<List<SpecialistModel>> fetchSpecialists() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('specialists').get();
      return snapshot.docs.map((doc) => SpecialistModel.fromJson(doc)).toList();
    } catch (e) {
      throw Exception('Failed to load specialists: $e');
    }
  }

  @override
  Future<int> appointmentsCount() async {
    try {
      final snapshot =
      await FirebaseFirestore.instance.collection('appointments')
          .where('user', isEqualTo: LocalStorage.getData(key: Constants.loggedInUser))
          .count().get();
      return snapshot.count ?? 0;
    } catch (e) {
      throw Exception('Failed to load specialists: $e');
    }
  }

  @override
  Future<bool> bookAppointment({
    required String user,
    required String date,
    required String specialistId,
    required SpecialistModel specialistModel,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('appointments').add({
        'user': user,
        'specialist_id': specialistId,
        'date': date,
      });
      final docRef = FirebaseFirestore.instance
          .collection('specialists')
          .doc(specialistId);
      specialistModel.availability.forEach((element) {
        if (element.date == date) {
          element.available = false;
        }
      });
      await docRef.update(specialistModel.toJson());
      return true;
    } catch (e) {
      throw Exception('Failed to book appointment: $e');
    }
  }
}
