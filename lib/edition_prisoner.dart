import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/prison_list.dart';

import 'RoundedTextField.dart';

class NewEdition_Prisoner extends StatefulWidget{
  @override
  // var prisoner_list;
  // NewEdition_Prisoner(this.prisoner_list);
  // this.prisoner_list
  State<StatefulWidget> createState()=> NewEdition_PrisonerState();

}
class NewEdition_PrisonerState extends State<NewEdition_Prisoner>{
  @override
  // var prisoner_list;
  // NewEdition_PrisonerState(this.prisoner_list);

  var prisonerid=TextEditingController();
  var cellid=TextEditingController();
  var offence=TextEditingController();
  var firstname=TextEditingController();
  var lastname=TextEditingController();
  var dob=TextEditingController();
  var gender=TextEditingController();
  var address=TextEditingController();
  var dor=TextEditingController();
  var doa=TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EDIT VIEW'),centerTitle: true),
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
                          child: Text('ASSIGN ID TO PRISOER',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),


                        Text("PRISONER ID"),
                        RoundedTextField(icon: Icons.add,
                          controller: prisonerid,
                          hint: 'Prisoner ID',

                        ),
                        Text("CELL ID"),
                        RoundedTextField(
                          labeltext: 'CellID',
                          controller:cellid,
                          type: TextInputType.text,
                        ),
                      ],),),

                  Container(height: 300,
                    width: 500,
                    color: Color.fromARGB(250, 135, 235, 250),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('CRIME COMMITTED',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                        Text("OFFENCE"),
                        RoundedTextField(
                          controller:offence,
                          labeltext: 'Offence',
                        ),

                      ],),),]
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
                        child: Text('PERSONAL INFORMATION OF INMATE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                              controller:lastname,
                              labeltext:'LastName',
                            ),]
                      ),
                      Row(
                          children:[Text("   Date Of Birth"),
                            RoundedTextField(
                              controller:dob,
                              labeltext: 'Date Of Birth',
                            ),
                            Text("   GENDER    "),
                            RoundedTextField(
                              controller:gender,
                              labeltext: 'Gender',
                            ),
                          ]),
                      Row(children: [Text("   ADDRESS      "),
                        RoundedTextField(
                          controller:address,
                          labeltext: 'Address',
                        ),]
                      )
                    ],),
                ),),
              Container(height: 280,
                  width: 800,
                  color: Color.fromARGB(250, 135, 235, 250),
                  child: Column(
                    children: [
                      Text('ADMISSION / RELEASE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [


                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("DATE OF ADMISSION"),
                                RoundedTextField(
                                  controller: doa,
                                  labeltext: 'Date of Admission',
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("DATE OF RELEASE"),
                                RoundedTextField(
                                  labeltext: 'Release Date',
                                    controller:dor
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(onPressed: ()async{
                        try{
                                var obj = SqlCommand();
                                print(
                                    '''
                                insert into prisoner
                                values(
                                ${prisonerid.text}
                                ${firstname.text}
                                ${lastname.text}
                                ${dob.text}
                                ${gender.text}
                                ${address.text}
                                ${doa.text}
                                ${dor.text}
                                ${offence.text}
                                ${cellid.text}'''
                                );
                                await obj.SQL('''
                                insert into prisoner
                                values('${prisonerid.text}','${firstname.text}','${lastname.text}','${dob.text}','${gender.text}','${address.text}','${doa.text}','${dor.text}','${offence.text}','${cellid.text}')''');

                                await obj.SQL('''
                                UPDATE cell
                                set occupancy=(select COUNT(PRISONERID) from prisoner where cellid='${cellid.text}')
                                where cellid='${cellid.text}';
                               
                                ''' );
                              }
                              catch(e){
                                Utils().showToast(context, e);}
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