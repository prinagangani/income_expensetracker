import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expense/screens/transaction/controller/home_controller.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  HomeController homeController = Get.put(HomeController());
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtnote = TextEditingController();
  TextEditingController txtpay = TextEditingController();
  TextEditingController txtdate = TextEditingController(text: "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}");
  TextEditingController txttime = TextEditingController(text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  TextEditingController txtstatus = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeController.readData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.filter_alt_rounded),onPressed: () {
              Get.defaultDialog(
                title: "Filter Transaction",
                content: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        homeController.incomeexpenseFilter(1);
                        Get.back();
                      },
                      child: Row(
                        children: [
                          Text("Income"),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        homeController.incomeexpenseFilter(0);
                        Get.back();
                      },
                      child: Row(
                        children: [
                          Text("Expense"),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        homeController.readData();
                        Get.back();
                      },
                      child: Row(
                        children: [
                          Text("All Transaction"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },),
        title: Text("Transaction Screen"),
        centerTitle: true,
        backgroundColor: Colors.black,
         ),
          body: Obx(
          () =>  Column(
            children: [
              Expanded(
                child: ListView.builder(itemCount: homeController.dataList.length,itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: homeController.dataList[index]['status']==0?Colors.green.shade300 : Colors.red.shade300,
                      ),
                      width: double.infinity,height: 75,padding: EdgeInsets.all(5),margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("${homeController.dataList[index]['id']}"),
                          Column(
                            children: [
                              Text("${homeController.dataList[index]['category']}"),
                              SizedBox(height: 5),
                              Text("${homeController.dataList[index]['notes']}"),
                            ],
                          ),
                        ],
                      ),
                    );
                  },physics: BouncingScrollPhysics(),),
              ),
            ],
          ),
          ),
      ),
    );
  }
}
