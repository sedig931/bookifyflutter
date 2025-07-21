import 'package:bookify_app/modal/dataBaseAuth.dart';
import 'package:flutter/material.dart';
import '../components/txtInput.dart';
import '../constants/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController authController = AuthController();

  var txtInputPasswrodBorderColor = Color(0xffcbcbcb);
  var txtInputEmailBorderColor = Color(0xffcbcbcb);
  var txtInputNameBorderColor = Color(0xffcbcbcb);
  var passwordSecured = true;

  var email = "";
  var password = "";
  var name = "";

  bool progressAsyncing = false;

  void toggledPasswordInputBorderColor(focused){
    setState(() {
      focused ? txtInputPasswrodBorderColor = primeLightBackColor :
      txtInputPasswrodBorderColor = Color(0xffcbcbcb);
    });
  }
  void toggledNameInputBorderColor(focused){
    setState(() {
      focused ? txtInputNameBorderColor = primeLightBackColor :
      txtInputNameBorderColor = Color(0xffcbcbcb);
    });
  }
  void toggledEmailInputBorderColor(focused){
    setState(() {
      focused ? txtInputEmailBorderColor = primeLightBackColor :
      txtInputEmailBorderColor = Color(0xffcbcbcb);
    });
  }
  void togglePasswordSecure(){
    setState(() {
      passwordSecured = !passwordSecured;
    });
  }

  void runSpinner () {
    setState(() {
      progressAsyncing = !progressAsyncing;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: progressAsyncing,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 250.0,
                  child: Image.asset('images/welcomeimg.jpg',)
              ),
              SizedBox(height: 50.0,),
              MyCustomTextField(
                lbltxt: 'User Name',
                  txtInput: (value)=>{ name = value},
                  toggleInputBorderColor:toggledNameInputBorderColor,
                  toggleTxtSecure:togglePasswordSecure,
                  txtInputBorderColor:txtInputNameBorderColor,
                  txtSecure:false,
                  textPassword:false
              ),
              SizedBox(height: 15.0,),
              MyCustomTextField(
                lbltxt: 'Email',
                  txtInput: (value)=>{ email = value},
                  toggleInputBorderColor:toggledEmailInputBorderColor,
                  toggleTxtSecure:togglePasswordSecure,
                  txtInputBorderColor:txtInputEmailBorderColor,
                  txtSecure:false,
                  textPassword:false
              ),
              SizedBox(height: 15.0,),
              MyCustomTextField(
                lbltxt: 'Password',
                txtInput: (value)=>{password = value},
                toggleInputBorderColor:toggledPasswordInputBorderColor,
                toggleTxtSecure:togglePasswordSecure,
                txtInputBorderColor:txtInputPasswrodBorderColor,
                txtSecure:passwordSecured,
                textPassword:true,
              ),
              SizedBox(height: 25.0,),
              Material(
                color:primeLightBackColor,
                borderRadius: BorderRadius.circular(15.0),
                elevation: 0.0,
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: ()async{
                        try{
                          runSpinner();
                          String? result = await authController.register(
                            name: name,
                            email: email,
                            password: password
                          );
                          if(result == null ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("congratiolations ! successful registerd..."))
                            );
                            print('******--------------SUCCESS-REGISTER--------------*******');
                            Navigator.pushNamed(context, '/login');
                            runSpinner();
                          }else {
                            // print('oops ! sedig you made error..!');
                            runSpinner();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("sorry ! error : $result"))
                            );
                          }
                        }catch(e){
                          runSpinner();
                          // print('oops ! sedig you made error..!');
                          print(e);
                        }
                      },
                      child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 20.0,fontFamily: 'Ubuntu'))
                  ),
                ),
              ),
              SizedBox(height: 25.0,),
              Material(
                elevation: 0.0,
                child: Container(
                  // width: double.infinity,
                  // height: 50.0,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: (){
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Allrady have account ?',style: TextStyle(color: primeLightBackColor,fontSize: 15.0,fontFamily: 'Ubuntu'))
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

