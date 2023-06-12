import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/search/visit-church/visit-church-controller.dart';
import 'package:churchappenings/widgets/bottom-action-button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VisitChurchPage extends StatelessWidget {
  const VisitChurchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<VisitChurchController>(
        init: VisitChurchController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
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
                        SizedBox(height: 10),
                        Text(
                          'Visitation Request',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _.churchName,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 30),
                        _.haveUpcomingVisit
                            ? Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: redColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: double.infinity,
                                    height: 400,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Scheduled Visit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            height: 1.5,
                                          ),
                                        ),
                                        Text(
                                          _.dateTimeStrings[0] +
                                              ' - ' +
                                              _.dateTimeStrings[1],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  bulletinsFeed(_),
                                ],
                              )
                            : Column(
                                children: [
                                  TextFormField(
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _.phoneNumberController,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    autocorrect: true,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      border: OutlineInputBorder(),
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _.ageController,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      labelText: 'Country',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _.countryController,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _.stateController,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      labelText: 'Church Affiliation',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _.churchAffliationController,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    maxLines: 3,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      labelText: 'Purpose of visit',
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: _.purposeController,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      labelText: 'Date of visit',
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _.openDatePicker(context);
                                        },
                                        icon: Icon(
                                          Icons.calendar_today,
                                        ),
                                      ),
                                    ),
                                    controller: _.dateController,
                                    readOnly: true,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      labelText: 'Time of visit',
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _.openTimePicker(context);
                                        },
                                        icon: Icon(
                                          Icons.timer,
                                        ),
                                      ),
                                    ),
                                    controller: _.timeController,
                                    readOnly: true,
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: redColor,
                                        value: _.requestCallFromPastor,
                                        onChanged: (bool? value) {
                                          _.handleChangeRequestCallFromPastor(
                                              value);
                                        },
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              'Request call from pastor',
                                              style: TextStyle(fontSize: 17.0),
                                            ),
                                            Text(
                                              'If selected, church pastor will call you.',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
              _.haveUpcomingVisit
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        _.createVisitationRequest();
                      },
                      child: buildBottomActionButton('Send visitation request'),
                    ),
            ],
          );
        },
      ),
    );
  }
}

Container bulletinsFeed(VisitChurchController _) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Upcoming Bulletins",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: _.bulletins.map<Widget>(
            (bulletin) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(bulletin["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bulletin["name"],
                        style: TextStyle(
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'September 10',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    ),
  );
}
