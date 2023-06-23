import 'package:etoUser/controller/user_controller.dart';
import 'package:etoUser/enum/error_type.dart';
import 'package:etoUser/ui/widget/no_internet_widget.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewRegistrationScreen extends StatefulWidget {
  const NewRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<NewRegistrationScreen> createState() => _NewRegistrationScreenState();
}

class _NewRegistrationScreenState extends State<NewRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,resizeToAvoidBottomInset: false,
      body: GetX<UserController>(builder: (cont) {
        if (cont.error.value.errorType == ErrorType.internet) {
          return NoInternetWidget();
        }
        return Stack(alignment: Alignment.bottomCenter,
          children: [
            Align(alignment: Alignment.bottomCenter,
              child: Image.asset(AppImage.login3),),
            SizedBox(height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.07,),
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
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),
                  Text('Almost There!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
                  cusTextField(cont.firstNameController, 'Enter First Name',true, false),
                  cusTextField(cont.lastNameController, 'Enter Last Name',true, false),
                  cusTextField(cont.emailController, 'Email Address(Optional)',false, false),
                  cusTextField(cont.referralCodeController, 'Referral Code(Optional)',false, false),
                  cusTextField(cont.passwordController, 'Enter password', false, true),

                  continueButton(cont),
                  SizedBox(height: MediaQuery.of(context).size.height*0.5,)
                ],),
              ),
            ),
          ],
        );
      }));
  }

  Widget cusTextField(textEdController, hintTxt, firstLetterCapital, isObscured){
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),child:
    Container(height: 50,width: double.infinity,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              color: Colors.black26,
              blurRadius: 3,
            )
          ]),child: TextField(obscureText: isObscured,controller: textEdController,
        textCapitalization: firstLetterCapital? TextCapitalization.sentences : TextCapitalization.none,decoration:
      InputDecoration(border: InputBorder.none,hintText:
      hintTxt,hintStyle: TextStyle(fontSize: 18),contentPadding:
      EdgeInsets.only(top: 10,left: 10)),),),);
  }

  Widget continueButton(cont){
    return GestureDetector(onTap: (){
      cont.updateProfile(1);
    },
      child: Padding(
        padding: EdgeInsets.only(top: 20,bottom: MediaQuery.of(context).size.height*0.15),
        child: Container(height: 55, width: MediaQuery
            .of(context)
            .size
            .width * 0.7, decoration:
        BoxDecoration(color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(30)), child:
        Align(alignment: Alignment.center,
          child: Text('Continue', style: TextStyle(
              color: Colors.white, fontSize: 16.h,fontWeight: FontWeight.w700),),),),
      ),
    );
  }
}
