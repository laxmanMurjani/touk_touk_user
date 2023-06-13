import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:etoUser/controller/home_controller.dart';
import 'package:etoUser/ui/bookfor_someone_else.dart';
import 'package:etoUser/ui/dialog/reason_for_cancelling_dialog.dart';
import 'package:etoUser/ui/widget/custom_button.dart';
import 'package:etoUser/util/app_constant.dart';

class FindingDriverDialog extends StatefulWidget {
  const FindingDriverDialog({Key? key}) : super(key: key);

  @override
  State<FindingDriverDialog> createState() => _FindingDriverDialogState();
}

class _FindingDriverDialogState extends State<FindingDriverDialog> {

  final HomeController _homeController = Get.find();
  int _counter = 60;
  late Timer _timer;

  void _startTimer() {
    _counter = int.parse(_homeController.checkRequestResponseModel.value.provider_select_timeout);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter--;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0x705C5C5C)),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(0.0)),
            ),
            child: Column(
              children: [
                Divider(
                  thickness: 2,
                  indent: MediaQuery.of(context).size.width * 0.32,
                  endIndent: MediaQuery.of(context).size.width * 0.32,
                ),
                SizedBox(height: 15.h),
                Text(
                  "You_deserve_the_best_Connecting_you_with_the_best_driver".tr,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                // Container(
                //   // margin: EdgeInsets.symmetric(vertical: 20),
                //   width: 300,
                //   height: 18,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.all(Radius.circular(40)),
                //     child: LinearProgressIndicator(
                //       backgroundColor: Colors.grey,
                //       // color: ,
                //       valueColor: AlwaysStoppedAnimation<Color>(
                //         Colors.black,
                //       ),
                //       // minHeight: 18,
                //       // value: 0.75,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Text("${_counter.toString()} "+"Sec".tr,
                  style:
                  TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: AppColors.splashGreenBg),),
                SizedBox(
                  height: 5,
                ),
                Image.asset(
                  AppImage.taxi,
                  height: 110,
                  width: 110,
                  fit: BoxFit.contain,
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // TweenAnimationBuilder<Duration>(
                //     duration: Duration(minutes: 20),
                //     tween:
                //         Tween(begin: Duration(minutes: 20), end: Duration.zero),
                //     onEnd: () {
                //       print('Timer ended');
                //     },
                //     builder:
                //         (BuildContext context, Duration value, Widget? child) {
                //       final minutes = value.inMinutes;
                //       final seconds = value.inSeconds % 60;
                //       return Padding(
                //           padding: const EdgeInsets.symmetric(vertical: 5),
                //           child: Text('Drop off by $minutes:$seconds',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                   color: AppColors.primaryColor,
                //                   // fontWeight: FontWeight.w500,
                //                   fontSize: 14)));
                //     }),
                // Text(
                //   'Drop off by 19:50',
                //   style: TextStyle(
                //     fontSize: 16.sp,
                //   ),
                // ),
                SizedBox(
                  height: 5,
                ),
                (_homeController.checkRequestResponseModel.value.data.first.bkd_for_reqid != null &&
                    _homeController.checkRequestResponseModel.value.data.first.breakdown == 0
                ) ? SizedBox() :  GestureDetector(
                  onTap: () {
                    setState(() {
                      isBookForSomeOne = false;
                    });
                    Get.bottomSheet(
                      ReasonForCancelling(),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20) // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.grey,
                        //       blurRadius: 3)
                        // ],
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          "cancel".tr,
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.sp,fontWeight: FontWeight.w500),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
class FindingParcleDialog extends StatefulWidget {
  const FindingParcleDialog({Key? key}) : super(key: key);

  @override
  State<FindingParcleDialog> createState() => _FindingParcleDialogState();
}

class _FindingParcleDialogState extends State<FindingParcleDialog> {

  final HomeController _homeController = Get.find();
  int _counter = 60;
  late Timer _timer;

  void _startTimer() {
    _counter = int.parse(_homeController.checkRequestResponseModel.value.provider_select_timeout);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter--;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0x705C5C5C)),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.47,
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0.r),
                  bottomRight: Radius.circular(0.0),
                  topLeft: Radius.circular(40.0.r),
                  bottomLeft: Radius.circular(0.0)),
            ),
            child: Column(
              children: [
                // Divider(
                //   thickness: 2,
                //   indent: MediaQuery.of(context).size.width * 0.32,
                //   endIndent: MediaQuery.of(context).size.width * 0.32,
                // ),
                SizedBox(height: 15.h),
                Text(
                  "you_deserve_best_driver".tr,
                  style:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 20),
                  width: 273.w,
                  height: 18.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      // color: ,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                      // minHeight: 18,
                      // value: 0.75,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text("${_counter.toString()} "+"Sec".tr,
                  style:
                  TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: AppColors.splashGreenBg),),
                SizedBox(
                  height: 5,
                ),
                Container(
                    height: 80.h,
                    width: 80.w,
                    child: Image.asset(
                      AppImage.warehouse_icon,
                    )),
                // SizedBox(
                //   height: 10,
                // ),
                // TweenAnimationBuilder<Duration>(
                //     duration: Duration(minutes: 20),
                //     tween:
                //         Tween(begin: Duration(minutes: 20), end: Duration.zero),
                //     onEnd: () {
                //       print('Timer ended');
                //     },
                //     builder:
                //         (BuildContext context, Duration value, Widget? child) {
                //       final minutes = value.inMinutes;
                //       final seconds = value.inSeconds % 60;
                //       return Padding(
                //           padding: const EdgeInsets.symmetric(vertical: 5),
                //           child: Text('Drop off by $minutes:$seconds',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                   color: AppColors.primaryColor,
                //                   // fontWeight: FontWeight.bold,
                //                   fontSize: 14)));
                //     }),
                // Text(
                //   'Drop off by 19:50',
                //   style: TextStyle(
                //     fontSize: 16.sp,
                //   ),
                // ),
                // SizedBox(
                //   height: 13.h,
                // ),
                Text("drop_off_by".tr,
                  style:
                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 13.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      ReasonForCancelling(),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20.r) // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.grey,
                      //       blurRadius: 3)
                      // ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "cancel".tr,
                          style:
                          TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        SizedBox(width: 20),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}