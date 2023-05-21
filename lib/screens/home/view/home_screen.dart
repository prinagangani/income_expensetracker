import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/transaction/controller/home_controller.dart';
// import 'package:sqflite/sqflite.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text("Income Expense"),centerTitle: true,backgroundColor: Colors.black,),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
             Row(
               children: [
                 ElevatedButton(onPressed: () {
                   Get.toNamed('/income');
                 }, child: Text("Enter"),),
                 ElevatedButton(onPressed: () {
                   homeController.readData();
                    Get.toNamed('/transaction');
                 }, child: Text("Transaction")),
               ],
             ),
            ],
          ),
        ),
      ),
    );
  }
}

