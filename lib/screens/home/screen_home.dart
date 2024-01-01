import 'package:flutter/material.dart';
import 'package:personal_money_manager/screens/home/widget/bottom_navigationbar.dart';
import 'package:personal_money_manager/screens/transaction/screen_transaction%20.dart';
import '../add_transaction/screen_add_transaction.dart';
import '../category/category_add_popup.dart';
import '../category/screen_category.dart';


class ScreenHome extends StatelessWidget {
  const  ScreenHome({super.key});
  
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages =const [
    ScreenTransaction(),
    ScreenCategory(),

];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text('MONEY MANAGER'),
      centerTitle: true,
      backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(

        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
         builder:(BuildContext context,int updatedIndex, Widget? _) {
          return _pages[updatedIndex];
           
         }
        ) 
       ),
       
       floatingActionButton: FloatingActionButton(onPressed: (){
        if (selectedIndexNotifier.value ==0 ){
          print('add transaction');
          Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
        }else{
          print('add category');
          showCategoryAddPopup(context); 
          // final _sample = CategoryModel(
          //   id: DateTime.now().millisecondsSinceEpoch.toString(),
          //  name: 'TRAVEL', 
          //  type: Categorytype.expense);   
          // CategoryDB().insertCategory(_sample);
        }
       },
       child: Icon(Icons.add),
       ),
    );
  }
}