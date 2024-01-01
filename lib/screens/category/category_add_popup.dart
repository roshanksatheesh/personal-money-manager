import 'package:flutter/material.dart';
import '../../db/category/category_db.dart';
import '../../models/category/category_model.dart';

ValueNotifier<Categorytype>selectedcategoryNotifier = 
 ValueNotifier(Categorytype.income); 
 final _nameEditingController = TextEditingController();
Future<void>showCategoryAddPopup(BuildContext context)async{
  showDialog(
    context: context,
   builder: (ctx){
    return SimpleDialog(
    title: const Text('Add category'),
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _nameEditingController,
          decoration: const InputDecoration(
            hintText: 'Category Name',
            border: OutlineInputBorder()
          ),
        ),
      ),
     const Padding(
        padding:  EdgeInsets.all(8.0),
        child: Row(
          children: [
            RadioButton(title: 'Income', type: Categorytype.income),
             RadioButton(title: 'Expense', type: Categorytype.expense),
        ],
       ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: (){
            final _name = _nameEditingController.text;
             if (_name.isEmpty){
              return;
             }
             final _type = selectedcategoryNotifier.value;
             final _category = CategoryModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
               name: _name, 
               type: _type);

               CategoryDB().insertCategory(_category);
               Navigator.of(ctx).pop();
          }, 
          child: const Text('Add')),
      ),
    ],
    );
   }
  );
}
class RadioButton extends StatelessWidget {
  final String title;
  final Categorytype type;

  const RadioButton ( {
       required this.title,
    required this.type,super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       ValueListenableBuilder(
        valueListenable: selectedcategoryNotifier,
        builder:(BuildContext context, Categorytype  newCategory,Widget? _) {
          
        return   Radio(value:type,
         groupValue: selectedcategoryNotifier.value,
         onChanged: (value){
          if(value ==null ){
            return ;
          }
          selectedcategoryNotifier.value = value;
          selectedcategoryNotifier.notifyListeners();
         }
         );
         },
         ),
         Text(title),
      ],
    );
  }
}