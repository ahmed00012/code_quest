import 'package:equatable/equatable.dart';

import '../../data/models/appointments_model.dart';

abstract class AppointmentsState extends Equatable {
  @override
  List<Object?> get props => [];
  const AppointmentsState();
}

class InitAppointmentsState extends AppointmentsState {}

class AppointmentsLoadingState extends AppointmentsState {}

class AppointmentsErrorState extends AppointmentsState {
  final String message;
  const AppointmentsErrorState(this.message);
}

class AppointmentsSuccessState extends AppointmentsState {
  final List<AppointmentsModel> appointments;
  const AppointmentsSuccessState({required this.appointments});
  @override
  List<Object?> get props => [appointments];
}

class UpdateAppointmentLoadingState extends AppointmentsState {}

class UpdateAppointmentErrorState extends AppointmentsState {
  final String message;
  const UpdateAppointmentErrorState(this.message);
}

class UpdateAppointmentSuccessState extends AppointmentsState {
  final String date;
  final String appointmentId;
  const UpdateAppointmentSuccessState(
      {required this.date, required this.appointmentId});
}

class DeleteAppointmentLoadingState extends AppointmentsState {}

class DeleteAppointmentErrorState extends AppointmentsState {
  final String message;
  const DeleteAppointmentErrorState(this.message);
}

class DeleteAppointmentSuccessState extends AppointmentsState {
  final String appointmentId;
  final bool isClear;
  const DeleteAppointmentSuccessState({
    required this.appointmentId,
    this.isClear = false,
  });
}
