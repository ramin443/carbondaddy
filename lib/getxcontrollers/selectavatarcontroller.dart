import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectAvatarController extends GetxController {
  int maleavatarselectedstatus = 8;
  int femaleavatarselectedstatus = 8;

  void updatemaleselectedavatar(int index) async {
    maleavatarselectedstatus = index;
    update();
  }
  void updatefemaleselectedavatar(int index) async {
    femaleavatarselectedstatus = index;
    update();
  }

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

  void uploadmaleavatarstatus() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .update({"avatar": maleavatars[maleavatarselectedstatus]});
  }

  void uploadfemaleavatarstatus() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .update({"avatar": femaleavatars[femaleavatarselectedstatus]});
  }

  Widget maleavatarrow1(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      margin: EdgeInsets.only(top: screenwidth * 0.114),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(children: [
      GestureDetector(
      onTap: (){
    updatemaleselectedavatar(0);
    },child:Container(
              margin: EdgeInsets.only(left: screenwidth * 0.08),
              child: Image.asset(
                maleavatars[0],
                width: screenwidth * 0.30,
              ),
            )),
            maleavatarselectedstatus==0?
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.08),
              width: screenwidth * 0.30,
              height: screenwidth * 0.30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff006EFF),width: 3,)
              ),
            ):SizedBox(height: 0,),

          ]),
          Stack(children: [
    GestureDetector(
    onTap: (){
    updatemaleselectedavatar(1);
    },child:Container(
              margin: EdgeInsets.only(left: screenwidth * 0.088),
              child: Image.asset(
                maleavatars[1],
                width: screenwidth * 0.30,
              ),
            )),
            maleavatarselectedstatus==1?
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.088),
              width: screenwidth * 0.30,
              height: screenwidth * 0.30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff006EFF),width: 3,)
              ),
            ):SizedBox(height: 0,),
          ]),
        ],
      ),
    );
  }

  Widget maleavatarrow2(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
      Stack(children: [
      GestureDetector(
      onTap: (){
    updatemaleselectedavatar(2);
    },child:Container(
            margin: EdgeInsets.only(right: screenwidth * 0.114),
            child: Image.asset(
              maleavatars[2],
              width: screenwidth * 0.30,
            ),
          ),),
        maleavatarselectedstatus==2?
        Container(
          margin: EdgeInsets.only(right: screenwidth * 0.114),
          width: screenwidth * 0.30,
          height: screenwidth * 0.30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xff006EFF),width: 3,)
          ),
        ):SizedBox(height: 0,),]),
    Stack(children: [
    GestureDetector(
      onTap: (){
        updatemaleselectedavatar(3);
      },
      child: Container(
              margin: EdgeInsets.only(right: screenwidth * 0.083),
              child: Image.asset(
                maleavatars[3],
                width: screenwidth * 0.30,
              ),
            ),
    ),
      maleavatarselectedstatus==3?
      Container(
        margin: EdgeInsets.only(right: screenwidth * 0.083),
        width: screenwidth * 0.30,
        height: screenwidth * 0.30,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xff006EFF),width: 3,)
        ),
      ):SizedBox(height: 0,),
    ])
        ],
      ),
    );
  }
  Widget femaleavatarrow1(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      margin: EdgeInsets.only(top: screenwidth * 0.114),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(children: [
            GestureDetector(
                onTap: (){
                  updatefemaleselectedavatar(0);
                },child:Container(
              margin: EdgeInsets.only(left: screenwidth * 0.17),
              child: Image.asset(
                femaleavatars[0],
                width: screenwidth * 0.30,
              ),
            )),
            femaleavatarselectedstatus==0?
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.17),
              width: screenwidth * 0.30,
              height: screenwidth * 0.30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff006EFF),width: 3,)
              ),
            ):SizedBox(height: 0,),

          ]),
          Stack(children: [
            GestureDetector(
                onTap: (){
                  updatefemaleselectedavatar(1);
                },child:Container(
              margin: EdgeInsets.only(left: screenwidth * 0.088),
              child: Image.asset(
                femaleavatars[1],
                width: screenwidth * 0.30,
              ),
            )),
            femaleavatarselectedstatus==1?
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.088),
              width: screenwidth * 0.30,
              height: screenwidth * 0.30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff006EFF),width: 3,)
              ),
            ):SizedBox(height: 0,),
          ]),
        ],
      ),
    );
  }
  Widget femaleavatarrow2(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      margin: EdgeInsets.only(top: screenwidth * 0.034),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(children: [
            GestureDetector(
                onTap: (){
                  updatefemaleselectedavatar(2);
                },child:Container(
              margin: EdgeInsets.only(left: screenwidth * 0.08),
              child: Image.asset(
                femaleavatars[2],
                width: screenwidth * 0.30,
              ),
            )),
            femaleavatarselectedstatus==2?
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.08),
              width: screenwidth * 0.30,
              height: screenwidth * 0.30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff006EFF),width: 3,)
              ),
            ):SizedBox(height: 0,),

          ]),
          Stack(children: [
            GestureDetector(
                onTap: (){
                  updatefemaleselectedavatar(3);
                },child:Container(
              margin: EdgeInsets.only(left: screenwidth * 0.088),
              child: Image.asset(
                femaleavatars[3],
                width: screenwidth * 0.30,
              ),
            )),
            femaleavatarselectedstatus==3?
            Container(
              margin: EdgeInsets.only(left: screenwidth * 0.088),
              width: screenwidth * 0.30,
              height: screenwidth * 0.30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff006EFF),width: 3,)
              ),
            ):SizedBox(height: 0,),
          ]),
        ],
      ),
    );
  }
  Widget femaleavatarrow3(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: screenwidth * 0.034),
      width: screenwidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(children: [
            GestureDetector(
              onTap: (){
                updatefemaleselectedavatar(4);
              },child:Container(
              margin: EdgeInsets.only(right: screenwidth * 0.114),
              child: Image.asset(
                femaleavatars[4],
                width: screenwidth * 0.30,
              ),
            ),),
            femaleavatarselectedstatus==4?
            Container(
              margin: EdgeInsets.only(right: screenwidth * 0.114),
              width: screenwidth * 0.30,
              height: screenwidth * 0.30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff006EFF),width: 3,)
              ),
            ):SizedBox(height: 0,),]),
          Stack(children: [
            GestureDetector(
              onTap: (){
                updatefemaleselectedavatar(5);
              },
              child: Container(
                margin: EdgeInsets.only(right: screenwidth * 0.083),
                child: Image.asset(
                  femaleavatars[5],
                  width: screenwidth * 0.30,
                ),
              ),
            ),
            femaleavatarselectedstatus==5?
            Container(
              margin: EdgeInsets.only(right: screenwidth * 0.083),
              width: screenwidth * 0.30,
              height: screenwidth * 0.30,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff006EFF),width: 3,)
              ),
            ):SizedBox(height: 0,),
          ])
        ],
      ),
    );
  }
}
