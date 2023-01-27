import 'package:isar/isar.dart';

part 'counter.g.dart';

@collection
class Counter {
  Id id = Isar.autoIncrement;
  int? counter;

  /// 作成日時
  late DateTime createdAt;

  /// 更新日時
  @Index()
  late DateTime updatedAt;

  @override
  String toString() {
    return '{ id:${this.id} , counter:${this.counter} , createdAt:${this.createdAt} , updatedAt:${this.updatedAt} }';
  }
}
