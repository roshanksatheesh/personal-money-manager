import 'package:flutter/material.dart';
import 'package:personal_money_manager/db/transaction/transaction_db.dart';
import '../../db/category/category_db.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';



class ScreenaddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTransaction({super.key});

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  Categorytype? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
   final _amountTextEditingController = TextEditingController();



@override
  void initState() {
   _selectedCategorytype = Categorytype.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //purpose
              TextFormField(
                controller: _purposeTextEditingController,
                keyboardType: TextInputType.text,
                decoration:const  InputDecoration(
                  hintText: 'purpose',         
                ),
              ),
              //amount
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                 decoration:const  InputDecoration(
                  hintText: 'Amount',                     
                ),
              ),
              //calender
              TextButton.icon(onPressed:()async {
               final _selectedDateTemp =  await showDatePicker(context: context,
                 initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)), 
                  lastDate: DateTime.now());

                  if(_selectedDateTemp ==null){
                    return;
                  }else{
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
              },
              icon: const Icon(Icons.calendar_today), 
              label: Text(
                _selectedDate == null
                ? 'Select Date'
                : _selectedDate!.toString(),
                ),
                ),
              //income,expense
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                children: [
                  Radio(
                    value: Categorytype.income,
                   groupValue:_selectedCategorytype,
                    onChanged: (newvalue){
                      setState(() {
                        _selectedCategorytype = Categorytype.income;
                        _categoryID = null;
                       }
                      ); 
                     }
                    ),
                   const  Text('Income'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: Categorytype.expense,
                   groupValue:_selectedCategorytype,
                    onChanged: (newvalue){
                      setState(() {
                         _selectedCategorytype = Categorytype.expense;
                        _categoryID = null;
                       }
                      );
                     }
                    ),
                   const  Text('Expense'),
                ],
               ),
             ],
            ), 
            //category type
            DropdownButton(
              hint:  const Text('Select Category'),
              value:  _categoryID,
              items: (_selectedCategorytype == Categorytype.income
              ? CategoryDB().incomecategoryListListener
              : CategoryDB().expensecategoryListListener )
              .value
              .map((e) {
                return  DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: (){
                    _selectedCategoryModel = e;
                  },
                );
              } 
              ).toList(),
             onChanged: (selectedValue){
              print(selectedValue);
              setState(() {
                 _categoryID = selectedValue;
                }
               );
              }
             ),
             //submit 
             ElevatedButton(
              onPressed: (){
                addTransaction();
                },
              child: const Text('Submit'))
          ],
        ),
      ) ,
    )
  );
}
 
Future<void>addTransaction()async{
final _purposeText = _purposeTextEditingController.text;
final _amountText = _amountTextEditingController.text;
if(_purposeText.isEmpty){
  return;
}
if(_amountText.isEmpty){
  return;
}
if(_categoryID == null){
  return;
}
if(_selectedDate ==null){
  return;
}

final _parsedamount = double.tryParse(_amountText);
if(_parsedamount == null){
  return;
}
if(_selectedCategoryModel==null){
  return;
  }
//_selectedDate
//_selectedCategorytype
//_categoryID
final _model = TransactionModel(
  purpose: _purposeText, 
  amount: _parsedamount,
   date: _selectedDate!, 
   type: _selectedCategorytype!, 
   category: _selectedCategoryModel!,
   );

  await TransactionDB.instance.addTransaction(_model);
  Navigator.of(context).pop();
  TransactionDB.instance.refresh();
 }
}