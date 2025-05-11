import 'package:equatable/equatable.dart';

import '../../data/models/specialist_model.dart';

abstract class SpecialistsState extends Equatable {
  @override
  List<Object?> get props => [];
  const SpecialistsState();
}

class InitSpecialistsState extends SpecialistsState {}

class SpecialistsLoadingState extends SpecialistsState {}

class SpecialistsErrorState extends SpecialistsState {
  final String message;
  const SpecialistsErrorState(this.message);
}

class SpecialistsSuccessState extends SpecialistsState {
  final List<SpecialistModel> specialists;
  const SpecialistsSuccessState({required this.specialists});
  @override
  List<Object?> get props => [specialists];
}

class MakeAppointmentLoadingState extends SpecialistsState {}

class MakeAppointmentErrorState extends SpecialistsState {
  final String message;
  const MakeAppointmentErrorState(this.message);
}

class MakeAppointmentSuccessState extends SpecialistsState {
  const MakeAppointmentSuccessState();
}

class AppointmentsCountLoadingState extends SpecialistsState {}

class AppointmentsCountErrorState extends SpecialistsState {
  final String message;
  const AppointmentsCountErrorState(this.message);
}

class AppointmentsCountSuccessState extends SpecialistsState {
  final int appointmentsCount;
  const AppointmentsCountSuccessState({required this.appointmentsCount});
  @override
  List<Object?> get props => [appointmentsCount];
}