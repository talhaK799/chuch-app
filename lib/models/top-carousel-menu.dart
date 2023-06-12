import 'package:churchappenings/routes.dart';

class TopCarouselMenu {
  TopCarouselMenu({
    required this.title,
    required this.icon,
    required this.child,
    required this.id,
  });

  String title;
  String icon;
  List<Child> child;
  int id;
}

class Child {
  Child({
    required this.title,
    required this.icon,
    this.path = Routes.home,
  });

  String title;
  String icon;
  String path;
}
