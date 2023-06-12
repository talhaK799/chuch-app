import 'package:url_launcher/url_launcher.dart';

dialCall(String phoneNo) async {
  String phone = phoneNo.replaceAll(new RegExp(r"\s+"), "");
  final Uri call = Uri(
    scheme: 'tel',
    path: phone,
    
  );
  print('Calling - $phone');
  await launchUrl(call);
}
