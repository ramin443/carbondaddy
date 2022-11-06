import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gogreen/getxcontrollers/survey_controller.dart';

import '../../constants/font_constants.dart';
class SurveyBase extends StatelessWidget {
  const SurveyBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return GetBuilder<SurveyController>(
        init: SurveyController(),
        builder: (surveycontroller){
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: ()async{
            if(surveycontroller.optionselectedstatus==0){

            }else{
              if(surveycontroller.currentpageindex==9){
                surveycontroller.uploaduserpreference();
                surveycontroller.updateusertype();
                Navigator.pushNamedAndRemoveUntil(context, "/Base", (route) => false);
              }else{
                surveycontroller.incrementpageindex();
                surveycontroller.resetoptionselection();
                surveycontroller.resetoptionselection();
              }
            }


          },
          child: Container(
            width: screenwidth*0.762,
            height: screenwidth*0.110,
            padding: EdgeInsets.symmetric(horizontal: screenwidth *0.0293),
            margin: EdgeInsets.only(bottom: screenwidth*0.156),

            decoration: BoxDecoration(
              color: surveycontroller.optionselectedstatus==0?
              Color(0xff006EFF).withOpacity(0.6):
              Color(0xff006EFF),
              borderRadius: BorderRadius.all(Radius.circular(40)),
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
                  child: Text(surveycontroller.currentpageindex==9?
                  "Finish":"Next",style: TextStyle(
                      fontFamily: intermedium,
                      color: Colors.white,
                      fontSize: screenwidth*0.0373
                  ),),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Icon(surveycontroller.currentpageindex==9?
                  CupertinoIcons.checkmark_alt:
                  CupertinoIcons.arrow_right,
                    color: Color(0xffECECEC),
                    size: screenwidth*0.053,),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(bottom: screenwidth*0.308),
            width: screenwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                surveycontroller.pageslider(context),
                surveycontroller.questionairetext(context),
                surveycontroller.optionsection(context),
              ],
            ),
          ),
        ),
      );});
    }
  }

