import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/transaction/controller/home_controller.dart';
import 'package:income_expense/utils/db_helper.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtpay = TextEditingController();
  TextEditingController txtdate = TextEditingController(text: "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");
  TextEditingController txttime = TextEditingController(text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  TextEditingController txtstatus = TextEditingController();

  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    dbHelper dbhelper = dbHelper();
    dbhelper.check();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black,title: Text("Add Your Transaction"),centerTitle: true,),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(controller: txtcate,decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),label: Text("Category")),),SizedBox(height: 10),
              TextField(controller: txtamount,decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),label: Text("Amount")),),SizedBox(height: 10,),
              TextField(controller: txtnote,decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),label: Text("Notes")),),SizedBox(height: 10),
              TextField(controller: txtpay,decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),label: Text("Pay Type")),),SizedBox(height: 10),
              TextField(controller: txtdate,decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),label: Text("Date")),),SizedBox(height: 10),
              TextField(controller: txttime,decoration: InputDecoration(enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder(),label: Text("Time")),),SizedBox(height: 30),
              ElevatedButton(onPressed: () {
                dbHelper dbhelper = dbHelper();
                dbhelper.insert(amount: txtamount.text, category: txtcate.text, status: "1", notes: txtnote.text, date: txtdate.text, time: txttime.text, paytype: txtpay.text,);
                  int i = 0;
                  for(i=0;i<homeController.dataList.length;i++)
                    {
                      int status = int.parse(homeController.dataList[i]['status']);
                      if(status==1)
                        {
                          int amount = int.parse(homeController.dataList[i]['amount']);
                          homeController.total.value = homeController.total.value + amount;
                          homeController.income.value = homeController.income.value+amount;
                        }
                    }
                  Get.back();
              }, child: Text("Income"),style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),),SizedBox(height: 20),



              ElevatedButton(onPressed: () {
                  dbHelper dbhelper = dbHelper();
                  dbhelper.insert(amount: txtamount.text, category: txtcate.text, status: "0", notes: txtnote.text, date: txtdate.text, time: txttime.text, paytype: txtpay.text);
                  int i = 0;
                  for(i=0;i<homeController.dataList.length;i++)
                    {
                      int status = int.parse(homeController.dataList[i]['status']);
                      if(status==0)
                        {
                          int amount = int.parse(homeController.dataList[i]['amount']);
                          homeController.total.value=homeController.total.value-amount;
                          homeController.expense.value=homeController.expense.value+amount;
                        }
                    }
                  Get.back();
              }, child: Text("Expense"),style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade300),),
            ]
          ),
        ),
      ),
    );
  }
}
