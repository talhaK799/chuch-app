// ignore_for_file: unnecessary_new

import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';

class InternetError {
  static final _instance = InternetError.internal();
  factory InternetError() => _instance;
  InternetError.internal();

  static OverlayEntry? entry;

  void show(context, page) => addOverlayEntry(context);
  void hide() => removeOverlay();

  bool get isShow => entry != null;

  addOverlayEntry(context) {
    if (entry != null) return;
    entry = new OverlayEntry(builder: (BuildContext context) {
      return LayoutBuilder(builder: (_, BoxConstraints constraints) {
        return new Material(
          color: primaryWhite,
          child: new Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // new Image.asset(
                //   'assets/gif/no-internet.gif',
                //   height: 250,
                // ),
                // const SizedBox(
                //   height: 50,
                // ),
                const Text(
                  "Please check your internet connection!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(50),
                  // ),
                  height: 50,
                  width: 200,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.1),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: () {
                      removeOverlay();
                    },
                    child: const Text(
                      "Okay",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });

    addoverlay(entry!, context);
  }

  addoverlay(OverlayEntry entry, context) async {
    Overlay.of(context).insert(entry);
  }

  removeOverlay() {
    entry?.remove();
    entry = null;
  }
}
