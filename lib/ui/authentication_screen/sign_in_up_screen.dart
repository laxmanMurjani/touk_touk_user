import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/ui/authentication_screen/login_screen.dart';
import 'package:etoUser/ui/authentication_screen/sign_up_screen.dart';
import 'package:etoUser/ui/widget/custom_button.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../widget/custom_text_filed.dart';

class SignInUpScreen extends StatefulWidget {
  const SignInUpScreen({Key? key}) : super(key: key);

  @override
  State<SignInUpScreen> createState() => _SignInUpScreenState();
}

class _SignInUpScreenState extends State<SignInUpScreen>
    with SingleTickerProviderStateMixin {
  final UserController _userController = Get.find();
  CarouselController? controller;
  List images = [
    AppImage.walkthroughFirst,
    AppImage.walkthrough3,
    AppImage.walkthrough2,
  ];
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly'
    ],
    signInOption: SignInOption.standard,
    // clientId: AppString.googleSignInServerClientId,
    // hostedDomain: "predictive-host-314811.firebaseapp.com"
  );

  @override
  void initState() {
    super.initState();
    _userController.clearFormData();
    _userController.isShowLogin.value = false;
    _userController.currentCarouselSliderPosition.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        if (_userController.isShowLogin.value) {
          _userController.isShowLogin.value = false;
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetX<UserController>(builder: (cont) {
          return

              // Stack(children: <Widget>[
              //   new Column(
              //     // mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         height: MediaQuery.of(context).size.height * 0.4,
              //         width: double.infinity,
              //         // decoration: BoxDecoration(
              //         //   color: AppColors.primaryColor,
              //         //   borderRadius: BorderRadius.only(
              //         //       bottomRight: Radius.elliptical(240, 100),
              //         //       bottomLeft: Radius.elliptical(240, 100)),
              //         //   // borderRadius: BorderRadius.only(
              //         //   //     bottomRight: Radius.circular(100.0),
              //         //   //     bottomLeft: Radius.circular(100.0)),
              //         // ),
              //         child: Image.asset(
              //           'assets/images/top_home.png',
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       Flexible(fit: FlexFit.tight, child: SizedBox()),
              //       Container(
              //         height: MediaQuery.of(context).size.height * 0.46,
              //         width: double.infinity,
              //         child: Image.asset(
              //           'assets/images/bottom_home.png',
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ],
              //   ),
              //   new Container(
              //     alignment: Alignment.center,
              //     padding: new EdgeInsets.only(right: 40.0, left: 40.0, top: 50),
              //     child: new Container(
              //         // height: MediaQuery.of(context).,
              //         width: MediaQuery.of(context).size.width,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               'log_in'.tr,
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 24.sp,
              //                 fontWeight: FontWeight.w800,
              //               ),
              //             ),
              //             SizedBox(height: 30.h),
              //             Row(
              //               children: [
              //                 CountryCodePicker(
              //                   onChanged: (CountryCode countryCode) {
              //                     print("  ==>  ${countryCode.dialCode}");
              //                     if (countryCode.dialCode != null) {
              //                       cont.countryCode = countryCode.dialCode!;
              //                     }
              //                   },
              //                   initialSelection: 'IN',
              //                   favorite: ['+91', 'IN'],
              //                   countryFilter: ['IT', 'FR', 'IN'],
              //                   showFlagDialog: true,
              //                   // barrierColor: Colors.white,
              //                   // boxDecoration: BoxDecoration(
              //                   //   border: Border.all(width: 1.0),
              //                   //   borderRadius:
              //                   //       BorderRadius.all(Radius.circular(5.0) //
              //                   //           ),
              //                   // ),
              //                   comparator: (a, b) =>
              //                       b.name!.compareTo(a.name.toString()),
              //                   //Get the country information relevant to the initial selection
              //                   onInit: (code) => print(
              //                       "on init ${code!.name} ${code.dialCode} ${code.name}"),
              //                 ),
              //                 SizedBox(width: 5.w),
              //                 Expanded(
              //                   flex: 2,
              //                   child: CustomTextFiled(
              //                     controller: cont.phoneNumberController,
              //                     label: "phone".tr,
              //                     hint: "phone".tr,
              //                     inputType: TextInputType.phone,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 20.h),
              //             CustomButton(
              //               text: "Continue",
              //               onTap: () {
              //                 cont.isShowLogin.value = true;
              //                 // cont.registerUser();
              //                 // Get.to(() => HomeScreen());
              //               },
              //             ),
              //             SizedBox(height: 25.h),
              //             Text('Or'),
              //             SizedBox(height: 25.h),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [
              //                 InkWell(
              //                   onTap: _faceBookLogin,
              //                   child: Container(
              //                     width: 50.w,
              //                     height: 50.w,
              //                     alignment: Alignment.center,
              //                     padding: EdgeInsets.all(5.w),
              //                     decoration: BoxDecoration(
              //                         color: Colors.white,
              //                         borderRadius: BorderRadius.circular(10.w),
              //                         boxShadow: [
              //                           AppBoxShadow.defaultShadow(),
              //                         ]),
              //                     child: Image.asset(
              //                       AppImage.facebook,
              //                       width: 32.w,
              //                       height: 32.w,
              //                     ),
              //                   ),
              //                 ),
              //                 InkWell(
              //                   onTap: _googleLogin,
              //                   child: Container(
              //                     width: 50.w,
              //                     height: 50.w,
              //                     alignment: Alignment.center,
              //                     padding: EdgeInsets.all(5.w),
              //                     decoration: BoxDecoration(
              //                         color: Colors.white,
              //                         borderRadius: BorderRadius.circular(10.w),
              //                         boxShadow: [
              //                           AppBoxShadow.defaultShadow(),
              //                         ]),
              //                     child: Image.asset(
              //                       AppImage.email,
              //                       width: 32.w,
              //                       height: 32.w,
              //                     ),
              //                   ),
              //                 ),
              //                 // if (Platform.isIOS)
              //                 InkWell(
              //                   onTap: _appleLogin,
              //                   child: Container(
              //                     width: 50.w,
              //                     height: 50.w,
              //                     padding: EdgeInsets.all(5.w),
              //                     alignment: Alignment.center,
              //                     decoration: BoxDecoration(
              //                         color: Colors.white,
              //                         borderRadius: BorderRadius.circular(10.w),
              //                         boxShadow: [
              //                           AppBoxShadow.defaultShadow(),
              //                         ]),
              //                     child: Image.asset(
              //                       AppImage.apple,
              //                       width: 32.w,
              //                       height: 32.w,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 50.h),
              //             RichText(
              //               text: TextSpan(
              //                 text: 'By Continuing, You Agree to our ',
              //                 children: <TextSpan>[
              //                   TextSpan(
              //                       text: '\nTerms of use ',
              //                       style: TextStyle(color: Color(0xff297FFF))),
              //                   TextSpan(
              //                     text: 'and',
              //                   ),
              //                   TextSpan(
              //                       text: '  Privacy Policy',
              //                       style: TextStyle(color: Color(0xff297FFF))),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         )),
              //   )
              // ]);

              Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    AppImage.loginBackground,
                    width: double.infinity,
                    height: _size.height * 0.8,
                    fit: BoxFit.cover,
                  )),
              Column(
                children: [
                  Image.asset(
                    AppImage.logo1,
                    width: _size.width * 0.4,
                    height: _size.height * 0.4,
                    // fit: BoxFit.contai n,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: cont.isShowLogin.value
                            ? LoginScreen()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(40.w))),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20.h),
                                        CarouselSlider(
                                          carouselController: controller,
                                          items: List.generate(
                                            3,
                                            (index) => Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Image.asset(
                                                      images[index],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Text(
                                                    "check_fare".tr,
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Text(
                                                    "Lorem Ipsum is simply dummy text of the printing and "
                                                    "typesetting industry. Lorem Ipsum has been the industry's "
                                                    "standard dummy",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          options: CarouselOptions(
                                            onPageChanged: (int,
                                                CarouselPageChangedReason) {
                                              _userController
                                                  .currentCarouselSliderPosition
                                                  .value = int;
                                            },
                                            height: 165.h,
                                            enlargeCenterPage: true,
                                            autoPlay: true,
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enableInfiniteScroll: true,
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            viewportFraction: 0.9,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              3,
                                              (index) => _userController
                                                          .currentCarouselSliderPosition
                                                          .value ==
                                                      index
                                                  ? _selectedDot()
                                                  : _unSelectedDot()),
                                        ),
                                        SizedBox(height: 30.h),
                                        CustomButton(
                                            text: "log_in".tr,
                                            bgColor: Colors.white,
                                            textColor: AppColors.primaryColor,
                                            onTap: () {
                                              Get.to(() => LoginScreen());
                                              // _showLoginScreen();
                                              // cont.isShowLogin.value = true;
                                            }),
                                        SizedBox(height: 10.h),
                                        CustomButton(
                                          onTap: () {
                                            Get.to(() => SignUpScreen());
                                          },
                                          text: "register".tr,
                                        ),
                                        SizedBox(height: 20.h),
                                        // Text(
                                        //   "Or_continue_with".tr,
                                        //   style: TextStyle(
                                        //     fontSize: 12.sp,
                                        //     color: AppColors.lightGray,
                                        //   ),
                                        // ),
                                        // SizedBox(height: 5.h),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceEvenly,
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
                                        //             borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     10.w),
                                        //             boxShadow: [
                                        //               AppBoxShadow
                                        //                   .defaultShadow(),
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
                                        //             borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     10.w),
                                        //             boxShadow: [
                                        //               AppBoxShadow
                                        //                   .defaultShadow(),
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
                                        //               borderRadius:
                                        //                   BorderRadius.circular(
                                        //                       10.w),
                                        //               boxShadow: [
                                        //                 AppBoxShadow
                                        //                     .defaultShadow(),
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
                                        // SizedBox(height: 20.h),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _selectedDot() {
    return Container(
      width: 15.w,
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 5.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(5.w),
      ),
    );
  }

  Widget _unSelectedDot() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 5.w,
      height: 5.w,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(5.w),
      ),
    );
  }

  void _showLoginScreen() {
    showBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return LoginScreen();
        });
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
          _userController.loginWithFacebook(
              accessToken: "${result.accessToken?.token ?? ""}");
          break;

        case LoginStatus.failed:
          Get.snackbar("Alert", result.message!,
              backgroundColor: Colors.redAccent.withOpacity(0.8),
              colorText: Colors.white);
          // _userController.showError(msg: result.message ?? "");
          break;
        case LoginStatus.cancelled:
          Get.snackbar("Alert", result.message!,
              backgroundColor: Colors.redAccent.withOpacity(0.8),
              colorText: Colors.white);
          // _userController.showError(msg: result.message ?? "");
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
      Get.snackbar("Alert", e.message,
          backgroundColor: Colors.redAccent.withOpacity(0.8),
          colorText: Colors.white);
    } catch (e) {
      // _userController.showError(msg: "$e");
      Get.snackbar("Alert", "$e",
          backgroundColor: Colors.redAccent.withOpacity(0.8),
          colorText: Colors.white);
    }
  }

  Future<void> _googleLogin() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
    GoogleSignInAccount? _googleSignAccount = await _googleSignIn.signIn();

    if (_googleSignAccount != null) {
      GoogleSignInAuthentication? googleSignInAuthentication =
          await _googleSignAccount.authentication;
      log("GoogleSignInAuthentication   ==>    ${googleSignInAuthentication.accessToken}");
      _userController.loginWithGoogle(
          accessToken: googleSignInAuthentication.accessToken ?? "");
    }
  }
}
