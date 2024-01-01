import 'package:personal_money_manager/screens/add_transaction/screen_add_transaction.dart';
import 'package:personal_money_manager/screens/home/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/category/category_model.dart';
import 'models/transaction/transaction_model.dart';

Future <void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();

if(!Hive.isAdapterRegistered(CategorytypeAdapter().typeId)){
  Hive.registerAdapter(CategorytypeAdapter());
}

if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
  Hive.registerAdapter(CategoryModelAdapter());
}
if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
  Hive.registerAdapter(TransactionModelAdapter());
}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ScreenHome(),
      routes: {
        ScreenaddTransaction.routeName: (ctx)=> const ScreenaddTransaction(),
      },
    );
  }
}