import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/create/responsibility/responsibility-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsibilityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<ResponsibilityController>(
        init: ResponsibilityController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _.addGroup();
                            },
                            child: Text(
                              'Add Group',
                              style: TextStyle(
                                color: redColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          GestureDetector(
                            onTap: () {
                              _.onSave();
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: redColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Responsibilities',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Bulletin - ' + _.bulletinName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: _.responsibility
                        .asMap()
                        .map((index, item) {
                          List<Widget> members = [];
                          for (var i = 0; i < item["members"].length; i++) {
                            members.add(
                              ListTile(
                                title: Text(
                                  item["members"][i]["member"],
                                ),
                                subtitle: Text(
                                  item["members"][i]["assignedAs"],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    _.removeMember(index, i);
                                  },
                                ),
                              ),
                            );
                          }

                          return MapEntry(
                            index,
                            Container(
                              padding: EdgeInsets.only(bottom: 20, top: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          initialValue: item["groupName"],
                                          autocorrect: true,
                                          decoration: InputDecoration(
                                            labelText: 'GroupName',
                                            border: OutlineInputBorder(),
                                          ),
                                          onChanged: (value) {
                                            _.onChangeGroupName(index, value);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          _.removeGroup(index);
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  item["members"].length > 0
                                      ? Column(children: members)
                                      : Container(),
                                  SizedBox(height: 10),
                                  Column(children: [
                                    TextFormField(
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: _.nameController,
                                    ),
                                    TextFormField(
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        labelText: 'Assign as',
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: _.assignedController,
                                    ),
                                  ]),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _.addMemberRow(index);
                                    },
                                    child: Text(
                                      'Add Member',
                                      style: TextStyle(
                                        color: redColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Column(
//                                     children: item["members"]
//                                         .asMap()
//                                         .map(
//                                           (memberIndex, memberItem) => MapEntry(
//                                             memberIndex,
//                                             Container(
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Expanded(
//                                                     child: Column(
//                                                       children: [
//                                                         TextFormField(
//                                                           initialValue:
//                                                               memberItem[
//                                                                   "member"],
//                                                           autocorrect: true,
//                                                           decoration:
//                                                               InputDecoration(
//                                                             labelText: 'Name',
//                                                             border:
//                                                                 OutlineInputBorder(),
//                                                           ),
//                                                           onChanged: (value) {
//                                                             _.onChangeMemberName(
//                                                               index,
//                                                               memberIndex,
//                                                               value,
//                                                             );
//                                                           },
//                                                         ),
//                                                         TextFormField(
//                                                           initialValue:
//                                                               memberItem[
//                                                                   "assignedAs"],
//                                                           autocorrect: true,
//                                                           decoration:
//                                                               InputDecoration(
//                                                             labelText:
//                                                                 'Assign as',
//                                                             border:
//                                                                 OutlineInputBorder(),
//                                                           ),
//                                                           onChanged: (value) {
//                                                             _.onChangeMemberAssignment(
//                                                               index,
//                                                               memberIndex,
//                                                               value,
//                                                             );
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(width: 10),
//                                                   IconButton(
//                                                     icon: Icon(Icons.close),
//                                                     onPressed: () {
//                                                       _.removeMember(
//                                                           index, memberIndex);
//                                                     },
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                         .values
//                                         .toList(),
//                                   ),
