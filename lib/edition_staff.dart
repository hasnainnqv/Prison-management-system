import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/prison_list.dart';

import 'RoundedTextField.dart';

class Edition_Staff extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> Edition_StaffState();
}

class Edition_StaffState extends State<Edition_Staff>{
  @override
  var staffid=TextEditingController();
  var empid=TextEditingController();
  var firstname=TextEditingController();
  var lastname=TextEditingController();
  var designation=TextEditingController();
  var age=TextEditingController();
  var doa=TextEditingController();
  var duty_place=TextEditingController();



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('STAFF EDIT INFORMATION'),
      ),
      body: Container(
        color: Color.fromARGB(250, 135, 235, 250),

        child: Row(
          children: [
            Column(
                children: [
                  Container(height: 300,
                    width: 500,
                    color: Color.fromARGB(250, 135, 235, 250),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('ASSIGN ID TO STAFF',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),


                        Text("STAFF ID"),
                        RoundedTextField(icon: Icons.add,
                          labeltext: "Staff ID",
                          controller: staffid,

                        ),
                        Text("EMP ID"),
                        RoundedTextField(
                          labeltext: "EMP ID",
                          controller: empid,

                          type: TextInputType.text,),],),),

                  Container(height: 300,
                    width: 500,
                    color: Color.fromARGB(250, 135, 235, 250),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('ASSIGN DUTY TO PRISON ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),

                        Text("PRISON ID"),
                        RoundedTextField(
                            type: TextInputType.text,
                          labeltext: "PRISON ID",
                          controller: duty_place,
                        ),
                      ],

                    ),),


                ]
            ),
            Column(children: [
              Container(height: 320,
                width: 800,
                color: Color.fromARGB(250, 135, 235, 250),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('PERSONAL INFORMATION OF STAFF MEMBER',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      Row(
                          children: [
                            Text("   FIRST NAME  "),
                            RoundedTextField(
                              labeltext: "First Name",
                              controller: firstname,
                            ),

                            Text("   LAST NAME"),
                            RoundedTextField(
                              labeltext: "Last Name",
                              controller: lastname,
                            ),]
                      ),

                      Row(
                          children:[Text("   DESIGNATION"),
                            RoundedTextField(
                              labeltext: "Designation",
                              controller: designation,
                            ),

                            Text("   AGE      "),
                            RoundedTextField(
                              labeltext: "Age",
                              type: TextInputType.number,
                            controller: age,
                            ),
                          ]),


                    ],),
                ),),


              Container(height: 280,
                  width: 800,
                  color: Color.fromARGB(250, 135, 235, 250),
                  child: Column(
                    children: [
                      Text('ADMISSION',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("START DATE"),
                                RoundedTextField(
                                  controller: doa,
                                  labeltext: "Start Date",
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(onPressed: ()async{
                        try{
                          var obj = SqlCommand();
                          obj.SQL("insert into employees values('${empid.text}','${duty_place.text}','staff')");
                          await obj.SQL('''
                          insert into staff values(
                          '${staffid.text}',
                          '${doa.text.toString()}',
                          '${age.text}',
                          '${firstname.text}',
                          '${lastname.text}',
                          '${designation.text}',
                          '${empid.text}'
                          )
                          
                          ''');
                          UtilsSuccess().showToast(context, 'Updation Completed');

                        }catch(e){
                          Utils().showToast(context, e);                  }
                      }, child: Text('DONE'))
                    ],
                  )
              ),
            ],)

          ],
        ),
      ),

    );

  }
}
