import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/enum/error_type.dart';
import 'package:etoUser/ui/widget/custom_button.dart';
import 'package:etoUser/ui/widget/cutom_appbar.dart';
import 'package:etoUser/ui/widget/no_internet_widget.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen.dart';

class OtpScreen extends StatefulWidget {
  Map<String, dynamic> params;
  bool isAuthLogin ;
  bool isFaceBookLogin ;
  OtpScreen({required this.params,this.isAuthLogin = false,this.isFaceBookLogin = false});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = "";
  final phoneNumber = Get.arguments[0];
  final countryCode = Get.arguments[1];
  bool isResendOtp = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(backgroundColor: Colors.white,resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.white,elevation:0,
        leading: GestureDetector(onTap: (){
          Get.back();
        },child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text('verification_code'.tr,style:
        TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),),centerTitle: true,),
      // appBar: CustomAppBar(
      //   text: "verification_code".tr,
      // ),
      body: GetX<UserController>(builder: (cont) {
        if ((cont.error.value.errorType == ErrorType.internet)) {
          return NoInternetWidget();
        }
        return Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppImage.login2,
                //color: Colors.black.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(100),
                      child: Image.asset(AppImage.logoMain,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.14,
                        width: MediaQuery
                            .of(context)
                            .size
                            .height * 0.14,)),
                  SizedBox(height: 30,),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Please_type_the_verification_code_sent_to_your".tr,
                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'mobile_number'.tr,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: ' ******'+cont.phoneNumberController.text.substring(6),
                            style:
                                TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500)),
                      ],
                    ),

                  ),
                  Center(
                    child: Text(
                      "".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  PinCodeTextField(
                    autoFocus: true,
                    appContext: context,
                    length: 4,
                    obscureText: false,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    animationType: AnimationType.fade,enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        color: Colors.black26,
                        blurRadius: 3,
                      )
                    ],
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15),
                        fieldHeight: 50,
                        borderWidth: 1,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        activeColor: AppColors.white,
                        disabledColor: AppColors.white,
                        errorBorderColor: Colors.red,
                        inactiveColor: AppColors.white,
                        selectedColor: AppColors.white,
                        selectedFillColor: AppColors.white,
                        inactiveFillColor: AppColors.white
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,

                    onCompleted: (v) {
                      print("Completed===>${v}");
                      _otp = v;
                      print("value00===>${_otp}");
                    },
                    onChanged: (value) {
                      print("value===>${value}");
                      _otp = value;
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  // OtpTextField(
                  //   numberOfFields: 4,
                  //   // borderColor: AppColors.primaryColor,
                  //   decoration: InputDecoration(
                  //     fillColor: Colors.red,
                  //     filled: true,
                  //     focusedBorder: OutlineInputBorder(
                  //       // borderRadius: BorderRadius.circular(5.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.white,
                  //         width: 3.0,
                  //       ),
                  //     ),
                  //     contentPadding: const EdgeInsets.fromLTRB(
                  //       20.0,
                  //       10.0,
                  //       20.0,
                  //       10.0,
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       // borderRadius: BorderRadius.circular(5.0),
                  //       borderSide: const BorderSide(
                  //         color: Colors.white,
                  //         width: 3.0,
                  //       ),
                  //     ),
                  //     // enabledBorder: OutlineInputBorder(
                  //     //   borderSide: BorderSide(color: Colors.white),
                  //     // ),
                  //   ),
                  //   showFieldAsBox: true,
                  //   fillColor: Colors.white, filled: true,
                  //   borderColor: AppColors.white,
                  //   enabledBorderColor: AppColors.white,
                  //   focusedBorderColor: AppColors.white,
                  //   disabledBorderColor: AppColors.white,
                  //   autoFocus: true,
                  //   //runs when a code is typed in
                  //   onCodeChanged: (String code) {
                  //     //handle validation or checks here
                  //     _otp = code;
                  //   },
                  //   //runs when every textfield is filled
                  //   onSubmit: (String verificationCode) {
                  //     _otp = verificationCode;
                  //     print("object  ==>  $_otp");
                  //   }, // end onSubmit
                  // ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () async {
                      if (_otp.length != 4) {
                        print("enter 1");
                        Get.snackbar("Alert", "please_enter_otp",
                            backgroundColor: Colors.redAccent.withOpacity(0.8),
                            colorText: Colors.white);
                        // cont.showError(msg: "please_enter_otp".tr);
                        return;
                      }
                      if (!isResendOtp) {
                        if (_otp != widget.params["otp"].toString()) {
                          print("enter 2");
                          Get.snackbar("Alert", "Please enter valid otp",
                              backgroundColor: Colors.redAccent.withOpacity(0.8),
                              colorText: Colors.white);
                          // cont.showError(msg: "Please enter valid otp");
                          return;
                        }
                      }

                      if (widget.params["login_by"] == "facebook") {
                        print("enter 3");
                        cont.loginWithFacebook(
                            accessToken: "", data: widget.params);
                      } else if (widget.params["login_by"] == "google") {
                        print("enter 4");
                        cont.loginWithGoogle(
                            accessToken: "", data: widget.params);
                      } else if (widget.params["login_by"] == "apple") {
                        print("enter 5");
                        cont.loginWithApple(
                            socialUniqueId: "", data: widget.params);
                      }
                      if (isResendOtp) {
                        await cont.verifyResendOTp(_otp, phoneNumber);
                        setState(() {
                          isResendOtp = false;
                        });
                      } else {
                        if(widget.isAuthLogin){
                          print("isauth===>${widget.isAuthLogin}");
                          cont.verifyOTpWithAuth(_otp);
                        }else if(widget.isFaceBookLogin) {
                          cont.verifyOTpWithFaceBook(_otp);
                        } else{
                          cont.verifyOTp(_otp);
                        }
                      }
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width*0.7,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text("continue".tr,
                          style:
                              TextStyle(fontSize: 16.h, color: Colors.white,fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(height: 20.h),
                 widget.isAuthLogin || widget.isFaceBookLogin ? SizedBox() : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("didn_t_get_the_OTP".tr,
                          style: TextStyle(
                            color: AppColors.drawer.withOpacity(0.8),fontWeight: FontWeight.w500
                          )),
                      SizedBox(width: 3,),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          // await prefs.setInt('resendOtpTimestamp', DateTime.now().millisecondsSinceEpoch);
                          var millis = await prefs.getInt('resendOtpTimestamp');
                          print('millis ${millis}');

                          if(millis != null){
                            // Assuming you have the original time and a timestamp in milliseconds
                            int originalTimestamp = DateTime.now().millisecondsSinceEpoch;
                            int? timestamp = millis;

// Create DateTime objects from the timestamps
                            DateTime originalDateTime = DateTime.fromMillisecondsSinceEpoch(originalTimestamp);
                            DateTime timestampDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

// Calculate the difference in minutes
                            Duration difference = timestampDateTime.difference(originalDateTime);
                            print("ddddd===>${difference}");
                            int differenceInMinutes = difference.inMinutes * (-1);

// Print the result
                            print('Difference in minutes: $differenceInMinutes');

                            if(prefs.containsKey('resendOtpCounter') && differenceInMinutes >= 59){
                              await prefs.remove('resendOtpTimestamp');
                              await prefs.remove('resendOtpCounter');
                              print("dbc===L>${differenceInMinutes >= 59}");

                            }
                            // Get.snackbar('Alert', "'Retry after 6 hours'",
                            //     backgroundColor: Colors.red.withOpacity(0.8),
                            //     colorText: Colors.white);
                          }

                          cont.resendOtpCounter.value ++;

                          // cont.resendOtpCounter.value = prefs.getBool(key)

                          if(prefs.containsKey('resendOtpCounter')){
                            Get.snackbar('Alert', "'Retry after 6 hours'",
                                backgroundColor: Colors.red.withOpacity(0.8),
                                colorText: Colors.white);
                            //print("dbc===L>${differenceInMinutes >= 59}");
                          }else{
                            print('counterValue: ${cont.resendOtpCounter.value}');
                            if(cont.resendOtpCounter.value<=2){
                              print('resendOtpCounter is less than equal 2');
                              setState(() {
                                isResendOtp = true;
                              });
                              Map<String, dynamic> params = {};
                              params["mobile"] = phoneNumber;
                              params["country_code"] = countryCode;
                              if(widget.isAuthLogin){
                                cont.sendOtpWithGoogleSignIn(params: params);
                              }else{
                                cont.sendOtp(params: params);
                                print("otp===> ${_otp}");
                              }
                            }else{

                              Get.snackbar('Alert', "'Retry after 6 hours'",
                                  backgroundColor: Colors.red.withOpacity(0.8),
                                  colorText: Colors.white);
                              print('currentTime${DateTime.now().millisecondsSinceEpoch}');
                              await prefs.setBool('resendOtpCounter', true);
                              await prefs.setInt('resendOtpTimestamp', DateTime.now().millisecondsSinceEpoch);
                            }
                          }



                        },
                        child: Text(
                          "resend_OTP".tr,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: "Didn't get the OTP" + " ",
                  //     style: TextStyle(
                  //       color: AppColors.drawer.withOpacity(0.8),
                  //     ),
                  //     children: [
                  //       WidgetSpan(
                  //         child:
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
