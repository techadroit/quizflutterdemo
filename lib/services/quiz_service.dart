import 'package:TataEdgeDemo/data/exceptoins.dart';
import 'package:TataEdgeDemo/data/qustions.dart';
import 'package:TataEdgeDemo/data/remote_repository.dart';
import 'package:dartz/dartz.dart';

class QuizService {
  RemoteRepository remoteRepository;

  QuizService(this.remoteRepository);

  Future<Either<Exception, List<Questions>>> getQuestions(
      String category) async {
    try {
      var response = await remoteRepository.getQuestions(category);
      var list = response.map((e) => Questions.fromResponse(e)).toList();
      return Right(list);
    } catch (e) {
      return Left(e);
    }
  }
}
