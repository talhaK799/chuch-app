import 'package:churchappenings/widgets/bottom-action-button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create-stewardship-controller.dart';

class CreateStewardshipPage extends StatelessWidget {
  const CreateStewardshipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<CreateStewardshipController>(
        init: CreateStewardshipController(),
        global: true,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          List<Widget> formInputs = [];

          for (int i = 0; i < _.donationDetails.length; i++) {
            formInputs.add(
              Container(
                margin: EdgeInsets.only(bottom: 35),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_.donationDetails[i]["option"]),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autocorrect: true,
                      decoration: InputDecoration(),
                      initialValue: _.donationDetails[i]["value"] != null
                          ? _.donationDetails[i]["value"].toString()
                          : "",
                      onChanged: (value) {
                        _.onChangeField(i, value);
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navigateToWidget(),
                        SizedBox(height: 15),
                        Text(
                          'Donation Template',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Stewardship',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 50),
                        Column(
                          children: formInputs,
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: _.isDepartmental,
                              onChanged: (value) {
                                _.isDepartmental = !_.isDepartmental;
                                _.update();
                              },
                              side: BorderSide(width: 1),
                            ),
                            Text(
                              'Departmental Donations',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        ///
                        /// show deparments if user wants
                        ///
                        ///
                        _.isDepartmental
                            ? ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: _.departments.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Text("${_.departments[index].name}: "),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            autocorrect: true,
                                            decoration: InputDecoration(),
                                            onChanged: (value) {
                                              _.onChangeField(index, value);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                })
                            : Container(),

                        ///
                        /// Special causes
                        ///
                        ///
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: _.isSpecialCauses,
                              onChanged: (value) {
                                _.isSpecialCauses = !_.isSpecialCauses;
                                _.update();
                              },
                              side: BorderSide(width: 1),
                            ),
                            Text(
                              'Special Causes',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _.total.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print(_.paymentMethod);
                  _.onSubmit();
                },
                child: buildBottomActionButton('Next'),
              ),
            ],
          );
        },
      ),
    );
  }
}
