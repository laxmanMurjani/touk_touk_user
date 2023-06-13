import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/util/app_constant.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? text;
  Widget? leading;

   CustomAppBar({this.text, this.leading});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final UserController _userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 20.w),
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 6.r,
              offset: Offset(0, 3.h)),
        ],
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(38.r),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImage.backArrow,
                  width: 25,
                  height: 25,
                  fit: BoxFit.contain,
                )),
            Text(
              widget.text ?? "",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            widget.leading ??
                SizedBox(
                  width: 25,
                )
          ],
        ),
      ),
    );
  }
}
