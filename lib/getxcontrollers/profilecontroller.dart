import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';
import 'basecontroller.dart';
final BaseController baseController = Get.put(BaseController());

class ProfileController extends GetxController{
  bool changemade=false;
  String useremail="";
  TextEditingController namecontroller=TextEditingController();
  TextEditingController useremailcontroller=TextEditingController();
  setnameandemail()async{
    String email=FirebaseAuth.instance.currentUser!.email.toString();
    final name=FirebaseAuth.instance.currentUser!.displayName;
    if(name==null){
      useremail=FirebaseAuth.instance.currentUser!.email.toString();

    }else{
      namecontroller.text=FirebaseAuth.instance.currentUser!.displayName.toString();
      useremail=FirebaseAuth.instance.currentUser!.email.toString();

    }
    update();
  }

  updateuserdata(BuildContext context){

    FirebaseAuth.instance.currentUser!.updateDisplayName(namecontroller.text);
    changemade=false;
    FocusScope.of(context).unfocus();
    update();

  }

  Widget getrofilerow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      padding: EdgeInsets.symmetric(
          vertical: screenwidth * 0.0307),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white54,
//            size: 70,
              size: screenwidth * 0.159,
            ),
          ),
          Container(

            margin: EdgeInsets.only(
//                left: 16
                left: screenwidth * 0.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "ExoHeal Test User",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealbeige,
                        //        fontSize: 18
                        fontSize: screenwidth * 0.0461),
                  ),
                ),
                Container(
                  child: Text(
                    useremail,
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: exohealbeige,
                        //         fontSize: 14.5
                        fontSize: screenwidth * 0.0371),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget getprofilerow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      padding: EdgeInsets.symmetric(
          horizontal: screenwidth * 0.0461),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.grey,
//            size: 70,
              size: screenwidth * 0.159,
            ),
          ),
          Container(
            //   height: screenwidth * 0.179,
            margin: EdgeInsets.only(

//                left: 16
                left: screenwidth * 0.0410),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenwidth*0.6,
                  child:
                  TextFormField(
                    onChanged: (v){
                      changemade=true;
                      update();
                    },
                    controller: namecontroller,
                    cursorColor: Colors.black87,
                    style: TextStyle(
                        fontFamily: interregular,
                        color: Colors.black87,
                        //       fontSize: 13.5
                        fontSize: screenwidth * 0.0361
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(

                      border: InputBorder.none,
                      hintText: 'Your Name',
                      hintStyle: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.grey,
                          fontSize: screenwidth * 0.0361
                      ),

                    ),
                  ),
                  /*    Text(
                    "Ramin Udash",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Colors.black87,
                        //        fontSize: 18
                        fontSize: screenwidth * 0.0461),
                  ),*/
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text(
                    useremail,
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Colors.black87,
                        //         fontSize: 14.5
                        fontSize: screenwidth * 0.0371),
                  ),/*Text(
                    "udashramin1@gmail.com",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Colors.black87,
                        //         fontSize: 14.5
                        fontSize: screenwidth * 0.0371),
                  ),*/
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget borderline(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      height: 1,
      decoration: BoxDecoration(
        color: Color(0xffECEBEB),
      ),
    );
  }

  Widget profileoptionscolumn(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        //         vertical: 24
          vertical: 6),
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
              });
            },
            child: Container(
                width: screenwidth,
                margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                    top: screenwidth * 0.0361,
                    bottom: screenwidth * 0.03461,
                    left: screenwidth * 0.0461,
                    right: screenwidth * 0.0461),
                child:
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    margin: EdgeInsets.only(
//                        right: 12
                        right: screenwidth * 0.0307),
                    child: Icon(
                      FeatherIcons.logOut,
                      color: Colors.redAccent,
//                    size: 24,
                      size: screenwidth * 0.0615,
                    ),
                  ),
                  Text(
                    "Sign Out",
                    style: TextStyle(
                        fontFamily: intermedium,
                        color: Colors.redAccent,
                        //           fontSize: 14.5
                        fontSize: screenwidth * 0.032),
                  ),
                ])),
          ),
          borderline(context),
        ],
      ),
    );
  }
  putjson(){
    return {};
  }



  Widget drawer(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 18),
            width: screenwidth,
            height: screenwidth*0.4,
            decoration: BoxDecoration(
                color: exohealdarkgrey
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text('ExoHeal',
                    style: TextStyle(
                        fontFamily: proximanovaregular,
                        color: exohealbeige,
                        fontSize: 24

                    ),),
                ),
                getrofilerow(context),
              ],
            ),
          ),
          drawercolumn(context),

        ],
      ),
    );
  }
  Widget drawercolumn(BuildContext context){
    double screenwidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {

          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    CupertinoIcons.uiwindow_split_2x1,
                    color: exohealdarkgrey,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "History",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Color(0xff333333),
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
        borderline(context),
        InkWell(
          onTap: () {

          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    FeatherIcons.barChart2,
                    color: exohealdarkgrey,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "Progress",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Color(0xff333333),
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
        borderline(context),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            /* Navigator.push(context,MaterialPageRoute(builder: (context)=>
                FullLapExercise(exerciselist: staticexerciselist,)
            ));*/
          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    FeatherIcons.gitMerge,
                    color: exohealdarkgrey,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "Full Lapse Exercise",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Color(0xff333333),
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
        borderline(context),
        InkWell(
          onTap: () {
            baseController.setindex(2);
            Navigator.pop(context);
          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    FeatherIcons.settings,
                    color: exohealdarkgrey,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Color(0xff333333),
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
        borderline(context),
        InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
            });
          },
          child: Container(
              width: screenwidth,
              margin: EdgeInsets.only(
//                bottom: 18,left: 18,right: 18
                  top: screenwidth * 0.0361,
                  bottom: screenwidth * 0.0361,
                  left: screenwidth * 0.0461,
                  right: screenwidth * 0.0461),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(
//                        right: 12
                      right: screenwidth * 0.0307),
                  child: Icon(
                    FeatherIcons.logOut,
                    color: Colors.redAccent,
//                    size: 24,
                    size: screenwidth * 0.0415,
                  ),
                ),
                Text(
                  "Sign Out",
                  style: TextStyle(
                      fontFamily: intermedium,
                      color: Colors.redAccent,
                      //           fontSize: 14.5
                      fontSize: screenwidth * 0.032),
                ),
              ])),
        ),
      ],
    );
  }
}