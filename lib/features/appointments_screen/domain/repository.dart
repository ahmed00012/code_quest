import 'package:dartz/dartz.dart';
import '../../../core/utils/failure.dart';
import '../data/data_source/appointments_data_source.dart';
import '../data/models/appointments_model.dart';

abstract class AppointmentsRepository {
  Future<Either<Failure, List<AppointmentsModel>>> getAppointments();
  Future<Either<Failure, bool>> deleteAppointment({
    required String appointmentId,
  });
  Future<Either<Failure, bool>> updateAppointment({
    required String appointmentId,
    required String date,
  });
}

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final AppointmentsRemoteDataSource _remoteDataSource;

  AppointmentsRepositoryImpl(
    this._remoteDataSource,
  );

  @override
  Future<Either<Failure, List<AppointmentsModel>>> getAppointments() async {
    try {
      final response = await _remoteDataSource.fetchAppointments();
      return Right(response);
    } catch (error) {
      return Left(Failure(message: error.toString(), code: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> updateAppointment({
    required String appointmentId,
    required String date,
  }) async {
    try {
      final response = await _remoteDataSource.updateAppointment(
          date: date, appointmentId: appointmentId);
      return const Right(true);
    } catch (error) {
      return Left(Failure(message: error.toString(), code: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAppointment({
    required String appointmentId,
  }) async {
    try {
      final response = await _remoteDataSource.deleteAppointment(appointmentId);
      return const Right(true);
    } catch (error) {
      return Left(Failure(message: error.toString(), code: 500));
    }
  }
}
