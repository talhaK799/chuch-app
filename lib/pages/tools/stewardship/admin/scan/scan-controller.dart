import 'package:churchappenings/pages/tools/stewardship/admin/single/single-stewardship-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanController extends GetxController {
  QRViewController? controller;
  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      Get.to(SingleAdminStewardshipPage(),
          arguments: {"id": int.parse(result!.code!)});
      update();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
