import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

launchUrl(String url) async {
  print('Launching $url');
  if (await canLaunch(url)) {
    await launch(url);
    return true;
  } else {
    log('Could not launch url');
    return false;
    
  }
}
