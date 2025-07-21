import 'package:flutter/material.dart';

import '../constants/constants.dart';
class MyCustomTextField extends StatelessWidget {
  const MyCustomTextField({
    required this.lbltxt,
    required this.txtInput,
    required this.toggleInputBorderColor,
    required this.txtInputBorderColor,
    required this.toggleTxtSecure,
    required this.txtSecure, required this.textPassword,
    super.key});
  final String lbltxt;
  final Function txtInput;
  final Function toggleInputBorderColor;
  final Function toggleTxtSecure;
  final Color txtInputBorderColor;
  final bool txtSecure;
  final bool textPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding:  EdgeInsets.only(left: 13.5,top: 1,bottom: 1,right: 0.0),
      decoration: BoxDecoration(
          // color: Color(0xFF1c1c1e),
          border: Border.all(
              width: 2,
              color: txtInputBorderColor
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          shape: BoxShape.rectangle
      ),
      child: Row(
        children: [
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) => {toggleInputBorderColor(hasFocus)},
              child: TextField(
                onChanged: (value) => {txtInput(value)},
                onTap: () => {toggleInputBorderColor(true)},
                obscureText: txtSecure,
                style: TextStyle(fontSize: 17,color: primeLightBackColor,fontFamily: 'Ubuntu'),
                cursorColor: primeLightBackColor,
                cursorHeight: 15,
                decoration: InputDecoration(
                  label: Text(lbltxt,style:TextStyle(color: Colors.grey,fontSize: 18,fontFamily: 'Ubuntu')),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Transform( //<--- This changed
              transform: Matrix4.rotationY(380),
              child: textPassword ? GestureDetector(
                  onTap: ()=>{toggleTxtSecure()},
                  child: txtSecure ? Icon(Icons.visibility,size: 23.0,color: primeLightBackColor,) :
                  Icon(Icons.visibility_off,size: 23.0,color: primeLightBackColor,)
              ) : null
          ),
        ],
      ),
    );
  }
}