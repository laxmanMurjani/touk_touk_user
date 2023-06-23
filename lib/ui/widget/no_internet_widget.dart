import 'package:etoUser/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetWidget extends StatelessWidget {
  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container();
    //   Center(
    //   child: Container(height: MediaQuery.of(context).size.height*0.25,
    //   width: MediaQuery.of(context).size.width*0.9,decoration: BoxDecoration(color:
    //     Colors.white, borderRadius: BorderRadius.circular(20)),child: Align(alignment:
    //       Alignment.center,child: Text(_homeController.connectionStatus.toString(),style: TextStyle(
    //       fontSize: 20,
    //     ),textAlign: TextAlign.center,),),),
    // );
  }
}
