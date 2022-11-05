import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController loginemailcontroller=TextEditingController();
  TextEditingController loginpasswordcontroller=TextEditingController();
  bool showpassword=false;
  bool eye=false;
  String loginerrormsg="";
  String autherror="";
  String signuperrormsg="";
  bool showerror=false;

}