import 'dart:developer';
import 'dart:io';
// import 'com.facebook.FacebookSdk';
// import 'com.facebook.appevents.AppEventsLogger';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/enum/error_type.dart';
import 'package:etoUser/preference/preference.dart';
import 'package:etoUser/ui/authentication_screen/loginWithEmailPassword.dart';
import 'package:etoUser/ui/authentication_screen/newRegistrationScreen.dart';
import 'package:etoUser/ui/authentication_screen/sign_up_screen.dart';
import 'package:etoUser/ui/widget/custom_button.dart';
import 'package:etoUser/ui/widget/custom_text_filed.dart';
import 'package:etoUser/ui/widget/no_internet_widget.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserController _userController = Get.find();
  var items = [
    'English',
    'Arabic',
    'Armenian'
  ];

  Map<String, dynamic> params = Map();
  //bool isResendOtp = false;

  @override
  void initState() {
    super.initState();
    _userController.clearFormData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      print(
          "prefs.containsKey(Database.seenOnBoarding)===>${prefs.containsKey(Database.seenOnBoarding)}");
      if (!prefs.containsKey(Database.seenOnBoarding)) {
        _showDialog();
      }
     _userController.isUserUpdated.value = prefs.containsKey('isUserUpdated');
    });
  }

  _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              "Touk touk user would like to collect location data to enable your current location to provide you the service for taxi booking and navigation even when the app is closed or not in use.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Database.setSeenLocationAlertDialog();
                    Get.back();
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return
      Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GetX<UserController>(
        builder: (cont) {
          if (cont.error.value.errorType == ErrorType.internet) {
            return NoInternetWidget();
          }
          return Stack(alignment: Alignment.center, children: <Widget>[
            new ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              color: AppColors.white,
              // width: double.infinity,
              // child: Image.asset(
              //   'assets/images/top_home.png',
              //   fit: BoxFit.cover,
              // ),
            ),
            //Flexible(fit: FlexFit.tight, child: SizedBox()),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: double.infinity,
                  // child: Image.asset(
                  //   'assets/images/bottom_home.png',
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'By Continuing, You Agree to our ',
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 10),
                      children: <TextSpan>[
                        TextSpan(
                            text: '\nTerms of use ',
                            style: TextStyle(
                                color: Color(0xff297FFF), fontSize: 10)),
                        TextSpan(
                          text: 'and',
                        ),
                        TextSpan(
                            text: '  Privacy Policy',
                            style: TextStyle(
                                color: Color(0xff297FFF), fontSize: 10)),
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Image.asset(
                //     AppImage.building,
                //     color: Colors.black.withOpacity(0.1),
                //   ),
                // ),
              ],
            ),
          ],
            ),
            Align(alignment: Alignment.bottomCenter,child: Image.asset('assets/images/login1.png'),),
            new Container(
          alignment: Alignment.center,
          padding: new EdgeInsets.only(right: 25.0, left: 25.0, top: 50),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
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
                  // Container(
                  //     height: 150, child: ClipRRect(borderRadius: BorderRadius.circular(30),
                  //     child: Image.asset(AppImage.logoMain,))),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    'join_us'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
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
                                hideMainText: false,
                                initialSelection:
                                    cont.userData.value.countryCode ??
                                        "+961",
                                        //"+91",
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
                          // Container(
                          //   margin: EdgeInsets.only(top: 45, left: 10),
                          //   color: Colors.black,
                          //   height: 1,
                          //   width: 80,
                          // )
                        ],
                      ),
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
                      //   comparator: (a, b) =>
                      //       b.name!.compareTo(a.name.toString()),
                      //   //Get the country information relevant to the initial selection
                      //   onInit: (code) => print(
                      //       "on init ${code!.name} ${code.dialCode} ${code.name}"),
                      // ),
                      //
                      SizedBox(width: 15.w),
                      Expanded(
                        flex: 2,
                        child: CustomTextFiled(
                          controller: cont.phoneNumberController,
                          label: "enter_yor_phone".tr,
                          hint: "enter_yor_phone".tr,
                          inputType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  InkWell(
                    onTap: () {
                      // print('xyz ${GetStorage().read('isUserUpdated')}');
                      // Get.to(()=> NewRegistrationScreen());
                      print('ccode:${cont.countryCode}');
                      if (cont.phoneNumberController.text.isEmpty) {
                        // cont.showError(msg: "please_number".tr);
                        Get.snackbar("Alert", "please_number.".tr,
                            backgroundColor: Colors.redAccent.withOpacity(0.8),
                            colorText: Colors.white);
                        return;
                      } else if (cont.phoneNumberController.text.length !=
                          10 &&
                          cont.countryCode == '+91') {
                        Get.snackbar("Alert", "Please enter valid 10 digit mobile number",
                            backgroundColor: Colors.redAccent.withOpacity(0.8),
                            colorText: Colors.white);
                        // cont.showError(
                        //     msg:
                        //         "Please enter valid 10 digit mobile number");
                        return;
                      } else if (((cont.phoneNumberController.text.length ==
                          6 || cont.phoneNumberController.text.length ==
                          8 || cont.phoneNumberController.text.length ==
                          7) &&
                          cont.countryCode == '+961') || cont.phoneNumberController.text.length ==
                          10 && cont.countryCode != '+961') {
                        print('passed');
                        sendOtp(cont);
                        // cont.sendOtp(params: params);
                        return;
                      }
                      Get.snackbar("Alert", "Please enter a valid mobile number",
                          backgroundColor: Colors.redAccent.withOpacity(0.8),
                          colorText: Colors.white);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.76,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                            ),
                        child: Text(
                          'continue'.tr,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // GetStorage().read('isUserUpdated')==true?
                  cont.isUserUpdated.value?
                  GestureDetector(onTap: (){
                    Get.to(() => LoginWithEmailPassword());
                  },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.76,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'login_with_pw'.tr,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ) : SizedBox(),

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
                  //   style: TextStyle(
                  //       fontSize: 14, fontWeight: FontWeight.w500),
                  // ),
                  // SizedBox(height: 25.h),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 30),
                  //   child: CustomButton(
                  //     text: "Login with password",
                  //     onTap: () {
                  //       // cont.registerUser();
                  //       Get.to(() => LoginWithEmailPassword());
                  //     },
                  //   ),
                  // ),
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
                  // Text(
                  //   'Dont_have'.tr,
                  //   style: TextStyle(
                  //       fontSize: 13.sp,
                  //       fontWeight: FontWeight.w500,
                  //       color: Colors.black),
                  // ),
                  // SizedBox(height: 5.h),
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
                  SizedBox(height: 40.h),
                ],
              ),
            ],
          ),
            ),
            Align(alignment: Alignment.topRight,child:
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05, right: 10),
              child: Container(width: MediaQuery.of(context).size.width*0.35,height: 40,decoration:
              BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8),
                  child: DropdownButton<String>(
                    // Initial Value
                    value: cont.selectedLanguage.value == 0? 'English' :
                    cont.selectedLanguage.value == 1? 'Arabic' : 'Armenian',

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        //dropdownvalue = newValue!;
                        if(newValue=='English'){
                          cont.selectedLanguage.value = 0;
                          cont.setLanguage();
                        }else if(newValue=='Arabic'){
                          cont.selectedLanguage.value = 1;
                          Get.updateLocale(Locale('ar', 'AE'));
                          cont.setLanguage();
                        }else if(newValue=='Armenian'){
                          cont.selectedLanguage.value = 2;
                          Get.updateLocale(Locale('hy', 'AM'));
                          cont.setLanguage();
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            ),
          ]);

          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     SizedBox(height: 40.h),
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
          //         onTap: () {
          //           cont.forgotPassword();
          //         },
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(vertical: 5.h),
          //           child: Text(
          //             "forgot_password".tr,
          //             style: TextStyle(fontSize: 10.sp),
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(height: 65.h),
          //     CustomButton(
          //       text: "log_in".tr,
          //       onTap: () {
          //         cont.loginUser();
          //         // Get.to(() => HomeScreen());
          //       },
          //     ),
          //     SizedBox(height: 20.h),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           "${"don't_have_an_account?".tr} ",
          //           style: TextStyle(
          //             fontSize: 10.sp,
          //           ),
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             Get.to(() => SignUpScreen());
          //           },
          //           child: Text(
          //             "register".tr,
          //             style: TextStyle(
          //               color: AppColors.primaryColor,
          //               fontWeight: FontWeight.w700,
          //               fontSize: 10.sp,
          //               decoration: TextDecoration.underline,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     SizedBox(height: 60.h),
          //   ],
          // );
        },
      ),
    );
  }

  Future<void> _faceBookLogin() async {
    try {
      AccessToken? accessToken = await FacebookAuth.instance.accessToken;
      // await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login();

      log("messageFacebook    ==>   ${result.message}     ${result.status}");

      switch (result.status) {
        case LoginStatus.success:
          // final AuthCredential? facebookCredential =
          // FacebookAuthProvider.credential(result.accessToken.token);
          // final userCredential =
          //     await _auth.signInWithCredential(facebookCredential);
          // Map<String, String> params = {};
          // params["name"] = "${userCredential.user.displayName}";
          // params["email"] = "${userCredential.user.email}";
          // params["so_id"] = "${userCredential.user.uid}";
          // params["so_platform"] = "FACEBOOK";
          // log("messageFacebook    ==>   ${userCredential.user.email}   ${userCredential.user.displayName}   ${userCredential.user.phoneNumber}  ${userCredential.user.photoURL}  ${userCredential.user.uid}");
          // _socialLogin(params: params);
          _userController.facebookAuthToken.value = result.accessToken!.token.toString();
          _userController.loginWithFacebook(
              accessToken: "${result.accessToken?.token ?? ""}");
          break;

        case LoginStatus.failed:
          // _userController.showError(msg: result.message ?? "");
          Get.snackbar("Alert", "${result.message}",
              backgroundColor: Colors.redAccent.withOpacity(0.8),
              colorText: Colors.white);
          break;
        case LoginStatus.cancelled:
          // _userController.showError(msg: result.message ?? "");
          Get.snackbar("Alert", "${result.message}",
              backgroundColor: Colors.redAccent.withOpacity(0.8),
              colorText: Colors.white);
          break;
        default:
          return null;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> _appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: 'example-nonce',
        state: 'example-state',
      );

      log("Apple Login ==>  ${credential.userIdentifier}    ${credential.email}   ${credential.authorizationCode}");
      _userController.loginWithApple(
          socialUniqueId: credential.userIdentifier ?? "");
    } on SignInWithAppleAuthorizationException catch (e) {
      // _userController.showError(msg: "${e.message}");
      Get.snackbar("Alert", "${e.message}",
          backgroundColor: Colors.redAccent.withOpacity(0.8),
          colorText: Colors.white);
    } catch (e) {
      _userController.showError(msg: "$e");
      Get.snackbar("Alert", "${e}",
          backgroundColor: Colors.redAccent.withOpacity(0.8),
          colorText: Colors.white);
      // _userController.showError(msg: "$e");
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly'
    ],
    signInOption: SignInOption.standard,
    //clientId: AppString.googleSignInServerClientId,
    // hostedDomain: "predictive-host-314811.firebaseapp.com"
  );

  Future<void> _googleLogin() async {
    if (await _googleSignIn.isSignedIn()) {
      print("google signin login");
      await _googleSignIn.signOut();
    }
    GoogleSignInAccount? _googleSignAccount = await _googleSignIn.signIn();
    log("GoogleSignInAuthentication   ==>    ${_googleSignAccount}");
    if (_googleSignAccount != null) {
      GoogleSignInAuthentication? googleSignInAuthentication =
          await _googleSignAccount.authentication;
      log("GoogleSignInAuthentication   ==>    ${googleSignInAuthentication.accessToken}");
      _userController.googleAuthToken.value = googleSignInAuthentication.accessToken!;
      _userController.loginWithGoogle(accessToken: googleSignInAuthentication.accessToken ?? "");
    }
  }

  sendOtp(cont) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('resendOtpTimestamp', DateTime.now().millisecondsSinceEpoch);
    var millis = await prefs.getInt('sendOtpTimestamp');
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

      if(prefs.containsKey('sendOtpCounter') && differenceInMinutes >= 59){
        await prefs.remove('sendOtpTimestamp');
        await prefs.remove('sendOtpCounter');
        print("dbc===L>${differenceInMinutes >= 59}");

      }
      // Get.snackbar('Alert', "'Retry after 6 hours'",
      //     backgroundColor: Colors.red.withOpacity(0.8),
      //     colorText: Colors.white);
    }

    cont.resendOtpCounter.value ++;

    // cont.resendOtpCounter.value = prefs.getBool(key)

    if(prefs.containsKey('sendOtpCounter')){
      Get.snackbar('Alert', "'Retry after 6 hours'",
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
      //print("dbc===L>${differenceInMinutes >= 59}");
    }else{
      print('counterValue: ${cont.resendOtpCounter.value}');
      if(cont.resendOtpCounter.value<=2){
        cont.sendOtp(params: params);
      }else{

        Get.snackbar('Alert', "'Retry after 6 hours'",
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white);
        print('currentTime${DateTime.now().millisecondsSinceEpoch}');
        await prefs.setBool('sendOtpCounter', true);
        await prefs.setInt('sendOtpTimestamp', DateTime.now().millisecondsSinceEpoch);
      }
    }
  }
}
