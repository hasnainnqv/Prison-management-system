import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/RoundedTextField.dart';
import 'package:prison_management_system/prison_list.dart';

class visitation extends StatefulWidget {
  @override
  var visitor_list=[];
  var prisonerid;

  visitation(this.visitor_list,this.prisonerid);
  _visitationState createState() => _visitationState(this.visitor_list,this.prisonerid);
}
class _visitationState extends State<visitation> {

  var visitor_list=[];
  var index=0;
  var prisonerid;
  _visitationState(this.visitor_list,this.prisonerid);
  var variable='View';
  var visit=TextEditingController();
  var start=TextEditingController();
  var relation=TextEditingController();
  var prisonid=TextEditingController();

  var  bool_visit_id=true;
  var bool_start=true;
  var bool_relation=true;
  var bool_prisonid=true;

  @override

  void dispose(){
    visit.dispose();
    start.dispose();
    relation.dispose();
    prisonid.dispose();


    super.dispose();
  }



  setInitial(){
    setState(() {

      prisonid..text=prisonerid;
      if (visitor_list.length!=0 || visitor_list.length!=null) {
        visit..text = '${visitor_list[index]['VisitorID']}';
        start..text = visitor_list[index]['VisitDate'].toString();
        relation..text = visitor_list[index]['Relation'];
        prisonid..text = visitor_list[index]['PrisonerID'];

      }

    });
  }

  void initState() {
    setState(() {
      prisonid..text=prisonerid;

      if (visitor_list.length!=0) {
        visit..text = '${visitor_list[index]['VisitorID']}';
        start..text = visitor_list[index]['VisitDate'].toString();
        relation..text = visitor_list[index]['Relation'];
        prisonid..text = visitor_list[index]['PrisonerID'];
      }
    });
    super.initState();
  }



  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visitations')),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(

                image: AssetImage("assets/567.webp"),
                fit: BoxFit.cover
            )
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: 600,
              height: 500,
              color: Color.fromARGB(150, 34, 125, 110),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   if (visitor_list.length==0)
                    Text('No Visitation. Tap Add New to add visitation',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                  Column(


                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      isDense: true,
                      focusColor: Colors.black38,
                      value: variable,
                      iconSize: 10.0,
                      icon:  Icon(Icons.add,
                        color: Colors.black,),
                      items:['View','Edit','Add New'].map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: Text(items,style: TextStyle(color: Colors.black87),)
                        );
                      }).toList(),
                      onChanged: (Object? value) {
                        setState(() {
                          variable=value.toString();
                         if(value=='View'){
                            setInitial();

                            bool_visit_id=true;
                            bool_prisonid=true;
                            bool_relation=true;
                            bool_start=true;


                          }
                          else if(value=='Edit'){
                            bool_relation=false;
                            bool_start=false;
                            bool_prisonid=false;
                            bool_visit_id=true;


                            setInitial();

                          }
                          else if(value=='Add New'){
                            bool_visit_id=false;
                            visit..text='';
                            start..text='';
                            relation..text='';


                            bool_relation=false;
                            bool_start=false;
                            bool_prisonid=true;
                            bool_visit_id=false;
                          }

                        });

                      },
                      onTap: (){

                      },


                    ),

                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        ElevatedButton(onPressed: (){
                          if(index<visitor_list.length-1){
                            setState(() {
                              index+=1;
                              print(index);
                            });
                            setInitial();
                          }


                        }, child: Text('Next')),

                          ElevatedButton(onPressed: (){
                            if(index>0){
                              setState(() {
                                index-=1;
                                print(index);
                              });
                              setInitial();
                            }

                          }, child: Text('Back'))
                      ],),
                    ),

                    Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Visitor ID     ",style: TextStyle(fontWeight: FontWeight.bold)),
                      RoundedTextField(
                        readonly: bool_visit_id,
                        controller: visit,

                      )
                      ],
                    ),
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Prisoner ID  ",style: TextStyle(fontWeight: FontWeight.bold),),
                        RoundedTextField(
                          controller: prisonid,
                          readonly: bool_prisonid,
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Relation     ",style: TextStyle(fontWeight: FontWeight.bold)),
                        RoundedTextField(
                          controller: relation,
                          readonly: bool_relation,
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Visit Date    ",style: TextStyle(fontWeight: FontWeight.bold)),
                        RoundedTextField(controller: start,
                        readonly: bool_start,
                        )
                      ],
                    ),
                  ElevatedButton(onPressed: ()async{
                    var obj= SqlCommand();

                    try{
                              if (variable == 'Edit') {
                                await obj.SQL('''
                      update visitation
                      set relation='${relation.text}',
                      PrisonerID='${prisonid.text}',
                      VisitDate='${start.text}'
                      where visitorID=${int.parse(visit.text)}
                      ''');
                              } else if (variable == 'Add New') {
                                await obj.SQL('''
                      insert into visitation
                      values(${int.parse(visit.text)},'${prisonid.text}','${start.text}','${relation.text}')
                              ''');
                              }
                              UtilsSuccess().showToast(context, 'Updation Completed');


                    }catch(e){
                      Utils().showToast(context, e);
                    }
                          },


                      child: Text('DONE'))
                  ],
            ),
                ],
              ),),
          ),
        ),
      ),
    );
  }
}