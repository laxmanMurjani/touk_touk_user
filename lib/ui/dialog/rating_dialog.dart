import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:etoUser/api/api.dart';
import 'package:etoUser/controller/base_controller.dart';
import 'package:etoUser/controller/home_controller.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/enum/error_type.dart';
import 'package:etoUser/model/check_request_response_model.dart';
import 'package:etoUser/ui/Locationscreen.dart';
import 'package:etoUser/ui/dialog/rating_feedback_dialog.dart';
import 'package:etoUser/ui/home_screen.dart';
import 'package:etoUser/ui/widget/custom_button.dart';
import 'package:etoUser/ui/widget/custom_fade_in_image.dart';
import 'package:etoUser/ui/widget/no_internet_widget.dart';
import 'package:etoUser/util/app_constant.dart';

class RatingDialog extends StatefulWidget {
  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final UserController userController = Get.find();
  final BaseController _baseController = BaseController();
  final TextEditingController _commentController = TextEditingController();
  double _rating = 5;
  final HomeController _homeController = Get.find();
  String? imageUrl;
  String? firstname;
  String? lastname;
  String? serviceTypeName;
  String? serviceTypeNumber;
  String? rating;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState

    print(
        "llll===>${_homeController.checkRequestResponseModel.value.fadeedback_count}");
    getData();
    if (_homeController.checkRequestResponseModel.value.fadeedback_count! > 3 &&
        _homeController.checkRequestResponseModel.value.feedback_check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
         await _show4thFeedbackDialog();
      });
    }
    super.initState();
  }

  Future<void> _show4thFeedbackDialog() async {
    return Get.defaultDialog(
        title: "Tell_us_your_experience_with_touk_touk".tr,
        titleStyle: TextStyle(
            fontSize: 17,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500),
        content: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 150,
          // margin:
          //     EdgeInsets.symmetric(horizontal: 25.w, vertical: 10),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
          child: TextFormField(
            maxLines: 8,
            controller: userController.giveFeedbackDescriptionController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Description is required';
              }
              return null;
            },
            style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Write_something".tr,
              hintStyle: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 50,
              width: 130,
              // margin: EdgeInsets.symmetric(horizontal: 50),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.gray.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8)),
              child: Text("Skip".tr,
                  style: TextStyle(
                      fontSize: 14.h,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          InkWell(
            onTap: () async {
              print("isDriverShowisDriverShow===>${isDriverShow}");

              if(userController.giveFeedbackDescriptionController.text.isEmpty){
                Get.snackbar("Alert", "Please enter your Feedback",
                    backgroundColor: Colors.redAccent.withOpacity(0.8),
                    colorText: Colors.white);
                return ;
              }

                userController.givenFeedback("ETO Feedback",
                    userController.giveFeedbackDescriptionController.text);
                Get.back();
                await _homeController.getDriverMarkerData(
                    updateData: () => setState(() {}));
                setState(() {
                  isDriverShow = true;
                });

            },
            child: Container(
              height: 50,
              width: 130,
              // margin: EdgeInsets.symmetric(horizontal: 50),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Text("submit".tr,
                  style: TextStyle(
                      fontSize: 14.h,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
        titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        backgroundColor: AppColors.white);
  }

  getData() async {
    await _homeController.checkRequest();
    setState(() {
      imageUrl = _homeController
          .checkRequestResponseModel.value.data[0].provider!.avatar!;
      firstname = _homeController
          .checkRequestResponseModel.value.data[0].provider!.firstName!;
      lastname = _homeController
          .checkRequestResponseModel.value.data[0].provider!.lastName!;
      serviceTypeName = _homeController
          .checkRequestResponseModel.value.data[0].serviceType!.name!;
      serviceTypeNumber = _homeController.checkRequestResponseModel.value
          .data[0].providerService!.serviceNumber!;
      rating = _homeController
          .checkRequestResponseModel.value.data[0].provider!.rating!;
    });
    print("rating===> $rating");
    print("serviceTypeNumber===> $serviceTypeNumber");
    print("serviceTypeName===> $serviceTypeName");
    print("lastname===> $lastname");
    print("firstname===> $firstname");
    print("imageUrl===> $imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
              ),
              child: GetX<HomeController>(builder: (cont) {
                if (cont.error.value.errorType == ErrorType.internet) {
                  return NoInternetWidget();
                }

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'rate_driver'.tr,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),

                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.gray
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              width: 60.w,
                              height: 60.w,
                              clipBehavior: Clip.antiAlias,
                              //padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(
                                      40.r),
                                  boxShadow: [
                                    AppBoxShadow
                                        .defaultShadow()
                                  ]),
                              child:  cont
                                  .checkRequestResponseModel
                                  .value
                                  .data.isEmpty
                                  ? Image.asset(
                                  AppImage.profilePic)
                                  : CustomFadeInImage(
                                url:
                                "${ApiUrl.baseImageUrl}${cont.checkRequestResponseModel.value.data[0].provider?.avatar}",
                                placeHolder:
                                AppImage.logoMain,
                                fit: BoxFit.contain,

                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  // Divider(),
                                  Row(children: [
                                    cont.checkRequestResponseModel.value.data.isEmpty ? Text("") : Text(
                                      "${cont.checkRequestResponseModel.value.data[0].provider?.firstName ?? ""} ${cont.checkRequestResponseModel.value.data[0].provider?.lastName ?? ""}",
                                      style: TextStyle(
                                        color: AppColors
                                            .primaryColor,
                                        fontSize: 13.sp,
                                        fontWeight:
                                        FontWeight.w500,
                                      ),
                                    ),
                                    cont.checkRequestResponseModel.value.driverVerifyCheck == null? SizedBox() :
                                    cont.checkRequestResponseModel.value.driverVerifyCheck == 'verified'?
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Image.asset(AppImage.verifiedIcon,height: 14.h,width: 14.h,),
                                    ) : SizedBox()
                                  ],),

                                  SizedBox(height: 1.h),
                                  cont.checkRequestResponseModel.value.data.isEmpty?Text(""):  Text(
                                    "${cont.checkRequestResponseModel.value.data[0].serviceType?.name ?? ""}",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors
                                          .primaryColor,
                                      fontWeight:
                                      FontWeight.w500,
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     cont.checkRequestResponseModel.value.data.isEmpty ? Text(""):  Text(
                                  //       "${cont.checkRequestResponseModel.value.data[0].providerService?.car_camp_name ?? ""} - ${cont.checkRequestResponseModel.value.data[0].providerService?.car_color ?? ""}",
                                  //       style: TextStyle(
                                  //           fontSize: 10.sp,
                                  //           color: AppColors
                                  //               .primaryColor,
                                  //           fontWeight:
                                  //           FontWeight
                                  //               .w500),
                                  //     ),
                                  //   ],
                                  // ),
                                  cont.checkRequestResponseModel.value.data.isEmpty ? Text(""):  Text(
                                    "${cont.checkRequestResponseModel.value.data[0].providerService?.serviceNumber ?? ""}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors
                                          .primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            cont.checkRequestResponseModel.value.data.isEmpty ? Text(""):    Row(
                              children: [
                                Text(
                                  '${cont.checkRequestResponseModel.value.data[0].provider?.rating ?? "0"}',
                                  style: TextStyle(
                                      color: AppColors
                                          .primaryColor,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange.withOpacity(0.7),
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                cont
                                    .checkRequestResponseModel
                                    .value
                                    .data.isEmpty
                                    ? Image.asset(
                                    AppImage.logo1)
                                    : CustomFadeInImage(
                                  url:
                                  "${cont.checkRequestResponseModel.value.data[0].serviceType!.image}",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.contain,
                                  placeHolder:
                                  AppImage.logoMain,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15.h),
                      Text(
                        "how_is_your_driver?".tr,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        "please_rate_your_driver".tr,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: AppColors.primaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                          _rating = rating;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              await Get.to(RatingFeedbackDialog(
                                rating: _rating.toInt(),
                              ));
                            },
                            child: Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.bgColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              alignment: Alignment.center,
                              child: Text("feedback_for_the_driver".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      // TextButton(
                      //     onPressed: () {
                      //       print(
                      //           "_homeController.driverRating.value===> ${_homeController.driverRating.value}");
                      //       print(
                      //           "_homeController.etoRating.value===> ${_homeController.etoRating.value}");
                      //     },
                      //     child: Text("Data")),
                      InkWell(
                        onTap:
                            // (!_homeController.driverRating.value &&
                            //         !_homeController.etoRating.value)
                            //     ? () async {
                            //         print("enter 1");
                            //         await _homeController.providerRate(
                            //             rating: "5", comment: "null");
                            //         await _homeController.etoFeedback(
                            //             comment: "null");
                            //         _homeController.driverRating.value = false;
                            //         _homeController.etoRating.value = false;
                            //       }
                            //     : (!_homeController.driverRating.value ||
                            //             !_homeController.etoRating.value)
                            //         ? () async {
                            //             print("enter 2");
                            //             if (!_homeController.driverRating.value) {
                            //               print("enter 333");
                            //               await _homeController.providerRate(
                            //                   rating: "5", comment: "null");
                            //               _homeController.driverRating.value =
                            //                   false;
                            //               _homeController.etoRating.value = false;
                            //             } else {
                            //               print("enter 444");
                            //               await _homeController.etoFeedback(
                            //                   comment: "null");
                            //               _homeController.driverRating.value =
                            //                   false;
                            //               _homeController.etoRating.value = false;
                            //             }
                            //           }
                            //         :
                            () async {
                              setState(() {
                                isDriverShow = true;
                              });
                              await _homeController.getDriverMarkerData(
                                  updateData: () => setState(() {}));
                          // _homeController.driverRating.value = false;
                          // _homeController.etoRating.value = false;
                          String? msg = await _homeController.providerRate(
                              rating: "5", comment: "null");
                          Get.back();


                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          margin: EdgeInsets.symmetric(horizontal: 35),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            "continue".tr,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  double _strToDouble({required String s}) {
    double rating = 0;
    try {
      rating = double.parse(s);
    } catch (e) {
      rating = 0;
    }
    return rating;
  }
}
