part of 'injection_imports.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initSpecialistsModule();
  initAppointmentsModule();
}

void initSpecialistsModule() {
  if (!sl.isRegistered<SpecialistsRemoteDataSource>()) {
    sl.registerFactory<SpecialistsRemoteDataSource>(
        () => SpecialistsRemoteDataSourceImpl());
  }

  if (!sl.isRegistered<SpecialistsRepository>()) {
    sl.registerFactory<SpecialistsRepository>(
        () => SpecialistsRepositoryImpl(sl()));
  }

  if (!sl.isRegistered<SpecialistsBloc>()) {
    sl.registerFactory(() => SpecialistsBloc(specialistsRepository: sl()));
  }
}

void initAppointmentsModule() {
  if (!sl.isRegistered<AppointmentsRemoteDataSource>()) {
    sl.registerFactory<AppointmentsRemoteDataSource>(
        () => AppointmentsRemoteDataSourceImpl());
  }

  if (!sl.isRegistered<AppointmentsRepository>()) {
    sl.registerFactory<AppointmentsRepository>(
        () => AppointmentsRepositoryImpl(sl()));
  }

  if (!sl.isRegistered<AppointmentsBloc>()) {
    sl.registerFactory(() => AppointmentsBloc(appointmentsRepository: sl()));
  }
}
