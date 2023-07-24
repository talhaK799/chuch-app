import 'dart:developer';

import 'package:churchappenings/pages/tools/member-transfer/member-transfer-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/church.dart';

class MemberTransferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<MemberTransferController>(
        init: MemberTransferController(),
        global: false,
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navigateToWidget(),
                  SizedBox(height: 10),
                  Text(
                    'Transfer Church',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'In ultricies sodales tortor, non laoreet nisl porta in. Integer imperdiet venenatis elit, eu tincidunt magna ultrices quis. Praesent porta sem vitae ultrices fermentum.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    hint: Text('Select a country'),
                    value: _.selectedCountry,
                    onChanged: (newValue) {
                      _.selectedCountry = newValue!;
                      if (_.selectedCountry != null) {
                        _.getFacilities();
                      }
                      log("Drop Down Value: ${_.selectedCountry}");
                    },
                    items: _.countries.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) {
                        _.filteredChurchList(value);
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  _.serached == false
                      ? serachWidget(_, churchList: _.churchList)
                      : serachWidget(_, churchList: _.serachList),
                  // Text("aa ${_.facilities.address}"),
                  // TextFormField(
                  //   autocorrect: true,
                  //   decoration: InputDecoration(
                  //     labelText: 'Seach Church Name',
                  //     border: OutlineInputBorder(),
                  //     suffixIcon: IconButton(
                  //       icon: Icon(Icons.send),
                  //       onPressed: () {
                  //         _.onSubmit();
                  //       },
                  //     ),
                  //   ),
                  //   controller: _.nameController,
                  // ),
                  // Text(_.facilities)
                  SizedBox(height: 20),
                  Column(
                    children: _.churches.map<Widget>((item) {
                      return ListTile(
                        title: Text(item["name"]),
                        subtitle: Text(item["address"]),
                        trailing: IconButton(
                          onPressed: () {
                            _.memberInvite(item["id"]);
                          },
                          icon: Icon(Icons.arrow_right),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container serachWidget(MemberTransferController _,
      {List<Church>? churchList}) {
    return Container(
      // width: 200,
      // height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: churchList!.length,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        churchList[index].name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'Address:',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        churchList[index].address,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text('created_at:'),
                    SizedBox(width: 10),
                    Text(
                      churchList[index].createdAt.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
