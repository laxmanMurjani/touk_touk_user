import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/enum/error_type.dart';
import 'package:etoUser/ui/authentication_screen/login_screen.dart';
import 'package:etoUser/ui/authentication_screen/sign_up_screen.dart';
import 'package:etoUser/ui/widget/custom_button.dart';
import 'package:etoUser/ui/widget/no_internet_widget.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widget/custom_text_filed.dart';

class LoginWithEmailPassword extends StatefulWidget {
  const LoginWithEmailPassword({Key? key}) : super(key: key);

  @override
  State<LoginWithEmailPassword> createState() => _LoginWithEmailPasswordState();
}

class _LoginWithEmailPasswordState extends State<LoginWithEmailPassword> {
  final UserController _userController = Get.find();
  @override
  void initState() {
    super.initState();
    _userController.clearFormData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetX<UserController>(builder: (cont) {
        if (cont.error.value.errorType == ErrorType.internet) {
          return NoInternetWidget();
        }
        return SafeArea(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              new Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    color: AppColors.white,
                    // child: Image.asset(
                    //   'assets/images/top_home.png',
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.46,
                      //   width: double.infinity,
                      //   child: Image.asset(
                      //     'assets/images/bottom_home.png',
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'By Continuing, You Agree to our ',
                      //     style: TextStyle(
                      //         color: AppColors.primaryColor, fontSize: 10),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //           text: '\nTerms of use ',
                      //           style: TextStyle(
                      //               color: Color(0xff297FFF), fontSize: 10)),
                      //       TextSpan(
                      //         text: 'and',
                      //       ),
                      //       TextSpan(
                      //           text: '  Privacy Policy',
                      //           style: TextStyle(
                      //               color: Color(0xff297FFF), fontSize: 10)),
                      //     ],
                      //   ),
                      // ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            AppImage.login3,
                            //color: Colors.black.withOpacity(0.15),
                          )),
                    ],
                  ),
                ],
              ),
              new Container(
                alignment: Alignment.center,
                padding: new EdgeInsets.only(right: 15.0, left: 15.0, top: 15),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(height: 120, child: ClipRRect(borderRadius: BorderRadius.circular(100),
                            child: Image.asset(AppImage.logoMain))),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        // Row(
                        //   children: [
                        //     Card(
                        //       color: Colors.white,
                        //       child: CountryCodePicker(
                        //         onChanged: (CountryCode countryCode) {
                        //           print("  ==>  ${countryCode.dialCode}");
                        //           if (countryCode.dialCode != null) {
                        //             cont.countryCode = countryCode.dialCode!;
                        //           }
                        //         },
                        //         // padding: EdgeInsets.all(1),
                        //         flagWidth: 25,
                        //         initialSelection: 'IN',
                        //         favorite: ['+91', 'IN'],
                        //         // countryFilter: ['IT', 'FR', 'IN'],
                        //         showFlagDialog: true,
                        //         comparator: (a, b) =>
                        //             b.name!.compareTo(a.name.toString()),
                        //         //Get the country information relevant to the initial selection
                        //         onInit: (code) => print(
                        //             "on init ${code!.name} ${code.dialCode} ${code.name}"),
                        //       ),
                        //     ),
                        //     //
                        //     SizedBox(width: 5.w),
                        //     Expanded(
                        //       flex: 2,
                        //       child: CustomTextFiled(
                        //         controller: cont.phoneNumberController,
                        //         label: "phone".tr,
                        //         hint: "phone".tr,
                        //         inputType: TextInputType.phone,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // TextField(
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.deny(RegExp('[ ]')),
                        //   ],
                        //   controller: cont.emailController,
                        //   //obscureText: isPassword,
                        //   decoration: InputDecoration(
                        //     label: Text("email".tr),
                        //     hintText: "email".tr,
                        //     hintStyle:
                        //         TextStyle(fontSize: 10.sp, color: Colors.grey),
                        //     // labelText: label ?? "",
                        //     labelStyle: TextStyle(
                        //         fontSize: 10.sp, color: Color(0xffB4B4B5)),
                        //     //border: border,
                        //     //filled: filled,
                        //     //fillColor: fillColor,
                        //     isDense: true,
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.white),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.white),
                        //     ),
                        //     //suffixIcon: suffixIcon,
                        //   ),
                        //   style: TextStyle(
                        //       fontSize: 12.sp, fontWeight: FontWeight.w600),
                        //   keyboardType: TextInputType.emailAddress,
                        //   //readOnly: readOnly,
                        // ),

                        // CustomTextFiled(
                        //   controller: cont.phoneNumberController,
                        //   hint: "phone".tr,
                        //   label: "phone".tr,
                        //   inputType: TextInputType.number,
                        // ),
                        cusTextField(cont.phoneNumberController, 'phone'.tr, false, TextInputType.number, false),
                        SizedBox(height: 10.h),
                        // CustomTextFiled(
                        //   controller: cont.passwordController,
                        //   hint: "password".tr,
                        //   label: "password".tr,
                        //   isPassword: true,
                        // ),
                        cusTextField(cont.passwordController, 'password'.tr, false, TextInputType.text, true),
                        SizedBox(height: 7.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Get.to(()=> LoginScreen());
                              //cont.forgotPassword();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 10.h
                              ),
                              child: Text(
                                'login_via_otp'.tr,
                                //"forgot_password".tr,
                                style: TextStyle(
                                    fontSize: 13.sp, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        CustomButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          text: "log_in".tr,
                          onTap: () {
                            cont.loginUser();
                            // Get.to(() => HomeScreen());
                          },
                        ),
                        // SizedBox(height: 15.h),
                        // CustomButton(
                        //   padding: EdgeInsets.symmetric(vertical: 20),
                        //   text: "Continue",
                        //   onTap: () {
                        //     // cont.loginUser();
                        //     if (cont.phoneNumberController.text.isEmpty) {
                        //       cont.showError(msg: "please_number".tr);
                        //       return;
                        //     }
                        //     cont.sendOtp(params: params);
                        //   },
                        // ),
                        // SizedBox(height: 25.h),
                        // Text(
                        //   'Or',
                        //   style:
                        //   TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(height: 25.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     InkWell(
                        //       onTap: _faceBookLogin,
                        //       child: Container(
                        //         width: 50.w,
                        //         height: 50.w,
                        //         alignment: Alignment.center,
                        //         padding: EdgeInsets.all(5.w),
                        //         decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(5.w),
                        //             boxShadow: [
                        //               AppBoxShadow.defaultShadow(),
                        //             ]),
                        //         child: Image.asset(
                        //           AppImage.facebook,
                        //           width: 32.w,
                        //           height: 32.w,
                        //         ),
                        //       ),
                        //     ),
                        //     InkWell(
                        //       onTap: _googleLogin,
                        //       child: Container(
                        //         width: 50.w,
                        //         height: 50.w,
                        //         alignment: Alignment.center,
                        //         padding: EdgeInsets.all(5.w),
                        //         decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(5.w),
                        //             boxShadow: [
                        //               AppBoxShadow.defaultShadow(),
                        //             ]),
                        //         child: Image.asset(
                        //           AppImage.email,
                        //           width: 32.w,
                        //           height: 32.w,
                        //         ),
                        //       ),
                        //     ),
                        //     if (Platform.isIOS)
                        //       InkWell(
                        //         onTap: _appleLogin,
                        //         child: Container(
                        //           width: 50.w,
                        //           height: 50.w,
                        //           padding: EdgeInsets.all(5.w),
                        //           alignment: Alignment.center,
                        //           decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               borderRadius: BorderRadius.circular(5.w),
                        //               boxShadow: [
                        //                 AppBoxShadow.defaultShadow(),
                        //               ]),
                        //           child: Image.asset(
                        //             AppImage.apple,
                        //             width: 32.w,
                        //             height: 32.w,
                        //           ),
                        //         ),
                        //       ),
                        //   ],
                        // ),
                        // SizedBox(height: 25.h),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 30),
                        //   child: CustomButton(
                        //     text: "register".tr,
                        //     onTap: () {
                        //       // cont.registerUser();
                        //       Get.to(() => SignUpScreen());
                        //     },
                        //   ),
                        // ),
                        // SizedBox(height: 40.h),
                      ],
                    ),
                  ],
                ),
              ),
            ]));

        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     SizedBox(height: 43.h),
        //     Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Expanded(
        //           child: Text(
        //             "welcome_back".tr,
        //             style: TextStyle(
        //               fontWeight: FontWeight.w700,
        //               fontSize: 35.sp,
        //             ),
        //           ),
        //         ),
        //         InkWell(
        //           onTap: () {
        //             Get.back();
        //             _userController.isShowLogin.value = false;
        //           },
        //           child: Image.asset(
        //             AppImage.back,
        //             width: 35.w,
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 10.h),
        //     CustomTextFiled(
        //       controller: cont.emailController,
        //       hint: "email".tr,
        //       label: "email".tr,
        //     ),
        //     CustomTextFiled(
        //       controller: cont.passwordController,
        //       hint: "password".tr,
        //       label: "password".tr,
        //       isPassword: true,
        //     ),
        //     SizedBox(height: 7.h),
        //     Align(
        //       alignment: Alignment.centerRight,
        //       child: InkWell(
        //         onTap: (){
        //           cont.forgotPassword();
        //         },
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(vertical: 5.h),
        //           child: Text(
        //             "forget_password".tr,
        //             style: TextStyle(fontSize: 10.sp),
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 70.h),
        //     CustomButton(
        //       text: "log_in".tr,
        //       onTap: () {
        //         cont.loginUser();
        //         // Get.to(() => HomeScreen());
        //       },
        //     ),
        //     SizedBox(height: 15.h),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           "don't_have_an_account?".tr+" ",
        //           style: TextStyle(
        //             fontSize: 10.sp,
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             Get.to(() => SignUpScreen());
        //           },
        //           child: Padding(
        //             padding: EdgeInsets.symmetric(vertical: 5.h),
        //             child: Text(
        //               "register".tr,
        //               style: TextStyle(
        //                 color: AppColors.primaryColor,
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 10.sp,
        //                 decoration: TextDecoration.underline,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 40.h),
        //   ],
        // );
      }),
    );
  }

  Widget cusTextField(textEdController, hintTxt, firstLetterCapital, keyboardType, isObscured){
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),child:
    Container(height: 50,width: double.infinity,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.black26,
              blurRadius: 3,
            )
          ]),child: TextField(obscureText: isObscured,keyboardType: keyboardType,controller: textEdController,
        textCapitalization: firstLetterCapital? TextCapitalization.sentences : TextCapitalization.none,decoration:
        InputDecoration(border: InputBorder.none,hintText:
        hintTxt,hintStyle: TextStyle(fontSize: 18),contentPadding:
        EdgeInsets.only(top: 10,left: 10)),),),);
  }
}
