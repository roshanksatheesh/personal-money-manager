import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:personal_money_manager/db/transaction/transaction_db.dart';
import '../../db/category/category_db.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {

    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
     valueListenable: TransactionDB.instance.transactionListNotifier,
       builder:
       (BuildContext ctx, List<TransactionModel>newList, Widget?_){
        return ListView.separated(
         //values 
      itemBuilder: (ctx ,index){
       final _value = newList[index];
        return Slidable(
            key: Key(_value.id!),
            startActionPane: ActionPane(
              motion: const ScrollMotion(), 
              children: [
                SlidableAction(      
                onPressed:(ctx){
                  TransactionDB.instance.deleteTransaction(_value.id!);
                 },
                 icon:Icons.delete,
                 label: 'Delete',
                ),
              ],
              ),
            child: Card(
            elevation: 0,
             child: ListTile(
              leading: CircleAvatar(
              child: Text(
                parsedate(_value.date) ,
              textAlign: TextAlign.center),
              backgroundColor: _value.type == Categorytype.income 
              ? Colors.green
              :Colors.red,
              radius: 50,),
              title: Text('RS ${_value.amount}'),
              subtitle:  Text(_value.category.name),
            ),
                ),
          );
    },
     separatorBuilder: (ctx, index){
      return const SizedBox( height: 5);
     }, 
     itemCount: newList.length);
    }
   );
  } 

String parsedate(DateTime date){
 final _date = DateFormat.MMMd().format(date);
  final _spliteddate = _date.split(' ');
  return '${_spliteddate.last}\n${_spliteddate.first}';
//  return '${date.day}\n${date.month}';
}
}