import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gogreen/constants/color_constants.dart';
import 'package:gogreen/constants/font_constants.dart';
import 'package:gogreen/datamodels/indiv_task.dart';

class HomeController extends GetxController {
  List<String> days = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];
  List<double> progresses = [2.4, 3.8, 6.3, 10, 8, 1.2, 4.5];
  List<TaskModel> tasks = [
    TaskModel(
        "assets/images/changeorglogo.png",
        "",
        "Sign up for this petition to ban"
            "plastic bags in Waunakee ",
        "40 pts",
        "Due"),
    TaskModel(
        "assets/images/attachment.jpeg",
        "",
        "Join the protest happening"
            "this November 11 in Bremer Marktplatz",
        "40 pts",
        "Due"),
  ];

  Widget taskrow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      padding: EdgeInsets.only(
          left: screenwidth * 0.046, right: screenwidth * 0.046),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: screenwidth * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenwidth * 0.017),
                  child: Text(
                    "Tasks assigned to you",
                    style: TextStyle(
                        fontFamily: intersemibold,
                        color: Color(0xff19221D),
                        fontSize: screenwidth * 0.0373),
                  ),
                ),
                Container(
                  child: SvgPicture.asset(
                    "assets/images/icons/seall.svg",
                    width: screenwidth * 0.173,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget personstatusrow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      padding: EdgeInsets.only(
          left: screenwidth * 0.046, right: screenwidth * 0.046),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: screenwidth * 0.044,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenwidth * 0.017),
                  child: Text(
                    "This is You",
                    style: TextStyle(
                        fontFamily: intersemibold,
                        color: Color(0xff19221D),
                        fontSize: screenwidth * 0.0373),
                  ),
                ),
                Container(
                  child: SvgPicture.asset(
                    "assets/images/icons/viewmore.svg",
                    width: screenwidth * 0.203,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget progresstoprow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      margin: EdgeInsets.only(top: screenwidth * 0.0434),
      padding: EdgeInsets.only(
          left: screenwidth * 0.046, right: screenwidth * 0.046),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: screenwidth * 0.044,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenwidth * 0.017),
                  child: Text(
                    "Progress",
                    style: TextStyle(
                        fontFamily: intersemibold,
                        color: Color(0xff19221D),
                        fontSize: screenwidth * 0.0373),
                  ),
                ),
                Container(
                  child: SvgPicture.asset(
                    "assets/images/icons/fullprogressreport.svg",
                    width: screenwidth * 0.4,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget withyourow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      padding: EdgeInsets.only(
          top: screenwidth * 0.0543,
          left: screenwidth * 0.046,
          right: screenwidth * 0.046),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: screenwidth * 0.044,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: screenwidth * 0.017),
                  child: Text(
                    "alongside you:",
                    style: TextStyle(
                        fontFamily: intersemibold,
                        color: exohealgreen,
                        fontSize: screenwidth * 0.0373),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget taskslistview(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return LimitedBox(
      maxHeight: screenwidth * 0.397,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: tasks!.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                individualtask(context, tasks[index]),
              ],
            );
          }),
    );
  }

  Widget avgdailypoints(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      margin: EdgeInsets.only(top: screenwidth * 0.0356),
      padding: EdgeInsets.only(left: screenwidth * 0.101),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                style: TextStyle(
                  fontFamily: eudoxussansmedium,
                  color: Color(0xff3F3F3F),
                  fontSize: screenwidth * 0.0293,
                ),
                children: [
                  TextSpan(text: "Average Daily points earned: "),
                  TextSpan(
                    text: "30 pts",
                    style: TextStyle(
                      fontFamily: eudoxussansmedium,
                      color: exohealgreen,
                      fontSize: screenwidth * 0.0293,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget individualtask(BuildContext context, TaskModel taskModel) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: screenwidth * 0.307,
        margin: EdgeInsets.only(
            right: screenwidth * 0.046,
            left: taskModel == tasks[0] ? screenwidth * 0.046 : 0),
        padding: EdgeInsets.only(
          left: screenwidth * 0.0281,
          right: screenwidth * 0.030,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1))
          ],
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                CupertinoIcons.circle,
                color: Color(0xffDCDCDC),
                size: 16,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.0358),
              width: screenwidth * 0.455,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      taskModel == tasks[0]
                          ? Image.asset(
                              taskModel.image!,
                              width: screenwidth * 0.206,
                            )
                          : Image.asset(
                              taskModel.image!,
                              height: screenwidth * 0.0966,
                            ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          FeatherIcons.arrowRight,
                          size: screenwidth * 0.0426,
                          color: Color(0xff3F3F3F),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: screenwidth * 0.0261,
                        bottom: screenwidth * 0.0264),
                    child: Text(
                      taskModel.description!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: eudoxussansmedium,
                          color: Color(0xff404040),
                          fontSize: screenwidth * 0.0266),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status: " + taskModel.status!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: eudoxussansmedium,
                            color: Color(0xffFF9D9D),
                            fontSize: screenwidth * 0.0266),
                      ),
                      Text(
                        taskModel.points!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: eudoxussansmedium,
                            color: exohealgreen,
                            fontSize: screenwidth * 0.0266),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget personalrow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    String email = FirebaseAuth.instance.currentUser!.email!;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("UserResponses")
            .doc(email)
            .snapshots(),
        builder: (context, responsesnaps) {
          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(email)
                  .snapshots(),
              builder: (context, usersnaps) {
                return !usersnaps.hasData
                    ? SizedBox(
                        height: 0,
                      )
                    : Container(
                        padding: EdgeInsets.only(
                            left: screenwidth * 0.0669,
                            right: screenwidth * 0.0752),
                        width: screenwidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenwidth * 0.0167),
                                  child: Image.asset(
                                    usersnaps.data!['avatar'],
                                    width: screenwidth * 0.161,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        usersnaps.data!['fullname'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: eudoxussansmedium,
                                            color: Color(0xff404040),
                                            fontSize: screenwidth * 0.0346),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Text(
                                        usersnaps.data!['type'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: eudoxussansmedium,
                                            color: exohealgreen,
                                            fontSize: screenwidth * 0.0303),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "score",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: eudoxussansmedium,
                                            color: exohealgreen,
                                            fontSize: screenwidth * 0.0303),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: screenwidth * 0.0167),
                                      child: Text(
                                        (responsesnaps.data!['numberofpositiveresponses']*10).
                                        toString()+" %",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: eudoxussansmedium,
                                            color: Color(0xff404040),
                                            fontSize: screenwidth * 0.0303),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
              });
        });
  }

  Widget daddyandsiblings(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      padding: EdgeInsets.only(
          left: screenwidth * 0.096, right: screenwidth * 0.0919),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "carbon daddy",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: eudoxussansmedium,
                      color: Color(0xff404040),
                      fontSize: screenwidth * 0.0346),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: screenwidth * 0.0356, bottom: screenwidth * 0.0153),
                child: Image.asset(
                  "assets/images/avatars/daddy1.jpg",
                  width: screenwidth * 0.22,
                ),
              ),
              Container(
                child: Text(
                  "Frank Fritz",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: eudoxussansmedium,
                      color: exohealgreen,
                      fontSize: screenwidth * 0.0346),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "your carbon siblings",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: eudoxussansmedium,
                      color: Color(0xff404040),
                      fontSize: screenwidth * 0.0346),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: screenwidth * 0.0356, bottom: screenwidth * 0.0153),
                child: Image.asset(
                  "assets/images/avatars/Group 33.png",
                  width: screenwidth * 0.438,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget aboutthemrow(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          top: screenwidth * 0.0434, bottom: screenwidth * 0.035),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/icons/aboutthem.svg",
            width: screenwidth * 0.374,
          ),
        ],
      ),
    );
  }

  Widget progressbarcontainer(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth * 0.841,
      height: screenwidth * 0.405,
      padding: EdgeInsets.only(
          top: screenwidth * 0.0282,
          bottom: screenwidth * 0.0282,
          left: screenwidth * 0.0509),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0xffABABAB).withOpacity(0.15),
                offset: Offset(0, 0),
                blurRadius: 10)
          ]),
      child: Container(
        height: screenwidth * 0.309,
        width: screenwidth * 0.841,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  oneprogressbar(context, index),
                ],
              );
            }),
      ),
    );
  }

  Widget oneprogressbar(BuildContext context, int index) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenwidth * 0.495,
      margin: EdgeInsets.only(
          bottom: screenwidth * 0.0169, right: screenwidth * 0.048),
      child: Column(
        children: [
          Container(
            height: screenwidth * 0.259,
            width: screenwidth * 0.018,
            decoration: BoxDecoration(
              color: Color(0xffEFEFEF),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: screenwidth * 0.259 / 10 * progresses[index],
                  width: screenwidth * 0.018,
                  decoration: BoxDecoration(
                    color: progresses[index] == 10
                        ? exohealgreen
                        : Color(0xffF5A491),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenwidth * 0.0169),
            child: Text(
              days[index],
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: eudoxussansmedium,
                  color: Color(0xff404040),
                  fontSize: screenwidth * 0.0346),
            ),
          ),
        ],
      ),
    );
  }
}
