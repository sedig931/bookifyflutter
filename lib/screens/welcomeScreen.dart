import 'package:flutter/material.dart';
import '../constants/constants.dart';
class WelcomeScreen extends StatefulWidget {

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>   {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 500.0,
                    child: Image.asset('images/welcomeimg.jpg',)
                ),
              ),
              Material(
                color:primeLightBackColor,
                borderRadius: BorderRadius.circular(15.0),
                elevation: 0.0,
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 20.0,fontFamily:'Ubuntu'))
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
