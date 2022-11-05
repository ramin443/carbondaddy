import 'dart:async';

import 'package:gogreen/constants/font_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late AnimationController tweencontroller;
  Animation<double>? animation;

  int initialfadeduration = 2000;
  int loginstat=0;
  var _duration = new Duration(seconds: 3);
  @override
  void initState() {
    super.initState();
    deployanimation();
    startTime();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    tweencontroller.dispose();
    super.dispose();
  }
  deployanimation() {
    tweencontroller=AnimationController(vsync: this,duration: Duration(seconds: 3));
    animation=Tween<double>(begin: 0.0,end: 58.0).animate(tweencontroller)..addListener(() {
      setState(() {
      });
    });
    tweencontroller.forward();
  }
  startTime() async {
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    bool loggedin=false;
    var user=FirebaseAuth.instance.currentUser;
    if(user==null){
      print("User not logged in");
      loggedin=false;
    }else{
      print("User  logged in");
      loggedin=true;
    }
    Navigator.of(context).pushReplacementNamed(loggedin?'/Base':"/SignUp");
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenheight,
        width: screenwidth,
        padding: EdgeInsets.only(bottom: 65),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/carbondad logo.svg",
              width: screenwidth*0.6,),

            Container(
              margin: EdgeInsets.only(
//                      top: 15
                  top: screenwidth*0.02
              ),
              child: Center(
                child: Text("Who's your Carbon Daddy?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: proximanovaregular,
                      color: Colors.black87,
//                        fontSize: 18
                      fontSize: screenwidth*0.048
                  ),),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
//                      top: 24
                  top: screenwidth*0.064
              ),
              //    duration: Duration(milliseconds: 5000),
//                  width: 58,height: 3,
              width: 58.0,height: screenwidth*0.008,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.black.withOpacity(0.06),
              ),
              alignment: Alignment.centerLeft,
              child: Container(
                //    duration: Duration(milliseconds: 5000),
                width:animation!.value,height: screenwidth*0.008,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
