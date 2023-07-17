
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prison_management_system/prison_list.dart';

import 'RoundedTextField.dart';

class prison_edition extends StatefulWidget{
  @override
  var addition_type;
  prison_edition(this.addition_type);

  State<StatefulWidget> createState()=> prison_editionState(this.addition_type);

}

class prison_editionState extends State<prison_edition>{
  @override
  var type=[];
  prison_editionState(this.type);


  var prisonID=TextEditingController();
  var address=TextEditingController();
  var prisonname=TextEditingController();
  var cellid=TextEditingController();
  var occupancy=TextEditingController();
  var capacity=TextEditingController();
  var phonenumber=TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ADD ${type[0].toUpperCase()}'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(

                image: AssetImage("assets/yu.webp"),
                fit: BoxFit.cover
            )
        ),
        child: Center(
          child: Container(
            height: 500,
            width: 600,
            color: Color.fromARGB(150, 34, 125, 110),


            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                if (type[0]=='Prison')
                Column(


                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("PrisonID                 ",style: TextStyle(fontWeight: FontWeight.bold)),
                          RoundedTextField(
                            labeltext: 'PrisonID (PR)',
                            controller: prisonID,

                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Prison Name          ",style: TextStyle(fontWeight: FontWeight.bold)),
                        RoundedTextField(

                          controller: prisonname,
                          labeltext:'Prison Name' ,
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Address                 ",style: TextStyle(fontWeight: FontWeight.bold)),
                        RoundedTextField(
                          controller: address,
                          labeltext: 'Enter Prison Address',
                        )
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Capacity               ",style: TextStyle(fontWeight: FontWeight.bold)),
                        RoundedTextField(
                          controller: capacity,
                          labeltext: 'Capacity of Prison',
                        )
                      ],
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Phone Number    ",style: TextStyle(fontWeight: FontWeight.bold)),
                        RoundedTextField(
                          controller: phonenumber,
                          labeltext: 'Enter telephone number with dashes',
                        )
                      ],
                    ),
                    ElevatedButton(

                        onPressed: ()async{
                      var obj =SqlCommand();

                      try{
                              await obj.SQL('''
                          insert into prison values(
                          '${prisonID.text}','${prisonname.text}','${address.text}',${capacity.text},'${phonenumber.text}'
                          )
                          ''');
                              UtilsSuccess().showToast(context, 'Updation Completed');

                      }catch(e){
                        Utils().showToast(context, e);                      }
                          }, child: Text('Done',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))

                  ],
                ),

                ////////////////////////////////////////////
                if (type[0]=='cell')
                  Column(


                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Center(



                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Cell ID        "),
                            RoundedTextField(
                              controller: cellid,

                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Prison ID     "),
                          RoundedTextField(
                            readonly: true,
                            initialvalue: type[1],
                          )
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Capacity     "),
                          RoundedTextField(
                            controller: capacity,
                          )
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Occupancy  "),
                          RoundedTextField(
                            controller: occupancy,
                          )
                        ],
                      ),


                      ElevatedButton(onPressed: ()async{
                        var obj =SqlCommand();
                        try{
                              await obj.SQL('''
                          insert into cell values(
                          '${cellid.text}','${type[1]}','${capacity.text}','${occupancy.text}'
                          )
                          ''');
                            }
                            catch(e){
                          Utils().showToast(context, e);
                            }
                          }, child: Text('Done',style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold ),)
                      )

                    ],
                  ),


              ],
            ),
          ),
        ),
      ),

    );

  }
}



