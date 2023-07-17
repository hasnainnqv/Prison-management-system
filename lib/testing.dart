import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';



void main(){
SQL();
}

Future SQL() async {
  final connection = await MySqlConnection.connect(new ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'Root123',
      db: "priosn_management"
  ));
  var query='select * from staff';
  await connection.query(query);
  var staff_data= await connection.query(query);
  print(staff_data);
}



















