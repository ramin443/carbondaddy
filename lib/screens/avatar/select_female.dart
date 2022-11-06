import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/font_constants.dart';
import '../../getxcontrollers/selectavatarcontroller.dart';
class SelectFemale extends StatelessWidget {
  const SelectFemale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return GetBuilder<SelectAvatarController>(
        init: SelectAvatarController(),
        builder: (avatarcontroller){
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: GestureDetector(
              onTap: ()async{
                if(avatarcontroller.femaleavatarselectedstatus==8){

                }else{
                  avatarcontroller.uploadfemaleavatarstatus();
                  Navigator.pushNamedAndRemoveUntil(context, "/SurveyPage", (route) => false);
                }

              },
              child: Container(
                width: screenwidth*0.762,
                height: screenwidth*0.110,
                padding: EdgeInsets.symmetric(horizontal: screenwidth *0.0293),
                margin: EdgeInsets.only(bottom: screenwidth*0.156),

                decoration: BoxDecoration(
                  color: avatarcontroller.femaleavatarselectedstatus==8?
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
                      child: Text(
                        "Done",style: TextStyle(
                          fontFamily: intermedium,
                          color: Colors.white,
                          fontSize: screenwidth*0.0373
                      ),),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: Color(0xffECECEC),
                        size: screenwidth*0.053,),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: screenwidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenwidth*0.134,
                          top: screenwidth*0.05),
                      child: SvgPicture.asset("assets/images/icons/selectavatar.svg",
                        width: screenwidth*0.430,),
                    ),
                    avatarcontroller.femaleavatarrow1(context),
                    avatarcontroller.femaleavatarrow2(context),
                    avatarcontroller.femaleavatarrow3(context),

                  ],
                ),
              ),
            ),
          );});
  }
}
