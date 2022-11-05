import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../getxcontrollers/authcontrollers.dart';
class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return GetBuilder<AuthController>(
        initState: (v){},
        init: AuthController(),
        builder: (authcontroller){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: screenwidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenwidth,
                      height: screenwidth*0.549,
                      decoration: BoxDecoration(
                        color: Color(0xffF8F5F2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
//                        height:65,width:65,
                            height:screenwidth*0.173,width:screenwidth*0.173,
                            margin: EdgeInsets.only(bottom: screenwidth*0.0746,
                                left: screenwidth*0.0693),
                            decoration: BoxDecoration(
                              color: Color(0xff19221D),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset("assets/images/Desk_duotone_line.svg",
                                width: screenwidth*0.0933,),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: screenwidth*0.0693),
                        width: screenwidth,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[

                              authcontroller.signupfields(context),

                            ])),

                  ],
                ),
              ),
            ),
          );
        });
  }
}
