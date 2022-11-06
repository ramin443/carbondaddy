import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogreen/constants/color_constants.dart';

import '../constants/font_constants.dart';
import '../screens/login.dart';
import '../screens/signup.dart';

class AuthController extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController loginemailcontroller = TextEditingController();
  TextEditingController loginpasswordcontroller = TextEditingController();
  bool showpassword = false;
  bool eye = false;
  String loginerrormsg = "";
  String autherror = "";
  String signuperrormsg = "";
  bool showerror = false;
  int genderindex = 0;
  List<String> genders = ["Male", "Female", "Others"];

  List<String> maleavatars = [
    "assets/images/avatars/daddy1.jpg",
    "assets/images/avatars/daddy2.jpg",
    "assets/images/avatars/daddy3.jpg",
    "assets/images/avatars/daddy4.jpg"
  ];
  List<String> femaleavatars = [
    "assets/images/avatars/mommy1.jpg",
    "assets/images/avatars/mommy2.jpg",
    "assets/images/avatars/mommy3.jpg",
    "assets/images/avatars/mommy4.jpg",
    "assets/images/avatars/mommy5.jpg",
    "assets/images/avatars/mommy6.jpg"
  ];
  void setgenderindex(int selectindex) {
    genderindex = selectindex;
    update();
  }

  void addusercollection(
      {String? fullname, String? email, int? genderindex}) async {
    String usertype = genderindex == 0
        ? "CarbonDad"
        : genderindex == 1
            ? "CarbonMom"
            : "CarbonDad";
    if(genderindex==0){

    }
    await FirebaseFirestore.instance.collection("Users").doc(email).set({
      "fullname": fullname,
      "email": email,
      "gender": genders[genderindex!],
      "type": usertype,
      "hassurveyed": false,
      "avatar":genderindex==0?maleavatars[0]:femaleavatars[0]
    });
  }

  loginwithemail(BuildContext context, String email, String password) async {
    if (EmailValidator.validate(email) &&
        loginpasswordcontroller.text.length > 7) {
      loginerrormsg = "";
      autherror = "";
      update();
      final newUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.pushNamedAndRemoveUntil(context, "/Base", (route) => false);
      }).catchError((err) {
        FirebaseAuthException error = err;
        autherror = error.message.toString();
        update();
        // err.printInfo();
        //  print(err.printInfo());
      });
    } else if (EmailValidator.validate(email) != true) {
      loginerrormsg = "Please enter a valid email address";
      update();
    } else if (loginpasswordcontroller.text.length < 7) {
      loginerrormsg = "Password must be at least 8 characters";
      update();
    }
  }

  signupwithemail(BuildContext context, String name, int gender, String email,
      String password) async {
    if (EmailValidator.validate(email) && passwordcontroller.text.length > 7) {
      signuperrormsg = "";
      autherror = "";
      update();
      final newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (genderindex == 0) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/MaleAvatar", (route) => false);
        } else if (genderindex == 1) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/FemaleAvatar", (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/MaleAvatar", (route) => false);
        }
      }).catchError((err) {
        FirebaseAuthException error = err;
        autherror = error.message.toString();
        update();
        // err.printInfo();
        //  print(err.printInfo());
      });
      addusercollection(fullname: name, genderindex: gender, email: email);
    } else if (EmailValidator.validate(email) != true) {
      signuperrormsg = "Please enter a valid email address";
      update();
    } else if (loginpasswordcontroller.text.length < 7) {
      signuperrormsg = "Password must be at least 8 characters";
      update();
    }
  }

  Widget signupfields(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  margin: EdgeInsets.only(top: screenwidth * 0.072),
                  child: Text(
                    "Create an account.",
                    style: TextStyle(
                        fontFamily: intersemibold,
                        color: Color(0xff373737),
                        fontSize: screenwidth * 0.0746),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenwidth * 0.021,
                      bottom: screenwidth * 0.024,
                      top: screenwidth * 0.0853),
                  child: Text(
                    "Full Name",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Color(0xff656565),
                        fontSize: screenwidth * 0.032),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    //         horizontal: 24
                    left: screenwidth * 0.04,
                    //     right: screenwidth*0.04
                  ),
                  //      height: 46,
                  height: screenwidth * 0.096,
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
                      controller: fullnamecontroller,
                      cursorColor: Colors.black87,
                      style: TextStyle(
                          fontFamily: interregular,
                          color: Colors.black87,
                          //       fontSize: 13.5
                          fontSize: screenwidth * 0.0328),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          FeatherIcons.user,
                          color: Color(0xff404d4d),
                          //                 size: 18,
                          size: screenwidth * 0.0437,
                        ),
                        border: InputBorder.none,
                        hintText: 'Robert Fox',
                        hintStyle: TextStyle(
                            fontFamily: interregular, color: Color(0xffB5B5B5)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenwidth * 0.021,
                      bottom: screenwidth * 0.034,
                      top: screenwidth * 0.0653),
                  child: Text(
                    "Gender",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Color(0xff656565),
                        fontSize: screenwidth * 0.032),
                  ),
                ),
                Container(
                  width: screenwidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setgenderindex(0);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: screenwidth * 0.032,
                                    width: screenwidth * 0.032,
                                    margin: EdgeInsets.only(
                                        left: screenwidth * 0.02),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: genderindex == 0
                                            ? exohealgreen
                                            : Color(0xff989898),
                                        width: 1,
                                      ),
                                      color: genderindex == 0
                                          ? exohealgreen
                                          : Colors.transparent,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: screenwidth * 0.0253),
                                    child: Text(
                                      "Male",
                                      style: TextStyle(
                                        fontFamily: interregular,
                                        color: genderindex == 0
                                            ? exohealgreen
                                            : Color(0xffB5B5B5),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setgenderindex(1);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: screenwidth * 0.032,
                                    width: screenwidth * 0.032,
                                    margin: EdgeInsets.only(
                                        left: screenwidth * 0.0826),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: genderindex == 1
                                              ? exohealgreen
                                              : Color(0xff989898),
                                          width: 1,
                                        ),
                                        color: genderindex == 1
                                            ? exohealgreen
                                            : Colors.transparent),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: screenwidth * 0.0253),
                                    child: Text(
                                      "Female",
                                      style: TextStyle(
                                        fontFamily: interregular,
                                        color: genderindex == 1
                                            ? exohealgreen
                                            : Color(0xffB5B5B5),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setgenderindex(2);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: screenwidth * 0.032,
                                    width: screenwidth * 0.032,
                                    margin: EdgeInsets.only(
                                        left: screenwidth * 0.0826),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: genderindex == 2
                                              ? exohealgreen
                                              : Color(0xff989898),
                                          width: 1,
                                        ),
                                        color: genderindex == 2
                                            ? exohealgreen
                                            : Colors.transparent),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: screenwidth * 0.0253),
                                    child: Text(
                                      "Others",
                                      style: TextStyle(
                                        fontFamily: interregular,
                                        color: genderindex == 2
                                            ? exohealgreen
                                            : Color(0xffB5B5B5),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenwidth * 0.021,
                      bottom: screenwidth * 0.024,
                      top: screenwidth * 0.0653),
                  child: Text(
                    "Email Address",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Color(0xff656565),
                        fontSize: screenwidth * 0.032),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    //         horizontal: 24
                    left: screenwidth * 0.04,
                    //     right: screenwidth*0.04
                  ),
                  //      height: 46,
                  height: screenwidth * 0.096,
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
                          fontSize: screenwidth * 0.0328),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          FeatherIcons.user,
                          color: Color(0xff404d4d),
                          //                 size: 18,
                          size: screenwidth * 0.0437,
                        ),
                        border: InputBorder.none,
                        hintText: 'robfox@gmail.com',
                        hintStyle: TextStyle(
                            fontFamily: interregular, color: Color(0xffB5B5B5)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenwidth * 0.021,
                      bottom: screenwidth * 0.024,
                      top: screenwidth * 0.048),
                  child: Text(
                    "Create a password",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Color(0xff656565),
                        fontSize: screenwidth * 0.032),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    //         horizontal: 24
                    left: screenwidth * 0.04,
//                  right: screenwidth*0.008
                  ),
                  //      height: 46,
                  height: screenwidth * 0.096,
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
                      onChanged: (v) {
                        if (passwordcontroller.text != "") {
                          eye = true;
                          update();
                        }
                        if (passwordcontroller.text == "") {
                          eye = false;
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
                          fontSize: screenwidth * 0.0328),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              showpassword = !showpassword;
                              update();
                            },
                            child: Icon(
                              passwordcontroller.text == ""
                                  ? FeatherIcons.lock
                                  : showpassword
                                      ? FeatherIcons.eyeOff
                                      : FeatherIcons.eye,
                              color: Color(0xff404d4d),
                              //             size: 18,
                              size: screenwidth * 0.0437,
                            )),
                        border: InputBorder.none,
                        hintText: 'at least 8 characters',
                        hintStyle: TextStyle(
                            fontFamily: interregular, color: Color(0xffB5B5B5)),
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
            margin: EdgeInsets.only(
                top: screenwidth * 0.032, right: screenwidth * 0.0246),
            child: Text(
              signuperrormsg,
              style: TextStyle(
                  fontFamily: intermedium,
                  color: Colors.redAccent,
                  fontSize: screenwidth * 0.0293),
              maxLines: 2,
            ),
          ),
          autherror == ""
              ? SizedBox(
                  height: 0,
                )
              : Container(
                  margin: EdgeInsets.only(
                      top: screenwidth * 0.032, right: screenwidth * 0.0246),
                  child: Text(
                    autherror,
                    style: TextStyle(
                      fontFamily: intermedium,
                      color: Colors.redAccent,
                      fontSize: screenwidth * 0.0293,
                    ),
                    maxLines: 2,
                  ),
                ),
          GestureDetector(
            onTap: () {
              signupwithemail(context, fullnamecontroller.text, genderindex,
                  emailcontroller.text, passwordcontroller.text);
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.106),
              padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0293),
//                  width: screenwidth*0.738,
              width: screenwidth,
              height: screenwidth * 0.101,
              decoration: BoxDecoration(
                  color: Color(0xff4CA852),
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("here");
                    },
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.transparent,
                      size: screenwidth * 0.053,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.white,
                          fontSize: screenwidth * 0.0373),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      signupwithemail(
                          context,
                          fullnamecontroller.text,
                          genderindex,
                          emailcontroller.text,
                          passwordcontroller.text);
                    },
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: Color(0xffECECEC),
                      size: screenwidth * 0.053,
                    ),
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: screenwidth * 0.1733,
                        top: screenwidth * 0.0933),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontFamily: intermedium,
                              color: Color(0xff656565),
                              fontSize: screenwidth * 0.032),
                          children: [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                  fontFamily: intermedium,
                                  color: Color(0xff4CA852),
                                  fontSize: screenwidth * 0.032),
                            )
                          ]),
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

  Widget loginfields(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  margin: EdgeInsets.only(top: screenwidth * 0.072),
                  child: Text(
                    "Let’s sign you in.",
                    style: TextStyle(
                        fontFamily: intersemibold,
                        color: Color(0xff373737),
                        fontSize: screenwidth * 0.0746),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenwidth * 0.021,
                      bottom: screenwidth * 0.024,
                      top: screenwidth * 0.0853),
                  child: Text(
                    "Email Address",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Color(0xff656565),
                        fontSize: screenwidth * 0.032),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    //         horizontal: 24
                    left: screenwidth * 0.04,
                    //     right: screenwidth*0.04
                  ),
                  //      height: 46,
                  height: screenwidth * 0.096,
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
                          fontSize: screenwidth * 0.0328),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          FeatherIcons.user,
                          color: Color(0xff404d4d),
                          //                 size: 18,
                          size: screenwidth * 0.0437,
                        ),
                        border: InputBorder.none,
                        hintText: 'robfox@gmail.com',
                        hintStyle: TextStyle(
                            fontFamily: interregular, color: Color(0xffB5B5B5)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenwidth * 0.021,
                      bottom: screenwidth * 0.024,
                      top: screenwidth * 0.048),
                  child: Text(
                    "Create a password",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Color(0xff656565),
                        fontSize: screenwidth * 0.032),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    //         horizontal: 24
                    left: screenwidth * 0.04,
//                  right: screenwidth*0.008
                  ),
                  //      height: 46,
                  height: screenwidth * 0.096,
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
                      onChanged: (v) {
                        if (passwordcontroller.text != "") {
                          eye = true;
                          update();
                        }
                        if (passwordcontroller.text == "") {
                          eye = false;
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
                          fontSize: screenwidth * 0.0328),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              showpassword = !showpassword;
                              update();
                            },
                            child: Icon(
                              loginpasswordcontroller.text == ""
                                  ? FeatherIcons.lock
                                  : showpassword
                                      ? FeatherIcons.eyeOff
                                      : FeatherIcons.eye,
                              color: Color(0xff404d4d),
                              //             size: 18,
                              size: screenwidth * 0.0437,
                            )),
                        border: InputBorder.none,
                        hintText: 'at least 8 characters',
                        hintStyle: TextStyle(
                            fontFamily: interregular, color: Color(0xffB5B5B5)),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: screenwidth * 0.032,
                          right: screenwidth * 0.0246),
                      child: Text(
                        loginerrormsg,
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.redAccent,
                            fontSize: screenwidth * 0.0293),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: screenwidth * 0.032,
                          right: screenwidth * 0.0246),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontFamily: intermedium,
                            color: Color(0xff989898),
                            fontSize: screenwidth * 0.0293),
                      ),
                    )
                  ],
                ),
                autherror == ""
                    ? SizedBox(
                        height: 0,
                      )
                    : Container(
                        margin: EdgeInsets.only(
                            top: screenwidth * 0.032,
                            right: screenwidth * 0.0246),
                        child: Text(
                          autherror,
                          style: TextStyle(
                            fontFamily: intermedium,
                            color: Colors.redAccent,
                            fontSize: screenwidth * 0.0293,
                          ),
                          maxLines: 2,
                        ),
                      ),
              ])),
          GestureDetector(
            onTap: () {
              loginwithemail(context, loginemailcontroller.text,
                  loginpasswordcontroller.text);
            },
            child: Container(
              margin: EdgeInsets.only(top: screenwidth * 0.106),
              padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.0293),
              width: screenwidth,
              height: screenwidth * 0.101,
              decoration: BoxDecoration(
                  color: Color(0xff4CA852),
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.transparent,
                      size: screenwidth * 0.053,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.white,
                          fontSize: screenwidth * 0.0373),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.arrow_right,
                      color: Color(0xffECECEC),
                      size: screenwidth * 0.053,
                    ),
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: screenwidth * 0.1733,
                        top: screenwidth * 0.0933),
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontFamily: intermedium,
                              color: Color(0xff656565),
                              fontSize: screenwidth * 0.032),
                          children: [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                  fontFamily: intermedium,
                                  color: Color(0xff4CA852),
                                  fontSize: screenwidth * 0.032),
                            )
                          ]),
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
