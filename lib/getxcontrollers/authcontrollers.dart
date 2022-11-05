import 'package:email_validator/email_validator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/font_constants.dart';
import '../screens/login.dart';
import '../screens/signup.dart';

class AuthController extends GetxController{
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController loginemailcontroller=TextEditingController();
  TextEditingController loginpasswordcontroller=TextEditingController();
  bool showpassword=false;
  bool eye=false;
  String loginerrormsg="";
  String autherror="";
  String signuperrormsg="";
  bool showerror=false;
  loginwithemail(BuildContext context,String email, String password)async{
    if(EmailValidator.validate(email) && loginpasswordcontroller.text.length>7){
      loginerrormsg="";
      autherror="";
      update();
      final newUser=  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
          password: password).then((value) {
        Navigator.pushNamedAndRemoveUntil(context, "/Base", (route) => false);
      }).catchError((err){
        FirebaseAuthException error=err;
        autherror=error.message.toString();
        update();
        // err.printInfo();
        //  print(err.printInfo());
      });
    }else if(EmailValidator.validate(email) !=true){
      loginerrormsg="Please enter a valid email address";
      update();
    }else if(loginpasswordcontroller.text.length<7){
      loginerrormsg="Password must be at least 8 characters";
      update();
    }
  }
  signupwithemail(BuildContext context,String email, String password)async{
    if(EmailValidator.validate(email) && passwordcontroller.text.length>7){
      signuperrormsg="";
      autherror="";
      update();
      final newUser=  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,
          password: password).then((value) {
        Navigator.pushNamedAndRemoveUntil(context, "/Base", (route) => false);
      }).catchError((err){
        FirebaseAuthException error=err;
        autherror=error.message.toString();
        update();
        // err.printInfo();
        //  print(err.printInfo());
      });
    }else if(EmailValidator.validate(email) !=true){
      signuperrormsg="Please enter a valid email address";
      update();
    }else if(loginpasswordcontroller.text.length<7){
      signuperrormsg="Password must be at least 8 characters";
      update();
    }
  }
  Widget signupfields(BuildContext context){
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Container(
                        margin: EdgeInsets.only(top: screenwidth*0.072),
                        child: Text("Create an account.",style: TextStyle(
                            fontFamily: intersemibold,
                            color: Color(0xff373737),
                            fontSize: screenwidth*0.0746
                        ),),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenwidth*0.021,bottom: screenwidth*0.024,
                            top: screenwidth*0.0853),
                        child: Text("Email Address",style: TextStyle(
                            fontFamily: intermedium,
                            color: Color(0xff656565),
                            fontSize: screenwidth*0.032
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          //         horizontal: 24
                          left: screenwidth*0.04,
                          //     right: screenwidth*0.04

                        ),
                        //      height: 46,
                        height: screenwidth*0.096,
                        width: screenwidth,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffECECEC),
                            width: 1,
                          ),
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: TextFormField(

                            controller: emailcontroller,
                            cursorColor: Colors.black87,
                            style: TextStyle(
                                fontFamily: interregular,
                                color: Colors.black87,
                                //       fontSize: 13.5
                                fontSize: screenwidth*0.0328
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: Icon(FeatherIcons.user,
                                color: Color(0xff404d4d),
                                //                 size: 18,
                                size: screenwidth*0.0437,
                              ),
                              border: InputBorder.none,
                              hintText: 'robfox@gmail.com',
                              hintStyle: TextStyle(
                                  fontFamily: interregular,
                                  color: Color(0xffB5B5B5)
                              ),

                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenwidth*0.021,bottom: screenwidth*0.024,
                            top: screenwidth*0.048),
                        child: Text("Create a password",style: TextStyle(
                            fontFamily: intermedium,
                            color: Color(0xff656565),
                            fontSize: screenwidth*0.032
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          //         horizontal: 24
                          left:screenwidth*0.04,
//                  right: screenwidth*0.008

                        ),
                        //      height: 46,
                        height: screenwidth*0.096,
                        width: screenwidth,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffECECEC),
                            width: 1,
                          ),
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: TextFormField(
                            onChanged: (v){
                              if(passwordcontroller.text!=""){
                                eye=true;
                                update();
                              }
                              if(passwordcontroller.text==""){
                                eye=false;
                                update();
                              }
                            },
                            obscureText: !showpassword,
                            controller: passwordcontroller,
                            cursorColor: Colors.black87,
                            style: TextStyle(
                                fontFamily: interregular,
                                color: Colors.black87,
                                //       fontSize: 13.5
                                fontSize: screenwidth*0.0328
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    showpassword=!showpassword;
                                    update();

                                  },
                                  child:Icon(
                                    passwordcontroller.text==""?
                                    FeatherIcons.lock:
                                    showpassword?
                                    FeatherIcons.eyeOff:
                                    FeatherIcons.eye
                                    ,
                                    color: Color(0xff404d4d),
                                    //             size: 18,
                                    size: screenwidth*0.0437,
                                  )),
                              border: InputBorder.none,
                              hintText: 'at least 8 characters',
                              hintStyle: TextStyle(
                                  fontFamily: interregular,
                                  color: Color(0xffB5B5B5)
                              ),

                            ),
                          ),
                        ),
                      ),
                      /*       Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenwidth*0.032,right: screenwidth*0.0346),
                  child: Text("Forgot your Password?",style: TextStyle(
                    fontFamily: intermedium,
                    color: Color(0xff989898),
                    fontSize: screenwidth*0.0293
                  ),),
                )
              ],
            )*/
                    ])),

            Container(
              margin: EdgeInsets.only(top: screenwidth*0.032,right: screenwidth*0.0246),
              child: Text(signuperrormsg,style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.redAccent,
                  fontSize: screenwidth*0.0293
              ),maxLines: 2,),
            ),


            autherror==""?SizedBox(height: 0,):
            Container(
              margin: EdgeInsets.only(top: screenwidth*0.032,right: screenwidth*0.0246),
              child: Text(autherror,style: TextStyle(
                fontFamily: intermedium,
                color: Colors.redAccent,
                fontSize: screenwidth*0.0293,
              ),
                maxLines: 2,),
            ),
            GestureDetector(
              onTap: (){
                signupwithemail(context,emailcontroller.text, passwordcontroller.text);
              },
              child: Container(
                margin: EdgeInsets.only(top: screenwidth*0.106),
                padding: EdgeInsets.symmetric(horizontal: screenwidth *0.0293),
//                  width: screenwidth*0.738,
                width: screenwidth,
                height: screenwidth*0.101,
                decoration: BoxDecoration(
                    color: Color(0xff4CA852),
                    borderRadius: BorderRadius.all(Radius.circular(24))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print("here");
                      },
                      child: Icon(CupertinoIcons.arrow_right,
                        color: Colors.transparent,
                        size: screenwidth*0.053,),
                    ),
                    Container(
                      child: Text("Sign Up",style: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.white,
                          fontSize: screenwidth*0.0373
                      ),),
                    ),
                    GestureDetector(
                      onTap: (){
                        signupwithemail(context,emailcontroller.text, passwordcontroller.text);
                      },
                      child: Icon(CupertinoIcons.arrow_right,
                        color: Color(0xffECECEC),
                        size: screenwidth*0.053,),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: screenwidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [


                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          Login()
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: screenwidth*0.1733,
                          top: screenwidth*0.0933),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontFamily: intermedium,
                                color: Color(0xff656565),
                                fontSize: screenwidth*0.032
                            ),
                            children: [
                              TextSpan(
                                  text: "Already have an account? "
                              ),
                              TextSpan(
                                text: "Sign In",
                                style:  TextStyle(
                                    fontFamily: intermedium,
                                    color: Color(0xff4CA852),
                                    fontSize: screenwidth*0.032
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )



          ],
        ),
      );
  }
  Widget loginfields(BuildContext context){
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Container(
                        margin: EdgeInsets.only(top: screenwidth*0.072),
                        child: Text("Let’s sign you in.",style: TextStyle(
                            fontFamily: intersemibold,
                            color: Color(0xff373737),
                            fontSize: screenwidth*0.0746
                        ),),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenwidth*0.021,bottom: screenwidth*0.024,
                            top: screenwidth*0.0853),
                        child: Text("Email Address",style: TextStyle(
                            fontFamily: intermedium,
                            color: Color(0xff656565),
                            fontSize: screenwidth*0.032
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          //         horizontal: 24
                          left: screenwidth*0.04,
                          //     right: screenwidth*0.04

                        ),
                        //      height: 46,
                        height: screenwidth*0.096,
                        width: screenwidth,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffECECEC),
                            width: 1,
                          ),
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: TextFormField(

                            controller: loginemailcontroller,
                            cursorColor: Colors.black87,
                            style: TextStyle(
                                fontFamily: interregular,
                                color: Colors.black87,
                                //       fontSize: 13.5
                                fontSize: screenwidth*0.0328
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: Icon(FeatherIcons.user,
                                color: Color(0xff404d4d),
                                //                 size: 18,
                                size: screenwidth*0.0437,
                              ),
                              border: InputBorder.none,
                              hintText: 'robfox@gmail.com',
                              hintStyle: TextStyle(
                                  fontFamily: interregular,
                                  color: Color(0xffB5B5B5)
                              ),

                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenwidth*0.021,bottom: screenwidth*0.024,
                            top: screenwidth*0.048),
                        child: Text("Create a password",style: TextStyle(
                            fontFamily: intermedium,
                            color: Color(0xff656565),
                            fontSize: screenwidth*0.032
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          //         horizontal: 24
                          left:screenwidth*0.04,
//                  right: screenwidth*0.008

                        ),
                        //      height: 46,
                        height: screenwidth*0.096,
                        width: screenwidth,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffECECEC),
                            width: 1,
                          ),
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: TextFormField(
                            onChanged: (v){
                              if(passwordcontroller.text!=""){
                                eye=true;
                                update();
                              }
                              if(passwordcontroller.text==""){
                                eye=false;
                                update();
                              }
                            },
                            obscureText: !showpassword,
                            controller: loginpasswordcontroller,
                            cursorColor: Colors.black87,
                            style: TextStyle(
                                fontFamily: interregular,
                                color: Colors.black87,
                                //       fontSize: 13.5
                                fontSize: screenwidth*0.0328
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    showpassword=!showpassword;
                                    update();

                                  },
                                  child:Icon(
                                    loginpasswordcontroller.text==""?
                                    FeatherIcons.lock:
                                    showpassword?
                                    FeatherIcons.eyeOff:
                                    FeatherIcons.eye
                                    ,
                                    color: Color(0xff404d4d),
                                    //             size: 18,
                                    size: screenwidth*0.0437,
                                  )),
                              border: InputBorder.none,
                              hintText: 'at least 8 characters',
                              hintStyle: TextStyle(
                                  fontFamily: interregular,
                                  color: Color(0xffB5B5B5)
                              ),

                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: screenwidth*0.032,right: screenwidth*0.0246),
                            child: Text(loginerrormsg,style: TextStyle(
                                fontFamily: intermedium,
                                color: Colors.redAccent,
                                fontSize: screenwidth*0.0293
                            ),),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: screenwidth*0.032,right: screenwidth*0.0246),
                            child: Text("Forgot Password?",style: TextStyle(
                                fontFamily: intermedium,
                                color: Color(0xff989898),
                                fontSize: screenwidth*0.0293
                            ),),
                          )
                        ],
                      ),
                      autherror==""?SizedBox(height: 0,):

                      Container(
                        margin: EdgeInsets.only(top: screenwidth*0.032,right: screenwidth*0.0246),
                        child: Text(autherror,style: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.redAccent,
                          fontSize: screenwidth*0.0293,
                        ),
                          maxLines: 2,),
                      ),

                    ])),

            GestureDetector(
              onTap: (){
                loginwithemail(context,loginemailcontroller.text, loginpasswordcontroller.text);
              },
              child: Container(
                margin: EdgeInsets.only(top: screenwidth*0.106),
                padding: EdgeInsets.symmetric(horizontal: screenwidth *0.0293),
                width: screenwidth,
                height: screenwidth*0.101,
                decoration: BoxDecoration(
                    color: Color(0xff4CA852),
                    borderRadius: BorderRadius.all(Radius.circular(24))
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(CupertinoIcons.arrow_right,
                        color: Colors.transparent,
                        size: screenwidth*0.053,),
                    ),
                    Container(
                      child: Text("Sign In",style: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.white,
                          fontSize: screenwidth*0.0373
                      ),),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Icon(CupertinoIcons.arrow_right,
                        color: Color(0xffECECEC),
                        size: screenwidth*0.053,),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: screenwidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          SignUp()
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: screenwidth*0.1733,
                          top: screenwidth*0.0933),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontFamily: intermedium,
                                color: Color(0xff656565),
                                fontSize: screenwidth*0.032
                            ),
                            children: [
                              TextSpan(
                                  text: "Don't have an account? "
                              ),
                              TextSpan(
                                text: "Sign Up",
                                style:  TextStyle(
                                    fontFamily: intermedium,
                                    color: Color(0xff4CA852),
                                    fontSize: screenwidth*0.032
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )



          ],
        ),
      );
  }
}