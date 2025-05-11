import 'package:equatable/equatable.dart';

abstract class AppointmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const AppointmentsEvent();
}

class FetchAllAppointmentsEvent extends AppointmentsEvent {
  const FetchAllAppointmentsEvent();
}

class UpdateAppointmentEvent extends AppointmentsEvent {
  final String date;
  final String appointmentId;
  const UpdateAppointmentEvent(
      {required this.date,
        required this.appointmentId});
}


class DeleteAppointmentEvent extends AppointmentsEvent {
  final String appointmentId;
  const DeleteAppointmentEvent(
      {required this.appointmentId});
}