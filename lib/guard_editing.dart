import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/prison_list.dart';

import 'RoundedTextField.dart';

class Edit_View_Guard extends StatefulWidget{
  @override
  var employer_data;
  var workplace;
  Edit_View_Guard(this.employer_data,this.workplace);

  State<StatefulWidget> createState()=> Edit_View_GuardState(this.employer_data,this.workplace);
}

class Edit_View_GuardState extends State<Edit_View_Guard>{
  @override
  var employer_data;
  var workplace;
  Edit_View_GuardState(this.employer_data,this.workplace);

  var firstname=TextEditingController();
  var lastname=TextEditingController();
  var gender=TextEditingController();
  var address=TextEditingController();
  var dob=TextEditingController();
  var duty_place=TextEditingController();
  var contact_number=TextEditingController();

  @override
  void initState() {
    setState(() {
      firstname..text=employer_data['FirstName'];
      lastname..text=employer_data['LastName'];
      gender..text=employer_data['Sex'];
      address..text=employer_data['Address'];
      dob..text=employer_data['DOB'].toString();
      duty_place..text=workplace;
      contact_number..text=employer_data['PhoneNum'];

    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GUARD EDIT INFORMATION'),),
      body: Container(
        color: Color.fromARGB(250, 135, 235, 250),

        child: Row(
          children: [
            Column(
                children: [
                  Container(height: 300,
                    width: 540,
                    color: Color.fromARGB(250, 135, 235, 250),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('ASSIGN ID TO GUARD',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        Text("GUARD ID"),
                        RoundedTextField(icon: Icons.add,
                          readonly: true,
                          initialvalue: '${employer_data['GuardID']}',
                        ),
                        Text("EMP ID"),
                        RoundedTextField(
                          readonly: true,
                          initialvalue: '${employer_data['empid']}',
                          type: TextInputType.text,),],),),
                  Container(height: 300,
                    width: 540,
                    color: Color.fromARGB(250, 135, 235, 250),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('ASSIGN DUTY TO PRISON ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                        Text("PRISON ID"),
                        RoundedTextField(
                          controller: duty_place,
                          type: TextInputType.text,
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
                        child: Text('PERSONAL INFORMATION OF GUARD',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      Row(
                          children: [
                            Text("   FIRST NAME  "),
                            RoundedTextField(controller: firstname,
                            ),
                            Text("   LAST NAME"),
                            RoundedTextField(
                              controller: lastname,
                            ),]
                      ),
                      Row(
                          children:[Text(" DATE OF BIRTH"),
                            RoundedTextField(controller: dob,
                            ),
                            Text("   GENDER      "),
                            RoundedTextField(
                              controller: gender),
                          ]),
                    ],),
                ),),


              Container(height: 280,
                  width: 800,
                  color: Color.fromARGB(250, 135, 235, 250),
                  child: Column(
                    children: [
                      Text('CONTACT INFORMATION',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(children:[
                                  Text("ADDRESS"),
                                  RoundedTextField(
                                    controller: address,
                                  ),
                                  Text("CONTACT NUMBER"),
                                  RoundedTextField(
                                  controller: contact_number,
                                  )])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        var obj = SqlCommand();
                        try {

                          obj.SQL(
                          '''
                          update guard set
                        GuardID='${duty_place.text}',
                        FirstName='${firstname.text}',
                        LastName='${lastname.text}',
                        DOB='${dob.text}',
                        Sex='${gender.text}',
                        Address='${address.text}',
                        PhoneNum='${contact_number.text}'
                        where empid='${employer_data['empid']}'
                          ''');

                          obj.SQL("update employees set PrisonID='${duty_place.text}' where empid='${employer_data['empid']}'");
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

