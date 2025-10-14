import 'package:dartz/dartz.dart';
import 'package:todo_notes/core/common/errors/failure.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';

abstract class ListModelRepository {
  Future<Either<Failure, List<ListModel>>> getAllLists();
  Future<Either<Failure, ListModel>> addList(ListModel listModel);
  Future<Either<Failure, ListModel>> updateList(
    int index,
    ListModel updateList,
  );
  Future<Either<Failure, bool>> deleteList(int index);
}
