
import 'dart:async';
import 'dart:ui';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:prison_management_system/RoundedTextField.dart';
import 'package:prison_management_system/main.dart';
import 'package:prison_management_system/prison_list.dart';

class FRONTpage extends StatefulWidget{
  @override
  var datalist=[];
  var length;
  FRONTpage(this.datalist,this.length);

  State<FRONTpage> createState() => _FRONTpageState(this.datalist,this.length);
}
class _FRONTpageState extends State<FRONTpage>{
  var datalist=[];
  var length;
  var message='';
  var timeleft=0;

  _FRONTpageState(this.datalist,this.length);
  var columns=[];
  var attributes='';
  var dataMap=[];
  Map<String,double> data={};

  crimereport()async{
    var obj = SqlCommand();
    await obj.SQL('SELECT DISTINCT OFFENSE, COUNT(OFFENSE) FROM PRISONER GROUP BY OFFENSE');
    for (var i in obj.query_dataset){
      dataMap.add(['${i['OFFENSE']}',i['COUNT(OFFENSE)']]);
      data.addAll({'${i['OFFENSE']}':(i['COUNT(OFFENSE)']).toDouble()});
    }
    print(data);
  }
  commands(table_name)async{
     var obj = SqlCommand();
     await obj.SQL('Show columns from $table_name');
     for(var i in obj.query_dataset){
       message+=' \u2022 ${i[0]}\n';
     }
     setState(() {
       message=message;
       attributes=table_name.toString().toUpperCase();
     });
  }
 void counter(time){
   Timer.periodic(Duration(milliseconds: time), (timer) {
     setState(() {
       if (timeleft<9) {
          timeleft++;
        }else{timer.cancel();}
      });
   });
 }

  @override
  var INFORMATION=['EMPLOYEES','PRISONERS','PRISONS','CELL','VISITATIONS'];
  var images=['assets/staff.jpg','assets/prisoner.jpg','assets/prisons.jpg','assets/prisons.jpg','assets/relatives.jpg'];
  @override

  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: 300,
                color: Colors.blueGrey,
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: (20.0)),
                      child: Container(
                        width: 300,
                        height: 80,
                      color: Colors.black,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("PRISON MANAGEMENT",style: TextStyle(

                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic

                            ),
                            ),
                          ),
                          Text("SYSTEM",style: TextStyle(

                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          ),)
                        ],
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: (30.0),bottom: (8.0),left: (8.0)),
                      child: TextButton.icon(onPressed: (){
                        setState(() {
                          crimereport();
                          message='';
                          attributes='';
                        });},
                        icon: Icon(Icons.dashboard,size: 30,color: Colors.white,),
                        label: Text('DASHBOARD',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(onPressed: (){
                        commands('staff');
                        message='';
                      }, icon: Icon(Icons.work,size: 30,color: Colors.white,),
                        label: Text('STAFF',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(onPressed: (){
                        commands('prisoner');
                        message='';
                      }, icon: Icon(Icons.person,size: 30,color: Colors.white,),
                        label: Text('PRISONERS',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(onPressed: (){
                        commands('cell');
                        message='';
                      }, icon: Icon(Icons.route_outlined,size: 30,color: Colors.white,),
                        label: Text('CELLS',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(onPressed: (){
                        commands('visitation');
                        message='';
                      }, icon: Icon(Icons.back_hand_sharp,size: 30,color: Colors.white,),
                        label: Text('VISITATIONS',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton.icon(onPressed: (){
                        commands('prison');
                        message='';
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PrisonList(datalist)));
                      }, icon: Icon(Icons.privacy_tip,size: 30,color: Colors.white,),
                        label: Text('PRISONS',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                    ),
                  ],
                ),
                ),

                  Container(
                    width: 1100,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(


                        height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(width: 2.0,style: BorderStyle.solid)
                            )
                          ),
                      ),
                      Container(

                        child: Column(
                          children: [
                            Center(
                              child: Text("DASHBOARD",style: TextStyle(

                                  fontSize: 25,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic
                              ),),
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.,
                              children: [

                          Container(
                            height: 300,
                            width: 1100,
                            child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 30,
                            crossAxisCount: 5,
                              crossAxisSpacing: 10
                            ),
                            itemCount: INFORMATION.length,
                            itemBuilder: (context,index){
                            return Container(
                                  child: Container(
                                    height: 300,
                                  width: 200,
                                  decoration: BoxDecoration(
                                  color: [Colors.greenAccent,Colors.deepOrangeAccent,Colors.blue,Colors.lightGreenAccent,Colors.red].elementAt(index),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                                  ),
                            child: Center(child:
                            Text.rich(
                              textAlign: TextAlign.center,

                              TextSpan(
                                children: [
                                  WidgetSpan(child: Center(child: Image.asset(images[index],height: 40,width: 40,))),
                                  TextSpan(text: "\nTOTAL ${INFORMATION[index]} ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)  ),
                                  TextSpan(text: "${length[0][index]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)  ),
                                ],
                            ),
                            )
                            ),),
                            );
                        }),
    ),
                              ],
                            ),

                          ],
                        ),
                      ),
                        Row(

                          children: [

                            Container(width: 450,
                              height: 300,

                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              if(attributes!='')
                              Text('ATTRIBUTES FOR $attributes',style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black
                              ),),
                              Text("$message",style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black
                              ))]
                              ),
                            ),
                            if (data.length!=0)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 600,
                                height: 300,
                                child: PieChart(
                                  dataMap: data,
                                  animationDuration: Duration(milliseconds: 800),
                                  chartLegendSpacing: 32,
                                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                                  initialAngleInDegree: 0,
                                  chartType: ChartType.ring,
                                  ringStrokeWidth: 32,
                                  centerText: "CRIME SUMMARY",
                                  legendOptions: LegendOptions(
                                    showLegendsInRow: false,
                                    legendPosition: LegendPosition.right,
                                    showLegends: true,
                                    legendTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValueBackground: true,
                                    showChartValues: true,
                                    showChartValuesInPercentage: false,
                                    showChartValuesOutside: false,
                                    decimalPlaces: 1,
                                  ),
                                  // gradientList: ---To add gradient colors---
                                  // emptyColorGradient: ---Empty Color gradient---
                                )

                       ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              ],
            ),
      ),
    );
  }
}





