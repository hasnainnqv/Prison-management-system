
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/prison_list.dart';

import 'RoundedTextField.dart';

class Edition_Guard extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> Edition_GuardState();

}


class Edition_GuardState extends State<Edition_Guard>{
  @override
  var guardid=TextEditingController();
  var empid=TextEditingController();
  var firstname=TextEditingController();
  var lastname=TextEditingController();
  var gender=TextEditingController();
  var address=TextEditingController();
  var dob=TextEditingController();
  var duty_place=TextEditingController();
  var contact_number=TextEditingController();



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
                        RoundedTextField(icon: Icons.info,
                          labeltext: 'Guard ID',
                          controller: guardid,

                        ),
                        Text("EMP ID"),
                        RoundedTextField(
                          controller:empid,
                          labeltext: 'EMP ID',
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
                          controller:duty_place,
                          labeltext: 'Prison ID',
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
                            RoundedTextField(
                              controller:firstname,
                              labeltext: 'First Name',
                            ),

                            Text("   LAST NAME"),
                            RoundedTextField(
                              labeltext: 'Last Name',
                              controller: lastname,
                            ),]
                      ),

                      Row(
                          children:[Text(" DATE OF BIRTH"),
                            RoundedTextField(
                              controller: dob,
                              labeltext: 'Date OF Birth',
                            ),

                            Text("   GENDER      "),
                            RoundedTextField(
                              controller: gender,
                              labeltext: 'Gender',
                            ),
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
                                      labeltext: 'Address',
                                    ),
                                    Text("CONTACT NUMBER"),
                                    RoundedTextField(
                                      controller: contact_number,
                                      labeltext: 'Phone Number',
                                    )])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(onPressed: ()async{
                        var obj=SqlCommand();
                        try{
                          await obj.SQL('''
                        insert into employees values('${empid.text}','${duty_place.text}','guard')
                     ''');


                                await obj.SQL('''
                        insert into guard values(
                        '${guardid.text}','${firstname.text}','${lastname.text}','${dob.text}','${gender.text}','${address.text}','${contact_number.text}','${empid.text}')                        
                        ''');


                              }catch(e){
                          Utils().showToast(context, e);                        }
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

