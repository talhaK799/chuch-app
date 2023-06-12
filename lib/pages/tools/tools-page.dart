import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/menu-item.dart';
import 'package:churchappenings/pages/tools/tools-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ToolsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<ToolsController>(
        init: ToolsController(),
        global: false,
        builder: (toolsController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navigateToWidget(),
                  SizedBox(height: 30),
                  Text(
                    'Facility',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildListMenu({required List<CMenuItem> items}) {
  return Column(
    children: items.map((item) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListTile(
          leading: FaIcon(item.icon),
          title: Text(item.title),
          trailing: Icon(Icons.arrow_right),
          onTap: () => item.action(),
        ),
      );
    }).toList(),
  );
}
