import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_quest/core/local_storage/storage_helper.dart';
import 'package:code_quest/core/utils/constants.dart';

import '../../../providers_screen/data/models/specialist_model.dart';
import '../models/appointments_model.dart';

abstract class AppointmentsRemoteDataSource {
  Future<List<AppointmentsModel>> fetchAppointments();
  Future<void> updateAppointment({
    required String appointmentId,
    required String date,
  });
  Future<void> deleteAppointment(String appointmentId);
}

class AppointmentsRemoteDataSourceImpl implements AppointmentsRemoteDataSource {
  @override
  Future<List<AppointmentsModel>> fetchAppointments() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('appointments')
              .where('user', isEqualTo: LocalStorage.getData(key: Constants.loggedInUser))
              .get();
      List<AppointmentsModel> appointments = snapshot.docs
          .map((doc) => AppointmentsModel.fromFirestore(doc))
          .toList();
      for (int i = 0; i < snapshot.docs.length; i++) {
        final specialistSnapshot = await FirebaseFirestore.instance
            .collection('specialists')
            .doc(appointments[i].specialistId)
            .get();
        appointments[i].specialist =
            SpecialistModel.fromJson(specialistSnapshot);
      }
      return appointments;
    } catch (e) {
      throw Exception('Failed to load specialists: $e');
    }
  }

  Future<void> updateAppointment({
    required String appointmentId,
    required String date,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({"date": date});
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }
}
