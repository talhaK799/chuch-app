import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'scan-controller.dart';

class ScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ScanController>(
        init: ScanController(),
        global: false,
        builder: (_) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: _.qrKey,
                  onQRViewCreated: _.onQRViewCreated,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
