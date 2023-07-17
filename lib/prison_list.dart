import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:prison_management_system/RoundedTextField.dart';
import 'package:prison_management_system/edition_prisoner.dart';
import 'package:prison_management_system/prison_cell_edition.dart';
import 'package:prison_management_system/staff_view.dart';
import 'package:prison_management_system/testing.dart';
import 'package:prison_management_system/visitations.dart';
void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget{
  const myApp({Key? key}) : super(key:key);
  @override

  Widget build(BuildContext context){
    return MaterialApp(

      title: "PRISON MANAGEMENT SYSTEM",
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,


      ),
      home: PrisonList(null),



    );


  }
}
class SqlCommand {
  var query_dataset=[];
  Future SQL(var query) async {
    final connection = await MySqlConnection.connect(new ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'Root123',
        db: "priosn_management"
    ));
    await connection.query(query);
    var cellquery = await connection.query(query);
    for(var i in cellquery){
      query_dataset.add(i);
    }
  }

}

  class PrisonList extends StatefulWidget{
  var data;
  
  PrisonList(this.data);
  @override
  State<PrisonList> createState() => _PrisonListState(data);
}

class _PrisonListState extends State<PrisonList>{
  var data=[];
  var cellno;
  _PrisonListState(this.data);
  var cell_list=[];
  var connector;


  @override


  Future SQL() async {
    final connection = await MySqlConnection.connect(new ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'Root123',
        db: "priosn_management"
    ));
    connector=connection;
    var query="select * from cell where PrisonID = '$cellno'";
    await connection.query(query);
    var cellquery=await connection.query(query);
    for(var i in cellquery){
      cell_list.add(i);
    }
    print("object");
    print(cellno);
    Navigator.push(context, MaterialPageRoute(builder: (context)=> CellNumbers(cell_list,cellno)));

  }
    Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text("Prisons Information")),



        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(

                  image: AssetImage("assets/listview.jpg"),
                  fit: BoxFit.cover
              )
          ),
          child: Column(

            children: [
              Container(
                height: 500,
                child: ListView.separated(
                    itemBuilder: (context,index){
                      return ListTile(
                          leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black26,
                          child: Image.asset('assets/prison.jpg',scale: 2)
                      ),
                      title: Card(
                      elevation: 1,
                          child: Text("${data[index]["PrisonID"]} ${data[index]['PrisonName']}",style: TextStyle(fontWeight: FontWeight.bold),)),
                          subtitle: Text("${data[index]["Address"]}",style: TextStyle(fontFamily: "Asper_crown" ),),
                          trailing: Icon(Icons.add),
                          onTap: (){
                              cellno=data[index]["PrisonID"];
                              SQL();
                              cell_list=[];
                              setState(() {
                                cellno=data[index]["PrisonID"];
                              });

                          }
                              );
                      },

                    separatorBuilder: (context,index) {
                      return Divider(height: 50,thickness: 15);
                      },

                    itemCount: data.length)
    ),
              FloatingActionButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>prison_edition(['Prison'])));


              },
                child: Icon(Icons.add),

              )

            ],
          ),
        ),


    );
  }
}


class CellNumbers extends StatefulWidget{
  @override
  var cell_list=[];
  var cellno;
  CellNumbers(this.cell_list,this.cellno);
  State<StatefulWidget> createState()=> _CellNumbers(this.cell_list,cellno);

}

class _CellNumbers extends State<CellNumbers>{
  var cell_list=[];
  var cell_prios=[];
  var cellno;

  _CellNumbers(this.cell_list,this.cellno);

  Future SQL(query) async {
    final connection = await MySqlConnection.connect(new ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'Root123',
        db: "priosn_management"
    ));
    // var query = 'select * from prisoner';
    await connection.query(query);
    var cellquery = await connection.query(query);
    for( var i in cellquery){
      cell_prios.add(i);
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ViewData(cell_prios)));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("CELL"),

      ),
      body:
          Center(
            child: Column(
              children: [

                Container(
                  height: 500,
                  child:ListView.separated(

                  itemBuilder: (context,index){
                    return ListTile(
                    leading: CircleAvatar(

                    radius: 30,
                    backgroundColor: Colors.black87,
                    ),
                    title: Card(
                    elevation: 1,
                    child: Text("${this.cell_list[index]["CellID"]}")),
                    subtitle: Text("Capacity ${cell_list[index]["Capacity"]} Total Inmates ${cell_list[index]["Occupancy"]} ",style: TextStyle(fontFamily: "Asper_crown" ),),
                    onTap: () {
                        SQL("select * from prisoner where cellid= '${cell_list[index]['CellID']}'");
                        cell_prios=[];

                    }
                    );
                    },

                        separatorBuilder: (context,index) {
                          return Divider(height: 10,thickness: 5);
                        },

                        itemCount: cell_list.length)


                ),
                FloatingActionButton(onPressed: (){
                  var obj= SqlCommand();

                  var obj12=_PrisonListState(cell_list).cellno;

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>prison_edition(['cell','$cellno'])));
                },
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),

    );

  }


}





class ViewData extends StatefulWidget{
  @override
  var cell_prios=[];
  ViewData(this.cell_prios);

  _ViewData createState()=> _ViewData(this.cell_prios);

}




class _ViewData extends State<ViewData>{
  @override
  var cell_prios=[];
  List<List<String>> columnsName=[[]];
  _ViewData(this.cell_prios);
  List<List<String>> conversion=[[]];
  var employeer_list;
  var listColor=[Colors.lightGreenAccent,Colors.pink,Colors.red,Colors.green,Colors.yellow,Colors.red,Colors.lightGreenAccent,Colors.pink,Colors.red,Colors.green,Colors.yellow,Colors.red,Colors.lightGreenAccent,Colors.pink,Colors.red,Colors.green,Colors.yellow,Colors.red];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CELL"),
        ),
        body: Container(

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextButton(
                    onPressed: ()async{
                      print(cell_prios);
                      if (cell_prios.length!=0){



                      var obj = SqlCommand();
                      // print(cell_prios[0]);
                      var q1= "select prisonID from cell where cellID= '${cell_prios[0]['cellID']}'";
                      // print((obj.query_dataset));
                      await obj.SQL(q1);
                      var q2=(obj.query_dataset)[0]["prisonID"];
                      await obj.SQL("select * from employees where prisonID = '$q2'");
                      // print(obj.query_dataset);

                      // await obj.SQL("select * from staff where prisonID= 'select prisonID from cell = '${cell_prios[0]["cellID"]}'' ");
                      // print(obj.query_dataset);
                      var employees_list=[];
                      for (var i in obj.query_dataset){
                        if(i['empid']!=null){
                        employees_list.add([i['empid'],i['staff_type']]);
                      }}
                      setState(() {
                        employeer_list=employeer_list;
                      });

                      if (employees_list.length==0){
                        setState(() {
                          employees_list=[[]];
                        });
                      }
                Navigator.push(context, MaterialPageRoute(builder: (context)=> staff_view(employees_list)));


                    }
                      if (cell_prios.length==0){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => staff_view([])));
                      }
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color : Colors.white24,
                            borderRadius: BorderRadius.circular(100)

                        ),
width: 1500,
                        height: 100,
                          child: Center(child:
                          Text("CLICK HERE TO SEE STAFF DETAILS",
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,
                            color: Colors.black

                            ),)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: 400,
                    child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                        mainAxisSpacing: 15,
                        crossAxisCount: 8
                    )
                        ,
                        itemCount: cell_prios.length,


                        itemBuilder: (context,index){
                          return TextButton(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                  borderRadius: BorderRadius.all(Radius.circular(160)
                                  )

                          ),
                              child: Center(child:
                              Text("${cell_prios[index]["PrisonerID"]} ${cell_prios[index]["FirstName"]} ${cell_prios[index]["LastName"]}",

                                style:TextStyle(color: Colors.black) ,)
                              )
                              ,),
                          onPressed: () async{
                              var obj= SqlCommand();

                              await obj.SQL('show columns from prisoner');
                              for (var i in obj.query_dataset.toList()){
                                columnsName[0].add(i[0]);
                              }

                              conversion=columnsName;
                              if (cell_prios.length!=null ||cell_prios.length!=0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewDetails(
                                            cell_prios[index], conversion)));
                              }
                              columnsName=[[]];



                              },
                          );

                        }),
                  ),
                ),
                Row(
                children:[
                  Container(width: 1200,),
                    FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NewEdition_Prisoner()));

                  },

                  child: Icon(Icons.add),
                )])
              ],
            ),
          ),
        )



    );

  }
}

class ViewDetails extends StatefulWidget{
  @override
  var cell_prios=[];
  List<List<String>> columns_name=[[]];
  ViewDetails(this.cell_prios,this.columns_name);
  _ViewDetails createState()=> _ViewDetails(this.cell_prios,this.columns_name);
}

class _ViewDetails extends State<ViewDetails> {
  @override
  var cell_prios;  List<List<String>> columns_name = [[]];

  _ViewDetails(this.cell_prios, this.columns_name);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CELL"),
      ),
      body: Container(

        child: SingleChildScrollView(

          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  child: RoundedButton(onTap: () async{
                    var obj=SqlCommand();
                    try{
                        await obj.SQL(
                            "select * from visitation where prisonerID='${cell_prios['PrisonerID']}'");
                        print(obj.query_dataset);
                      }catch(e){
                      print(e);
                    }

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> visitation(obj.query_dataset,cell_prios['PrisonerID'])));


                  }
                    ,width: 300,
                  title: "VISITIONS FOR PRISONER",
                    size: 15,
                  ),
                ),
              ),

              Container(
                  height: 300,
                  width: 700,

                  child:Center(
                    child: Table(
                      textDirection: TextDirection.ltr,
                        border: TableBorder.all(

                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 3),
                        children: [
                      for(int i=0 ; i<columns_name[0].length;i++)
                    TableRow( children: [

                    Column(children:[Text('${columns_name[0][i]}', style: TextStyle(fontSize: 20.0))]),
                if (cell_prios.length!=null || cell_prios.length!=0)
                Column(children:[Text('${cell_prios[i]}', style: TextStyle(fontSize: 20.0))]),
                ]),
      ]),
                  )
              ),
            Center(
              child: Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: ()async{
                          try{
                            var obj=SqlCommand();
                            await obj.SQL('''
                            delete from visitation where prisonerid='${cell_prios['PrisonerID']}'
                            ''');
                            await obj.SQL('''
                            delete from prisoner where prisonerid='${cell_prios['PrisonerID']}'
                            ''');
                            await obj.SQL('''
                                UPDATE cell
                                set occupancy=(select COUNT(PRISONERID) from prisoner where cellid='${cell_prios['CellID']}')
                                where cellid='${cell_prios['CellID']}';
                            ''');
                            UtilsSuccess().showToast(context, 'Deletion Completed');
                          }
                              catch(e){}
                        }, child: Text("Delete")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(onPressed: (){
                          print(cell_prios['cellID']);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit_View_Prisoner(cell_prios)));

                        }, child: Text("Edit")
                             ),
                      )
                        ]
                ),
              ),
            )
            ],
          ),
        ),


      ),
    );
  }


}