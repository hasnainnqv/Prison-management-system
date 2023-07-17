
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/RoundedTextField.dart';
import 'package:prison_management_system/edition_guard.dart';
import 'package:prison_management_system/guard_editing.dart';
import 'package:prison_management_system/prison_list.dart';
import 'package:prison_management_system/staff_edit.dart';

import 'edition_staff.dart';

class staff_view extends StatefulWidget {
  @override
  var employee_list=[];
  staff_view(this.employee_list);
  _staff_viewState createState() => _staff_viewState(this.employee_list);
}
class _staff_viewState extends State<staff_view> {
  @override
  var employee_list=[];
  var columnName=[];
  var employees_data;
  var items=['guard','staff'];
  String variable='staff';
  _staff_viewState(this.employee_list);





  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Staff Information"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      width: 300,
                      height: 1000,
                      color: Color.fromARGB(100, 34, 125, 110),
                      child: Column(
                        children: [

                            Text("STAFF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),//NEEDS TO BE MODIFY
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                  Container(
                                  height: 400,
                                  child: ListView.separated(

                                      itemBuilder: (context,index){
                                        return ListTile(
                                          subtitle: Text('${employee_list[index][0]}',style: TextStyle(fontWeight: FontWeight.bold),),
                                          onTap: () async{
                                            if (employee_list[index][1]=='guard'){
                                                var obj=SqlCommand();
                                                await obj.SQL("select * from guard where empid='${employee_list[index][0]}'");
                                                employees_data=obj.query_dataset[0];

                                                obj.query_dataset=[];
                                                await obj.SQL('show columns from guard');
                                                columnName=[];
                                                for (var i in obj.query_dataset){
                                                  columnName.add(i[0]);
                                                }
                                                        setState(() {
                                                          columnName=columnName;
                                                          employees_data=employees_data;
                                                        });
                                                // employees_data=[];
                                                // columnName=[];

                                              }
                                            else{
                                              var obj=SqlCommand();
                                              await obj.SQL("select * from staff where empid='${employee_list[index][0]}'");
                                              employees_data=obj.query_dataset[0];

                                              obj.query_dataset=[];
                                              await obj.SQL('show columns from staff');
                                              columnName=[];
                                              for (var i in obj.query_dataset){
                                                columnName.add(i[0]);
                                              }
                                              setState(() {
                                                columnName=columnName;
                                                employees_data=employees_data;
                                              });



                                            }
                                          }

                                          );
                                      },


                                      separatorBuilder: (context,index) {
                                        return Divider(height: 5,thickness: 5);
                                      },

                                      itemCount: employee_list.length),
                                ),

                                Text("TO ADD STAFF MEMBER CLICK BELOW"),
                                FloatingActionButton(
                                  onPressed: () {
                                  },

                                  backgroundColor: Colors.black87,
                                  mouseCursor: MouseCursor.uncontrolled,


                                  child: DropdownButton(
                                    isDense: true,
                                    focusColor: Colors.black38,
                                    value: variable,



                                    iconSize: 10.0,
                                    icon:  Icon(Icons.add,
                                    color: Colors.white,),
                                    items:items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,style: TextStyle(color: Colors.white,backgroundColor: Colors.black ),)
                                      );
                                    }).toList(),
                                    onChanged: (Object? value) {
                                      setState(() {
                                        variable=value.toString();
                                      });
                                      if (variable=='staff'){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Edition_Staff()));
                                      }
                                      else if(variable=='guard'){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Edition_Guard()));

                                      }
                                    },
                                    onTap: (){

                                    },


                                  ),
                                )


                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,

                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Container(
                      color: Colors.white,
                      height: 700,
                      width: 1000,
                      child: Column(
                        children: [
                          Container(
                            width: 700,
                            child: Table(
                                textDirection: TextDirection.ltr,
                                border: TableBorder.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 3),
                                children: [
                                  for(int i=0 ; i<columnName.length;i++)
                                    TableRow( children: [
                                      Column(children:[
                                        Text('${columnName[i]}', style: TextStyle(fontSize: 20.0))]),
                                      Column(children:[
                                        Text('${employees_data[i]}', style: TextStyle(fontSize: 20.0))]),
                                    ]),
                                ]),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: ()async{
                                  var obj=SqlCommand();

                                  try{
                                    await obj.SQL('''
                                    delete from guard where empid = '${employees_data['empid']}
                                    ''');
                                  }catch(e){}

                                  try{
                                    await obj.SQL('''
                                    delete from staff where empid = '${employees_data['empid']}
                                    ''');
                                  }catch(e){}

                                  try{
                                    await obj.SQL('''
                                    delete from employees where empid = '${employees_data['empid']}
                                    ''');
                                  }catch(e){}
                                UtilsSuccess().showToast(context, 'Data Of ${employees_data['empid']} is Deleted');
                                }, child: Text('DELETE'),

                                ),
                              ),

                              ElevatedButton(onPressed: ()async{
                                var obj = SqlCommand();
                                await obj.SQL("select prisonID FROM EMPLOYEES where empid='${employees_data['empid']}'");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Edit_View_Staff(employees_data,obj.query_dataset[0]['prisonID'])));
                                if(employees_data['StaffID'].runtimeType==int){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Edit_View_Staff(employees_data,obj.query_dataset[0]['prisonID'])));
                                }
                                else if((employees_data['GuardID'].runtimeType==String)){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Edit_View_Guard(employees_data,obj.query_dataset[0]['prisonID'])));

                                }

                              }, child: Text('EDIT'))
                            ],),
                          )
                        ],
                      ),
                    ),
                  ),
                  ),


            ],
          ),
        ),



    );
  }
}


class Edit_View_Prisoner extends StatefulWidget{
  @override
  var prisoner_list;
  Edit_View_Prisoner(this.prisoner_list);

  State<StatefulWidget> createState()=> Edit_View_PrisonerState(this.prisoner_list);

}
class Edit_View_PrisonerState extends State<Edit_View_Prisoner>{
  @override
  var prisoner_list;
  Edit_View_PrisonerState(this.prisoner_list);


  var cellid=TextEditingController();
  var offence=TextEditingController();
  var firstname=TextEditingController();
  var lastname=TextEditingController();
  var dob=TextEditingController();
  var gender=TextEditingController();
  var address=TextEditingController();
  var dor=TextEditingController();
  var doa=TextEditingController();

 @override
  void initState() {
    setState(() {
      cellid..text=prisoner_list['cellID'];
      offence..text=prisoner_list['Offense'];
      firstname..text=prisoner_list['FirstName'];
      lastname..text=prisoner_list['LastName'];
      dob..text=prisoner_list['DOB'];
      gender..text=prisoner_list['Sex'];
      address..text=prisoner_list['Address'];
      dor..text=prisoner_list['DateOfRelease'];
      doa..text=prisoner_list['DateOfAdmission'];

    });
    super.initState();
  }



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
                  readonly: true,
                  initialvalue: prisoner_list['PrisonerID'],



                ),
                  Text("CELL ID"),
                  RoundedTextField(
                    controller: cellid,
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
                      controller: offence,
                    ),

                  ],),),


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
                      child: Text('PERSONAL INFORMATION OF INMATE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                        children:[Text("   Date Of Birth"),
                    RoundedTextField(
                      controller: dob,
                    ),

                    Text("   GENDER    "),
                    RoundedTextField(
                      controller: gender,
                    ),
]),
                    Row(children: [Text("   ADDRESS      "),
                    RoundedTextField(
                      controller: address,
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
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("DATE OF RELEASE"),
                          RoundedTextField(
                            controller: dor,
                          )
                        ],
                      ),
                      ],
                    ),
                  ),
                  ElevatedButton(onPressed: ()async{
                    try{
                      var obj = SqlCommand();
                                await obj.SQL('''
                                update prisoner
                                set firstname='${firstname.text}',lastname='${lastname.text}',dob='${dob.text}',Sex='${gender.text}',address='${address.text}',DateOfAdmission='${doa.text}',
                                DateOfRelease='${dor.text}',offense='${offence.text}',
                                cellid='${cellid.text}' where prisonerID='${prisoner_list['PrisonerID']}'                        
                                ''');
                      UtilsSuccess().showToast(context, 'Updation Completed');

                    }
                              catch(e){
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





