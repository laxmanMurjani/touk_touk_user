import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/ui/authentication_screen/login_screen.dart';
import 'package:etoUser/ui/authentication_screen/sign_in_up_screen.dart';
import 'package:etoUser/ui/terms_and_condition_screen.dart';
import 'package:etoUser/ui/widget/custom_button.dart';
import 'package:etoUser/ui/widget/no_internet_widget.dart';
import 'package:etoUser/enum/error_type.dart';

import '../../util/app_constant.dart';
import '../widget/custom_text_filed.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final UserController _userController = Get.find();
  bool value = false;
  bool rememberMe = false;

  _onRememberMeChanged(bool? newValue) => setState(() {
        rememberMe = newValue!;
        if (rememberMe) {
        } else {}
      });

  @override
  void initState() {
    super.initState();
    _userController.clearFormData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: GetX<UserController>(builder: (cont) {
        if (cont.error.value.errorType == ErrorType.internet) {
          return NoInternetWidget();
        }
        return Stack(
          children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: RichText(
            text: TextSpan(
              text: 'By Continuing, You Agree to our ',
              style: TextStyle(color: AppColors.primaryColor, fontSize: 10),
              children: <TextSpan>[
                TextSpan(
                    text: '\nTerms of use ',
                    style: TextStyle(color: Color(0xff297FFF), fontSize: 10)),
                TextSpan(
                  text: 'and',
                ),
                TextSpan(
                    text: '  Privacy Policy',
                    style: TextStyle(color: Color(0xff297FFF), fontSize: 10)),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            AppImage.building,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        Stack(alignment: Alignment.center, children: <Widget>[
          new Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.48,
                color: AppColors.white,
                // width: double.infinity,
                // child: Image.asset(
                //   'assets/images/top_home.png',
                //   fit: BoxFit.cover,
                // ),
              ),
              Flexible(fit: FlexFit.tight, child: SizedBox()),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.46,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/bottom_home.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      AppImage.building,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 25.0, left: 25.0),
            child: ListView(
              children: [
                Column(
                  // shrinkWrap: true,
                  // physics: BouncingScrollPhysics,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Container(
                        height: 150, child: ClipRRect(borderRadius: BorderRadius.circular(30),
                        child: Image.asset(AppImage.logoMain))),
                    SizedBox(height: 5.h),
                    Text(
                      'register'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFiled(
                      controller: cont.firstNameController,
                      label: "First Name",
                      hint: "First Name",
                      textCapitalization: TextCapitalization.sentences,
                      // inputFormatter: [
                      //   FilteringTextInputFormatter.deny(
                      //       RegExp(r'\s'))
                      // ],
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFiled(
                        controller: cont.lastNameController,
                        label: "last_name".tr,
                        hint: "last_name".tr,
                        textCapitalization: TextCapitalization.sentences,
                      // inputFormatter: [
                      //   FilteringTextInputFormatter.deny(
                      //       RegExp(r'\s'))
                      // ],
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFiled(
                      controller: cont.emailController,
                      hint: "email(optional)".tr,
                      label: "email(optional)".tr,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Stack(
                          children: [
                            // CountryCodePicker(
                            //   onChanged: (CountryCode countryCode) {
                            //     print("  ==>  ${countryCode.dialCode}");
                            //     if (countryCode.dialCode != null) {
                            //       cont.countryCode = countryCode.dialCode!;
                            //     }
                            //   },
                            //   // padding: EdgeInsets.all(1),
                            //   flagWidth: 25,
                            //   initialSelection: 'IN',
                            //   favorite: ['+91', 'IN'],
                            //   // countryFilter: ['IT', 'FR', 'IN'],
                            //   showFlagDialog: true,
                            //   // barrierColor: Colors.white,
                            //   // boxDecoration: BoxDecoration(
                            //   //   border: Border.all(width: 1.0, color: Colors.red),
                            //   //   color: Colors.red,
                            //   //   borderRadius:
                            //   //       BorderRadius.all(Radius.circular(5.0) //
                            //   //           ),
                            //   // ),
                            //   comparator: (a, b) =>
                            //       b.name!.compareTo(a.name.toString()),
                            //   //Get the country information relevant to the initial selection
                            //   onInit: (code) => print(
                            //       "on init ${code!.name} ${code.dialCode} ${code.name}"),
                            // ),
                            Row(
                              children: [
                                CountryCodePicker(
                                  onChanged: (s) {cont.countryCode = s.toString();},
                                  textStyle: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hideMainText: true,
                                  initialSelection:
                                      cont.userData.value.countryCode ??
                                          "+961",
                                  // favorite: ['+91', 'IN'],
                                  // countryFilter: ['IT', 'FR', "IN"],
                                  showFlagDialog: true,
                                  comparator: (a, b) =>
                                      b.name!.compareTo(a.name.toString()),
                                  //Get the country information relevant to the initial selection
                                  onInit: (code) => print(
                                      "on init ${code!.name} ${code.dialCode} ${code.name}"),
                                ),
                                Image.asset(
                                  AppImage.down_arrow,
                                  height: 15,
                                  width: 15,
                                  fit: BoxFit.contain,
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 45, left: 10),
                              color: Colors.black,
                              height: 1,
                              width: 80,
                            )
                          ],
                        ),
                        SizedBox(width: 15.w),
                        Expanded(
                          flex: 2,
                          child: CustomTextFiled(
                            controller: cont.phoneNumberController,
                            label: "phone".tr,
                            hint: "phone".tr,
                            inputType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFiled(
                      controller: cont.passwordController,
                      isPassword: true,
                      hint: "password".tr,
                      label: "password".tr,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFiled(
                      controller: cont.referralCodeController,
                      hint: "Referral Code (optional)".tr,
                      label: "Referral Code".tr,
                    ),
                    // CustomTextFiled(
                    //   controller: cont.passwordController,
                    //   hint: "your_referral_code".tr,
                    //   label: "your_referral_code".tr,
                    // ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomButton(
                        text: "Create an Account",
                        onTap: () {
                          cont.registerUser();
                          //cont.registerUser();
                          // Get.to(() => HomeScreen());
                        },
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text("Or",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomButton(
                        text: "log_in".tr,
                        bgColor: AppColors.white,
                        textColor: AppColors.primaryColor,
                        onTap: () {
                          Get.to(LoginScreen());
                        },
                      ),
                    ),
                    // Flexible(
                    //   child: SizedBox(),
                    //   fit: FlexFit.tight,
                    // ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.15),

                    // SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ]),
          ],
        );
      }),
    );
  }
}

// class UpperCaseTextFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     return TextEditingValue(
//       text: capitalize(newValue.text),
//       selection: newValue.selection,
//     );
//   }
// }
String capitalize(String value) {
  if(value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
