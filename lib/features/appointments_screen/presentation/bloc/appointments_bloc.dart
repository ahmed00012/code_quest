import 'package:code_quest/features/providers_screen/presentation/bloc/specialists_event.dart';
import 'package:code_quest/features/providers_screen/presentation/bloc/specialists_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository.dart';
import 'appointments_event.dart';
import 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  static AppointmentsBloc get(BuildContext context) => BlocProvider.of(context);
  AppointmentsRepository appointmentsRepository;
  AppointmentsBloc({
    required this.appointmentsRepository,
  }) : super(InitAppointmentsState()) {
    on<FetchAllAppointmentsEvent>((event, emit) async {
      emit(AppointmentsLoadingState());
      final result = await appointmentsRepository.getAppointments();
      result.fold((failure) {
        emit(AppointmentsErrorState(failure.message));
      }, (appointments) {
        appointments.forEach((element) {
          if (DateTime.parse(element.date!).isAfter(DateTime.now())) {
            add(DeleteAppointmentEvent(appointmentId: element.id, isClear: true));
          }
        });
        emit(AppointmentsSuccessState(appointments: appointments));
      });
    });
    on<UpdateAppointmentEvent>((event, emit) async {
      emit(UpdateAppointmentLoadingState());
      final result = await appointmentsRepository.updateAppointment(
          date: event.date, appointmentId: event.appointmentId);
      result.fold((failure) {
        emit(UpdateAppointmentErrorState(failure.message));
      }, (specialists) {
        emit(UpdateAppointmentSuccessState(
            date: event.date, appointmentId: event.appointmentId));
      });
    });
    on<DeleteAppointmentEvent>((event, emit) async {
      emit(DeleteAppointmentLoadingState());
      final result = await appointmentsRepository.deleteAppointment(
          appointmentId: event.appointmentId);
      result.fold((failure) {
        emit(DeleteAppointmentErrorState(failure.message));
      }, (specialists) {
        emit(DeleteAppointmentSuccessState(appointmentId: event.appointmentId,isClear: event.isClear));
      });
    });
  }
}
