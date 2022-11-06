import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gogreen/constants/font_constants.dart';

class SurveyController extends GetxController{
  int currentpageindex=0;
  void updatepageindex(int index){
    currentpageindex=index;
    update();
  }
  int optionselectedstatus=0;
  void setoptionselectstatus(int index){
    optionselectedstatus=index;
    update();
  }
  void resetoptionselection(){
    optionselectedstatus=0;
    update();
  }
  void incrementpageindex(){
    currentpageindex++;
    update();
  }
  int numofposresponses=0;
  void incrementposresponses() {
  numofposresponses++;
  update();
}
  void updateusertype()async{
    String usertype="Sugar Baby";
    String email=FirebaseAuth.instance.currentUser!.email.toString();
    if(numofposresponses>7){
      usertype="Sugar Daddy";
    }else{
      usertype="Sugar Baby";
    }
    await FirebaseFirestore.instance.collection("Users").doc(email).update({
      "type":usertype,
      "hassurveyed":true
    });
  }
  void uploaduserpreference()async{
    String email=FirebaseAuth.instance.currentUser!.email.toString();
    await FirebaseFirestore.instance.collection("UserResponses").doc(email).set(
        {
          "numberofpositiveresponses":numofposresponses
        });
  }
  List<String> friendlyimg=["assets/images/surveymemes/unknown.png",
    "assets/images/surveymemes/unknown-5.png",
    "assets/images/surveymemes/unknown-7.png",
  "assets/images/surveymemes/unknown-8.png",
  "assets/images/surveymemes/unknown-9.png",
  "assets/images/surveymemes/unknown-10.png",
  "assets/images/surveymemes/unknown-13.png",
  "assets/images/surveymemes/unknown-14.png",
  "assets/images/surveymemes/unknown-15.png",
  "assets/images/surveymemes/unknown-16.png"];
  List<String> unfriendlyimg=["assets/images/surveymemes/unknown-3.png",
    "assets/images/surveymemes/unknown-2.png",
    "assets/images/surveymemes/unknown-4.png",
  "assets/images/surveymemes/unknown-6.png",
  "assets/images/surveymemes/unknown-11.png","assets/images/surveymemes/unknown-12.png",
    "assets/images/surveymemes/unknown-17.png",
  "assets/images/surveymemes/unknown-18.png",
  "assets/images/surveymemes/unknown-19.png",
  "assets/images/surveymemes/image.png"];

  Widget pageslider(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return  Container(
      margin: EdgeInsets.only(bottom: screenwidth*0.093),
      width: screenwidth*0.552,
      height: screenwidth*0.016,
      decoration: BoxDecoration(
          color: Color(0xffEAEAEA),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            width: screenwidth*0.552/10*(currentpageindex+1),
            height: screenwidth*0.016,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
                color: Color(0xff0068FC),
                borderRadius: BorderRadius.all(Radius.circular(12))

            ),
          ),
        ],
      ),
    );
  }
  Widget questionairetext(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: screenwidth*0.08),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: screenwidth*0.0332,top: screenwidth*0.0309),
            child: SvgPicture.asset("assets/images/icons/horizline.svg",
            width: screenwidth*0.0332,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:EdgeInsets.only(top: screenwidth*0.0169,bottom: screenwidth*0.0234),
                child: Text(
                  "Question "+(currentpageindex+1).toString()+" of 10",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: larsseitMed,
                      color: Color(0xff0068FC),
                      fontSize: screenwidth * 0.0426),
                ),
              ),
              Container(
                child: SvgPicture.asset("assets/images/icons/selecttext.svg",width: screenwidth*0.567,),
              )
            ],
          ),

        ],
      ),
    );
  }
  Widget optionsection(BuildContext context){
    double screenwidth=MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         GestureDetector(
           onTap:(){
             setoptionselectstatus(1);
             incrementposresponses();
           },child: Container(
               margin: EdgeInsets.only(top: screenwidth*0.068),
               child: singleoptionrow(context, friendlyimg[currentpageindex],0)),
         ),
          GestureDetector(
            onTap: (){
              setoptionselectstatus(2);

            },
            child: Container(
                margin:EdgeInsets.only(top: screenwidth*0.100),
                child: singleoptionrow(context, unfriendlyimg[currentpageindex],1)),
          )
        ],
      ),
    );
  }
  Widget singleoptionrow(BuildContext context, String imageasset, int optindex){
    double screenwidth=MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(optionselectedstatus==(optindex+1)?CupertinoIcons.circle_fill:
                CupertinoIcons.circle,
                color: optionselectedstatus==(optindex+1)?Color(0xff0068FC):Color(0xff404040),
                size: screenwidth*0.048,),
              Container(
                margin: EdgeInsets.only(left: screenwidth*0.0209),
                child: Text(
                  optindex==0?"#1":"#2",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: tiemposMed,
                      color: optionselectedstatus==(optindex+1)?Color(0xff0068FC):
                      Color(0xff404040),
                      fontSize: screenwidth * 0.0346),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: screenwidth*0.0346),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(9)),
              child: Image.asset(imageasset,width: screenwidth*0.618,)),
        )
      ],
    );
  }
}