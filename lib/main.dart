// import 'dart:async';
// import 'package:desktop_window/desktop_window.dart';
// import 'package:flutter/material.dart';
// import 'package:prison_management_system/RoundedTextField.dart';
// import 'dart:io';
// import 'package:mysql1/mysql1.dart';
// import 'package:prison_management_system/front_page.dart';
// import 'package:prison_management_system/prison_list.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// void main() async{
//   runApp(MyApp());
//   Size size = await DesktopWindow.getWindowSize();
// // setting min and max with the same size to prevent resizing
//   await DesktopWindow.setMinWindowSize(Size(500,500));
//   await DesktopWindow.setMaxWindowSize(Size(500,500));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Splash Screen',
//
//
//       theme: ThemeData(
//           primarySwatch: Colors.blue
//       ),
//       home: MyHomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//
//
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 3),
//             ()=>Navigator.pushReplacement(context,
//             MaterialPageRoute(builder:
//                 (context) =>
//                 Mysecondpage()
//             )
//         )
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//         color: Color.fromARGB(100, 66, 0, 44),
//         child:Image.asset('assets/pngtree-human-hand-through-a-prison-cell-in-the-conclusion-cage-image_1609868.jpg',
//           fit: BoxFit.cover,
//
//
//         )
//     );
//   }
// }
//
//
//
//
// class Mysecondpage extends StatefulWidget {
//   @override
//   _SecondScreen createState() => _SecondScreen();
// }
// class _SecondScreen extends State<Mysecondpage>{
//   bool loadings= false;
//   var datalist=[];
//   var data=[];
//   var staff_name=TextEditingController();
//   var staff_id=TextEditingController();
//   var start_date=TextEditingController();
//
//
//
//   Future SQL() async {
//     final connection = await MySqlConnection.connect(new ConnectionSettings(
//         host: 'localhost',
//         port: 3306,
//         user: 'root',
//         password: 'Root123',
//         db: "priosn_management"
//     ));
//     var query='select FirstName,StaffID, StartDate from staff';
//     await connection.query(query);
//     var staff_data= await connection.query(query);
//     int c=0;
//     int nest=0;
//
//
//     for(var j in staff_data){
//       var date_tostr=j[2].toString().substring(0,10);
//       if ( (j['FirstName'].toString().trim())!=data[0].toString() && j['StaffID'].toString()!=data[1] && date_tostr!=data[2]){
//       // if ( (j['FirstName'].toString().trim())==data[0].toString() && j['StaffID'].toString()==data[1] && date_tostr==data[2]){
//         print("passed");
//         final connection2 = await MySqlConnection.connect(new ConnectionSettings(
//             host: 'localhost',
//             port: 3306,
//             user: 'root',
//             password: 'Root123',
//             db: "priosn_management"
//         ));
//         var query2='select PrisonID, PrisonName,Address from prison';
//         await connection2.query(query2);
//         var firstname_list= await connection2.query(query2);
//              if (datalist.length==0){
//                   for(var i in firstname_list){
//                     datalist.add(i);
//         }}
//
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> sucessful_login(datalist)));
//       }else{
//         Utils().showToast(context, 'Incorrect Credentials');
//       }
//
//     }
//     data=[];
//   }
//
//   @override
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("PRISONS"),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/4143495.jpg"),
//                 fit: BoxFit.cover
//             )
//         ),
//
//         child: Center(
//
//           child: Container(
//
//             color: Color.fromARGB(200, 0, 2, 5),
//
//             height: 500,
//             width: 500,
//             child: Column(
//
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                     child:Text("Admin",textScaleFactor: 2,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
//                 ),
//                 RoundedTextField(hint:'FIRST NAME',
//                   controller: staff_name,
//
//
//                 ) ,
//                 RoundedTextField(hint:'STAFF-ID',
//                   controller: staff_id,
//                   type: TextInputType.number,
//
//                 ) ,
//                 RoundedTextField(hint:'STARTDATE (YYYY-MM-DD)',
//                   controller: start_date,
//
//                 ) ,
//
//
//                 RoundedButton(onTap: (){
//
//                   data.addAll([staff_name.text.toString(),staff_id.text.toString(),start_date.text.toString()]);
//
//                   SQL();
//                 },  title:"Proceed",loading: loadings,)
//
//
//               ],
//
//
//             ),
//           ),
//         ),
//       ),
//
//     );
//
//
//   }
//
//
// }
//
//
// class sucessful_login extends StatefulWidget {
//   @override
//   var data_list=[];
//   sucessful_login(this.data_list);
//   _sucessful_loginState createState() => _sucessful_loginState(this.data_list);
// }
// class _sucessful_loginState extends State<sucessful_login> {
//   @override
//   var data_list=[];
//   _sucessful_loginState(this.data_list);
//
//
//   var lenght=[];
//   info()async  {
//     var obj1=SqlCommand();
//     var obj2=SqlCommand();
//     var obj3=SqlCommand();
//     var obj4=SqlCommand();
//     var obj5=SqlCommand();
//
//     await obj1.SQL('SELECT  count(*) from prisoner');
//     await obj2.SQL('SELECT  count(*) from cell');
//     await obj3.SQL('SELECT  count(*) from visitation');
//     await obj4.SQL('SELECT  count(*) from prison');
//     await obj5.SQL('SELECT  count(*) from employees');
//
//     lenght.add([obj5.query_dataset[0]['count(*)'],obj1.query_dataset[0]['count(*)'],obj4.query_dataset[0]['count(*)'],
//       obj2.query_dataset[0]['count(*)'],obj3.query_dataset[0]['count(*)']]);
//     setState(() {
//       lenght=lenght;
//
//     });
//   }
//
//
//
//   void initState() {
//     super.initState();
//     info();
//
//     Timer(Duration(seconds: 1),
//             ()=>Navigator.pushReplacement(context,
//             MaterialPageRoute(builder:
//                 (context) =>
//                 // PrisonList(data_list)
//               FRONTpage(data_list,lenght)
//             )
//         )
//     );
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//         color: Color.fromARGB(100, 66, 0, 44),
//         child:Image.asset('assets/login.jpeg',
//           // fit: BoxFit.fitWidth
//
//         )
//     );
//   }
// }



import 'dart:async';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/RoundedTextField.dart';
import 'dart:io';
import 'package:mysql1/mysql1.dart';
import 'package:prison_management_system/front_page.dart';
import 'package:prison_management_system/prison_list.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  runApp(MyApp());
  Size size = await DesktopWindow.getWindowSize();
  // setting min and max with the same size to prevent resizing
  await DesktopWindow.setMinWindowSize(Size(500, 500));
  await DesktopWindow.setMaxWindowSize(Size(500, 500));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MySecondPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(100, 66, 0, 44),
      child: Image.asset(
        'assets/pngtree-human-hand-through-a-prison-cell-in-the-conclusion-cage-image_1609868.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class MySecondPage extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<MySecondPage> {
  bool loadings = false;
  var datalist = [];
  var data = [];
  var staff_name = TextEditingController();
  var staff_id = TextEditingController();
  var start_date = TextEditingController();

  Future SQL() async {
    final connection = await MySqlConnection.connect(
      new ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'Root123',
        db: "priosn_management",
      ),
    );
    var query = 'select FirstName,StaffID, StartDate from staff';
    await connection.query(query);
    var staff_data = await connection.query(query);
    int c = 0;
    int nest = 0;

    for (var j in staff_data) {

      var date_tostr = j[2].toString().substring(0, 10);
      // if ((j['FirstName'].toString().trim()) == data[0].toString() &&
      //     j['StaffID'].toString() == data[1] &&
      //     date_tostr == data[2])
      if ((j['FirstName'].toString().trim()) != data[0].toString() &&
          j['StaffID'].toString() != data[1] &&
          date_tostr != data[2]) {
        final connection2 = await MySqlConnection.connect(
          new ConnectionSettings(
            host: 'localhost',
            port: 3306,
            user: 'root',
            password: 'Root123',
            db: "priosn_management",
          ),
        );
        var query2 = 'select PrisonID, PrisonName,Address from prison';
        await connection2.query(query2);
        var firstname_list = await connection2.query(query2);
        c+=1;
        if (datalist.length == 0) {
          for (var i in firstname_list) {
            datalist.add(i);
          }
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessfulLogin(datalist),

          ),
        );
        UtilsSuccess().showToast(context, 'Login Successfully');

        break;



      } else {
        if(c==staff_data.length){
          Utils().showToast(context, 'Incorrect Credentials');

        }
      }


    }
    data = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRISONS"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/4143495.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            color: Color.fromARGB(200, 0, 2, 5),
            height: 500,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Admin",
                    textScaleFactor: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RoundedTextField(
                  hint: 'FIRST NAME',
                  controller: staff_name,
                ),
                RoundedTextField(
                  hint: 'STAFF-ID',
                  controller: staff_id,
                  type: TextInputType.number,
                ),
                RoundedTextField(
                  hint: 'STARTDATE (YYYY-MM-DD)',
                  controller: start_date,
                ),
                RoundedButton(
                  onTap: () {
                    data.addAll([
                      staff_name.text.toString(),
                      staff_id.text.toString(),
                      start_date.text.toString(),
                    ]);
                    SQL();
                  },
                  title: "Proceed",
                  loading: loadings,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessfulLogin extends StatefulWidget {
  var data_list = [];
  SuccessfulLogin(this.data_list);
  @override
  _SuccessfulLoginState createState() => _SuccessfulLoginState(data_list);
}

class _SuccessfulLoginState extends State<SuccessfulLogin> {
  var data_list = [];
  _SuccessfulLoginState(this.data_list);

  var length = [];

  info() async {
    var obj1 = SqlCommand();
    var obj2 = SqlCommand();
    var obj3 = SqlCommand();
    var obj4 = SqlCommand();
    var obj5 = SqlCommand();


    await obj1.SQL('SELECT count(*) from prisoner');
    await obj2.SQL('SELECT count(*) from cell');
    await obj3.SQL('SELECT count(*) from visitation');
    await obj4.SQL('SELECT count(*) from prison');
    await obj5.SQL('SELECT count(*) from employees');

    length.add([
      obj5.query_dataset[0]['count(*)'],
      obj1.query_dataset[0]['count(*)'],
      obj4.query_dataset[0]['count(*)'],
      obj2.query_dataset[0]['count(*)'],
      obj3.query_dataset[0]['count(*)'],
    ]);

    setState(() {
      length = length;
    });
  }

  void initState() {
    super.initState();
    info();

    Timer(
      Duration(seconds: 1),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FRONTpage(data_list, length),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(100, 66, 0, 44),
      child: Image.asset(
        'assets/login.jpeg',
      ),
    );
  }
}


class data{
  var lenght=[];
  info()async  {
    var obj1=SqlCommand();
    var obj2=SqlCommand();
    var obj3=SqlCommand();
    var obj4=SqlCommand();
    var obj5=SqlCommand();

    await obj1.SQL('SELECT  count(*) from prisoner');
    await obj2.SQL('SELECT  count(*) from cell');
    await obj3.SQL('SELECT  count(*) from visitation');
    await obj4.SQL('SELECT  count(*) from prison');
    await obj5.SQL('SELECT  count(*) from employees');
    print(obj1.query_dataset[0]['count(*)']);

    lenght.add([obj1.query_dataset[0]['count(*)'],obj2.query_dataset[0]['count(*)'],obj3.query_dataset[0]['count(*)'],
      obj4.query_dataset[0]['count(*)'],obj5.query_dataset[0]['count(*)']]);
    lenght=lenght;
  }

}