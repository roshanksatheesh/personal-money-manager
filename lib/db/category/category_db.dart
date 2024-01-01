import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions{
  Future<List<CategoryModel>>getCategories();
  Future<void>insertCategory(CategoryModel value);
  Future<void>deleteCategory(String categoryID);

}
class CategoryDB implements CategoryDbFunctions{

CategoryDB._internal();

static CategoryDB instance =CategoryDB._internal();

factory CategoryDB(){
  return instance;
}

   ValueNotifier<List<CategoryModel>> incomecategoryListListener = ValueNotifier([]);
   ValueNotifier<List<CategoryModel>> expensecategoryListListener = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value)async {
   final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
 await _categoryDB.put(value.id, value);
 refreshUI();
}

  @override
  Future<List<CategoryModel>> getCategories() async{
     final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
     return _categoryDB.values.toList();
  }

  Future<void> refreshUI () async{

    final _allCategories = await  getCategories();
    incomecategoryListListener.value.clear();
    expensecategoryListListener.value.clear();
    Future.forEach(_allCategories,
     (CategoryModel category) {
      if(category.type == Categorytype.income){
        incomecategoryListListener.value.add(category);
      }else{
        expensecategoryListListener.value.add(category);
      }
      incomecategoryListListener.notifyListeners();
      expensecategoryListListener.notifyListeners();
     });
  }
  
  @override
  Future<void> deleteCategory(String categoryID)async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME );
   await _categoryDB.delete(categoryID);
   refreshUI();
  }
}