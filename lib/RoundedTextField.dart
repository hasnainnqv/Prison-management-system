import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class RoundedTextField extends StatelessWidget{
  final bool loading;
  final String hint;
  final height;
  final width;
  final type;
  final icon;
  final labeltext;
  final initialvalue;
  final bool readonly;
  final bool obscure;
  final controller;
  const RoundedTextField({
    Key? key,
    this.controller,
    this.loading=false,
    this.hint='',
    this.initialvalue,
    this.height=25,
    this.width=250,
    this.icon,
    this.labeltext,
    this.readonly=false,

    this.obscure=false,
    this.type,




  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // child: Container(
      //
      //   height: 50,
      //   width: 300,
      //
      //   color: Colors.brown,
      //     child: TextField(
      //
      //       textAlign: TextAlign.center,
      //       keyboardType: TextInputType.text,
      //
      //
      //
      //
      //       // decoration: InputDecoration(
      //       //
      //       //   enabled: true,
      //       //   hintText: this.hint,
      //       //   hintStyle: TextStyle(fontSize: 16),
      //       //   border: OutlineInputBorder(
      //       //
      //       //     borderRadius: BorderRadius.circular(15.0),
      //       //     borderSide: BorderSide(
      //       //
      //       //       width: 10,
      //       //       color: Colors.black,
      //       //       style: BorderStyle.solid,
      //       //     ),
      //       //   ),
      //       //   filled: true,
      //       //   contentPadding: EdgeInsets.all(16),
      //       //   fillColor: Colors.white,
      //       // ),
      //     ),
      //   ),
     child:  Container(

        child: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: TextFormField(
            initialValue: initialvalue,
            keyboardType: type,
            obscureText: this.obscure,
            controller: controller,
            readOnly: readonly,


            autofocus: false,
            style: TextStyle(fontSize: 15.0, color: Colors.black),
            decoration: InputDecoration(
              labelText: labeltext,
              suffixIcon: Icon(icon),
              filled: true,
              fillColor: Colors.white,
              hintText: this.hint,

              contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 12.0, top: 0.0),


              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),

              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
          ),
        ),

        decoration: new BoxDecoration (
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            color: Colors.white   ),   width: 250,   height: 50,
       margin: new EdgeInsets.all(8),   padding: new EdgeInsets.all(8),

      ),
    );

}
}










class RoundedButton extends StatelessWidget{
  final title;
  final VoidCallback onTap;
  final bool loading;
  final double size;
  final double radius;
  final double width;
  const RoundedButton({
    Key? key,
    required this.onTap,
    this.loading=false,
    this.title,
    this.size=10.0,

    this.width=150.0,
    this.radius=18.0



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 25,
          width: this.width,
          decoration: BoxDecoration(
              color : Colors.blueAccent,
              borderRadius: BorderRadius.circular(radius)

          ),
          child: Center(child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,)
              :Text(title,style:
          TextStyle(
              color: Colors.black,
              fontSize: size,
              fontWeight: FontWeight.bold)


          ),)),
        ),


    );
  }

}


/// Flutter code sample for [AlertDialog].




class Utils {
  // void toastmessage(String message){
  //   Fluttertoast.showToast(msg: message,
  //       backgroundColor: Colors.red,
  //       gravity: ToastGravity.BOTTOM,
  //       toastLength: Toast.LENGTH_LONG,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  //
  // }

  void showToast(BuildContext context, msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        elevation: 20,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        duration: Duration(seconds: 2),
        width: 500,

        content: Center(child: Text('$msg',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),)),

      ),
    );
  }


}

class UtilsSuccess {
  // void toastmessage(String message){
  //   Fluttertoast.showToast(msg: message,
  //       backgroundColor: Colors.red,
  //       gravity: ToastGravity.BOTTOM,
  //       toastLength: Toast.LENGTH_LONG,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  //
  // }

  void showToast(BuildContext context, msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        elevation: 20,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        duration: Duration(seconds: 2),
        width: 500,

        content: Center(child: Text('$msg',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),)),

      ),
    );
  }


}