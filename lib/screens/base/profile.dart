import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gogreen/getxcontrollers/profilecontroller.dart';

import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
class Profile extends StatelessWidget {
   Profile({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return
      GetBuilder<ProfileController>(
          initState: (v){
            profileController.setnameandemail();
          },
          init: ProfileController(),
          builder: (profilecontroller){
            return Scaffold(
              key: _key,
              backgroundColor: Colors.white,
              drawer: profilecontroller.drawer(context),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                actions: [
                  profilecontroller.changemade?
                  GestureDetector(onTap: (){
                    profilecontroller.updateuserdata(context);
                  }, child:  Container(
                    child: Text("Save",
                      style: TextStyle(
                          fontFamily: intermedium,
                          color: exohealgreen,
                          fontSize: 14
                      ),),
                  ),):
                  SizedBox(height: 0,),

                ],
                leading: IconButton(
                    onPressed: () {
                      _key.currentState!.openDrawer();
//                  profilecontroller.putprofiledatablob();
                    },
                    icon: Icon(
                      FeatherIcons.menu,
                      size: 20,
                      color: Color(0xff575757),
                    )),
                centerTitle: true,
                title: Container(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        fontFamily: intermedium,
                        fontSize: 16,
                        color: Color(0xff404040)),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profilecontroller.getprofilerow(context),
                      profilecontroller.borderline(context),
                      profilecontroller.profileoptionscolumn(context),

                    ],
                  ),
                ),
              ),
            );});
  }
}
