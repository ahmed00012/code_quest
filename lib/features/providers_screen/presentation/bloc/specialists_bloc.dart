import 'package:code_quest/features/providers_screen/presentation/bloc/specialists_event.dart';
import 'package:code_quest/features/providers_screen/presentation/bloc/specialists_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository.dart';

class SpecialistsBloc extends Bloc<SpecialistsEvent, SpecialistsState> {
  static SpecialistsBloc get(BuildContext context) => BlocProvider.of(context);
  SpecialistsRepository specialistsRepository;
  SpecialistsBloc({
    required this.specialistsRepository,
  }) : super(InitSpecialistsState()) {
    on<FetchAllSpecialistsEvent>((event, emit) async {
      emit(SpecialistsLoadingState());
      final result = await specialistsRepository.getSpecialists();
      result.fold((failure) {
        emit(SpecialistsErrorState(failure.message));
      }, (specialists) {
        emit(SpecialistsSuccessState(specialists: specialists));
      });
    });
    on<BookAppointmentEvent>((event, emit) async {
      emit(MakeAppointmentLoadingState());
      final result = await specialistsRepository.bookAppointment(
          user: event.user,
          date: event.date,
          specialistId: event.specialistId,
        specialistModel: event.specialistModel
      );
      result.fold((failure) {
        emit(MakeAppointmentErrorState(failure.message));
      }, (specialists) {
        emit(const MakeAppointmentSuccessState());
      });
    });

  }
}
