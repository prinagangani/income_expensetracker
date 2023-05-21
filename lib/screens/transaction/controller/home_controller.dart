
import 'package:get/get.dart';
import 'package:income_expense/utils/db_helper.dart';

class HomeController extends GetxController{
  
  RxList<Map> dataList = <Map>[].obs;
  RxInt income = 0.obs;
  RxInt expense = 0.obs;
  RxInt total = 0.obs;

  Future<void> readData() async {
    dbHelper dbheler = dbHelper();
    dataList.value = await dbheler.read();
  }

  Future<void> incomeexpenseFilter(int status)
  async {
    dbHelper dbhelper = dbHelper();
    dataList.value = await dbhelper.incomeFilter(status: status);
  }

  void deleteData(int id) {
    dbHelper dbhelper = dbHelper();
    dbhelper.delete(id: id);
    readData();
  }

  void updateData(String amount, String category, String notes, int status,int id,String date, String time, String paytype) {
    dbHelper dbhelper = dbHelper();
    dbhelper.update(id: id, amount: amount, category: category, status: status, notes: notes, date: date, time: time, paytype: paytype);
    readData();
  }
  
}