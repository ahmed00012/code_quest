import 'package:dartz/dartz.dart';
import '../../../core/utils/failure.dart';
import '../data/data_source/specialists_data_source.dart';
import '../data/models/specialist_model.dart';

abstract class SpecialistsRepository {
  Future<Either<Failure, List<SpecialistModel>>> getSpecialists();
  Future<Either<Failure, bool>> bookAppointment(
      {required String user,
      required String date,
      required String specialistId,
        required SpecialistModel specialistModel});
  Future<Either<Failure, int>> appointmentsCount();
}

class SpecialistsRepositoryImpl implements SpecialistsRepository {
  final SpecialistsRemoteDataSource _remoteDataSource;

  SpecialistsRepositoryImpl(
    this._remoteDataSource,
  );

  @override
  Future<Either<Failure, List<SpecialistModel>>> getSpecialists() async {
    try {
    final response = await _remoteDataSource.fetchSpecialists();
    return Right(response);
    } catch (error) {
      return Left(Failure(message: error.toString(), code: 500));
    }
  }
  @override
  Future<Either<Failure, int>> appointmentsCount() async {
    try {
    final response = await _remoteDataSource.appointmentsCount();
    return Right(response);
    } catch (error) {
      return Left(Failure(message: error.toString(), code: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> bookAppointment(
      {required String user,
      required String date,
      required String specialistId,
        required SpecialistModel specialistModel}) async {
    try {
      final response = await _remoteDataSource.bookAppointment(
          date: date,
          specialistId: specialistId,
          specialistModel : specialistModel,
          user: user);
      return Right(response);
    } catch (error) {
      return Left(Failure(message: error.toString(), code: 500));
    }
  }
}
