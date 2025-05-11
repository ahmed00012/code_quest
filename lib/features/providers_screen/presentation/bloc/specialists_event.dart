import 'package:equatable/equatable.dart';

import '../../data/models/specialist_model.dart';

abstract class SpecialistsEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const SpecialistsEvent();
}

class FetchAllSpecialistsEvent extends SpecialistsEvent {
  const FetchAllSpecialistsEvent();
}

class BookAppointmentEvent extends SpecialistsEvent {
  final String user;
  final String date;
  final String specialistId;
  final SpecialistModel specialistModel;
  const BookAppointmentEvent(
      {required this.user,
      required this.date,
      required this.specialistModel,
      required this.specialistId});
}
