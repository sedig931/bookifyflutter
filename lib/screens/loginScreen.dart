import 'package:bookify_app/modal/sharedData.dart';
import 'package:flutter/material.dart';
import '../components/txtInput.dart';
import '../constants/constants.dart';
import '../modal/dataBaseAuth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = AuthController();

  var txtInputUsrNameBorderColor = Color(0xffcbcbcb);
  var txtInputPasswrodBorderColor = Color(0xffcbcbcb);
  var passwordSecured = true;
  var email = "";
  var password = "";

  bool progressAsyncing = false;

  void toggledUserNameInputBorderColor(focused){
    setState(() {
      focused ? txtInputUsrNameBorderColor = primeLightBackColor :
      txtInputUsrNameBorderColor = Color(0xffcbcbcb);
    });
  }
  void toggledPasswordInputBorderColor(focused){
    setState(() {
      focused ? txtInputPasswrodBorderColor = primeLightBackColor :
        txtInputPasswrodBorderColor = Color(0xffcbcbcb);
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

  void getUserDate () {
    print(email + " : " +password);
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              Hero(
                tag: 'logo',
                child: Container(
                  height: 250.0,
                    child: Image.asset('images/welcomeimg.jpg',)
                ),
              ),
              SizedBox(height: 50.0,),
              MyCustomTextField(
                lbltxt: 'Email',
                  txtInput: (value)=>{ email = value},
                  toggleInputBorderColor:toggledUserNameInputBorderColor,
                  toggleTxtSecure:togglePasswordSecure,
                  txtInputBorderColor:txtInputUsrNameBorderColor,
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
                      onPressed: () async {
                        runSpinner();
                        try {
                          Map<String, dynamic> user = {
                            'name':'',
                            'email':'',
                            'role':'',
                          };
                          user = (await authController.login(email: email, password: password)) as Map<String, dynamic>;
                          Provider.of<sharedData>(context,listen: false).setActiveUser(user);
                          if(user['role'] == 'user'){
                            // print('*******_____SUCCESS LOGIN_____*******');
                            print(user);
                            Navigator.pushNamed(context, '/userHome');
                          }else {
                            if(user['role']=='admin'){
                            // print('*******_____SUCCESS LOGIN_____*******');
                            Navigator.pushNamed(context, '/adminHome');
                            }
                          }
                          runSpinner();
                        }catch(e){
                          runSpinner();
                          print('oops ! sedig you made error..!');
                          print(e);
                        }
                      },
                      child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 20.0,fontFamily: 'Ubuntu'))
                  ),
                ),
              ),
              SizedBox(height: 25.0,),
              Material(
                elevation: 0.0,
                child: Container(
                  color: Colors.white,
                  // width: double.infinity,
                  // height: 50.0,
                  child: MaterialButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: (){
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Dont have account ?',style: TextStyle(color: primeLightBackColor,fontSize: 15.0,fontFamily: 'Ubuntu'))
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
