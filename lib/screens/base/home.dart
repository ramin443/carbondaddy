import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../getxcontrollers/home_controller.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return
      GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homecontroller){
        return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  //homecontroller.listendevices();
                  //   homecontroller.tryazure();
                  // homecontroller.scanbluetoothdevices();
                },
                icon: Icon(
                  CupertinoIcons.ellipsis_vertical,
                  size: 20,
                  color: Color(0xff575757),
                ))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Container(
            child: SvgPicture.asset("assets/images/carbondad logo.svg",
              width: screenwidth*0.260,),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(bottom: screenwidth*0.06),
            width: screenwidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                homecontroller.taskrow(context),
                homecontroller.taskslistview(context),
                homecontroller.personstatusrow(context),
                homecontroller.personalrow(context),
                homecontroller.withyourow(context),
                homecontroller.daddyandsiblings(context),
                homecontroller.aboutthemrow(context),
                Container(
                  child: SvgPicture.asset("assets/images/icons/divider.svg",
                  width: screenwidth*0.869,),
                ),
                homecontroller.progresstoprow(context),
                homecontroller.progressbarcontainer(context),
                homecontroller.avgdailypoints(context),
              ],
            ),
          ),
        ),
      );});
    }
  }


