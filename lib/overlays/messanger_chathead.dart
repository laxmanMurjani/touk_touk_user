import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:etoUser/ui/home_screen.dart';
import 'package:etoUser/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';

class MessangerChatHead extends StatefulWidget {
  const MessangerChatHead({Key? key}) : super(key: key);

  @override
  State<MessangerChatHead> createState() => _MessangerChatHeadState();
}

class _MessangerChatHeadState extends State<MessangerChatHead> {
  Color color = const Color(0xFFFFFFFF);
  BoxShape _currentShape = BoxShape.circle;
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? messageFromOverlay;

  @override
  void initState() {
    super.initState();
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameOverlay,
    );
    log("$res : HOME");
    _receivePort.listen((message) {
      log("message from UI: $message");
      setState(() {
        messageFromOverlay = 'message from UI: $message';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      child: GestureDetector(
        onTap: () async {
          Get.to(()=> HomeScreen());
          // if (_currentShape == BoxShape.rectangle) {
          //   await FlutterOverlayWindow.resizeOverlay(50, 100);
          //   setState(() {
          //     _currentShape = BoxShape.circle;
          //   });
          // } else {
          //   await FlutterOverlayWindow.resizeOverlay(
          //     50, 50
          //     // WindowSize.matchParent,
          //     // WindowSize.matchParent,
          //   );
          //   setState(() {
          //     _currentShape = BoxShape.rectangle;
          //   });
          // }
        },
        child: Container(height: 50,width: 50,alignment: Alignment.center,margin: EdgeInsets.all(30),
          decoration: BoxDecoration(shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage(AppImage.logoMain,),),),
        ),
      ),
    );
  }
}
