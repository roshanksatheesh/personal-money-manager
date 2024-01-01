import 'package:hive_flutter/hive_flutter.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
enum Categorytype{
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}
@HiveType(typeId: 1)
class CategoryModel{

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isdeleted;

  @HiveField(3)
  final Categorytype type;

  CategoryModel({
    required this.id,
    required this.name,
   required this.type,
   this.isdeleted =false });

  @override
  String toString() {
    return ' {$name $type }';
  }
}