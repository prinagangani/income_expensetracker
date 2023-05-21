import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/addscreen/view/add_screen.dart';
import 'package:income_expense/screens/transaction/view/transaction_screen.dart';
import 'screens/home/view/home_screen.dart';
void main()
{
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => HomeScreen()),
          GetPage(name: '/income', page: () => AddScreen(),),
          GetPage(name: '/transaction', page: () => TransactionScreen(),),
        ],
      )
  );
}