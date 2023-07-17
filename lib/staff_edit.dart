
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/prison_list.dart';

import 'RoundedTextField.dart';

class Edit_View_Staff extends StatefulWidget{
  @override
  var employer_data;
  var workplace;
  Edit_View_Staff(this.employer_data,this.workplace);

  State<StatefulWidget> createState()=> Edit_View_StaffState(this.employer_data,this.workplace);

}

class Edit_View_StaffState extends State<Edit_View_Staff>{
  @override
  var employer_data;
  var workplace;
  Edit_View_StaffState(this.employer_data,this.workplace);


  var firstname=TextEditingController();
  var lastname=TextEditingController();
  var designation=TextEditingController();
  var age=TextEditingController();
  var doa=TextEditingController();
  var duty_place=TextEditingController();

  @override
  void initState() {
    setState(() {
      firstname..text=employer_data['FirstName'];
      lastname..text=employer_data['LastName'];
      designation..text=employer_data['Designation'];
      age..text=employer_data['Age'].toString();
      doa..text=employer_data['StartDate'].toString();
      duty_place..text=workplace;

    });
    super.initState();
  }


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
         readonly: true,
           initialvalue: '${employer_data['StaffID']}',


         ),
         Text("EMP ID"),
         RoundedTextField(
         readonly: true,
         initialvalue: '${employer_data['empid']}',
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
         controller: duty_place,),
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
           controller: firstname,
         ),

         Text("   LAST NAME"),
         RoundedTextField(
           controller: lastname,
                   ),]
              ),

         Row(
         children:[Text("   DESIGNATION"),
         RoundedTextField(
           controller: designation,
         ),

         Text("   AGE            "),
         RoundedTextField(
           controller: age,
           type: TextInputType.number,
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
         )
          ],
           ),
            ],
             ),
                ),
         ElevatedButton(onPressed: ()async{

           var obj= SqlCommand();
           try{
             await obj.SQL(
             '''
             update staff set
                          StartDate='${doa.text}',
                          age='${age.text}',
                          firstname='${firstname.text}',
                          lastname='${lastname.text}',
                          designation='${designation.text}' where empid='${employer_data['empid']}' ''');

             await obj.SQL("update employees set prisonID = '${workplace}' where empid='${employer_data['empid']}'");
             UtilsSuccess().showToast(context, 'Updation Completed');

           }catch(e){
             Utils().showToast(context, e); }


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



