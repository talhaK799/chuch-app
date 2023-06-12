import 'package:url_launcher/url_launcher.dart';

launchMaps(double lat, double lng) async {
  String googleUrl = 'comgooglemaps://?center=$lat,$lng';
  String appleUrl = 'https://maps.apple.com/?q=$lat,$lng';
  print(appleUrl);
  print(googleUrl);
  if (await launchUrl(Uri.parse("comgooglemaps://"))) {
    print('launching com googleUrl');
    await launchUrl(Uri.parse(googleUrl));
  } else if (await launchUrl(Uri.parse(appleUrl))) {
    print('launching apple url');
    await launch(appleUrl, forceSafariVC: false);
  } else {
    throw 'Could not launch url';
  }
}
