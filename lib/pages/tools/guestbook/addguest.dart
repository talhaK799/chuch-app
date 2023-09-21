import 'dart:developer';

import 'package:churchappenings/api/guest_chat_api.dart';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/add_guestbook.dart';
import 'package:churchappenings/pages/tools/guestbook/addguest_controller.dart';
import 'package:churchappenings/utils/date-picker.dart';
import 'package:churchappenings/widgets/custom_dropdown_form_field.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class AddGuestBook extends StatefulWidget {
  const AddGuestBook({Key? key}) : super(key: key);

  @override
  State<AddGuestBook> createState() => _AddGuestBookState();
}

class _AddGuestBookState extends State<AddGuestBook> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //  //  final facilityId = controller.selectedFacilityId;
  //   DateTime now = DateTime.now();
  //    final facilityId = int.parse(controller.selectedFacilityId?? "");
  //    log('kkkkkkkkkkkkkkkkkkkkk$facilityId');
  //   final result = GuestChatApi().addGuestApi(
  //     GuestBookInputModel(
  //         age: 10,
  //         churchAffiliation: "jjjj",
  //         country: "kkkkjjj",
  //         dateOfVisit: now.toString(),
  //         description: "kkkkkkkkkj",
  //         email: "jdjjdjdjjdjc",
  //         name: "kkkppp",
  //         phoneNo: "kkkkk",
  //         requestCall: false,
  //         state: now.toString(),
  //         requestedFacilityId: facilityId),
  //   );

  //   log('result  ${result}');
  //   super.initState();

  final controller = Get.put(AddGuestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: navigateToWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add Guest',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                CustomTextField(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    controller.addguestm.name = value;
                  },
                ),
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email.';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    controller.addguestm.email = value;
                  },
                ),
                CustomTextField(
                  labelText: 'Phone',
                  hintText: 'Enter your PhoneNo',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone no.';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    controller.addguestm.phoneNo = value;
                  },
                ),
                CustomTextField(
                  labelText: 'Church Affiliation',
                  hintText: 'Please enter church affiliation',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your church affiliation.';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    controller.addguestm.churchAffiliation = value;
                  },
                ),
                CustomDropdownField(
                  hint: 'Please select any ',
                  text: 'Requested Facility:',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your requested facility.';
                    }
                    return null;
                  },
                  hintText: '',
                  selectedValue: controller.selectedFacilityId,
                  onChanged: (v) {
                    controller.addguestm.requestedFacilityId =
                        int.parse(v ?? "");
                    log('message  ${controller.addguestm.requestedFacilityId}');
                    // controller.selectedFacilityId = v;
                  },
                  mitems: controller.facilities.map((dynamic option) {
                    final truncatedName =
                        controller.truncateText(option['name'], 20);
                    return DropdownMenuItem<String>(
                      value: option['id'].toString(),
                      child: Text(truncatedName),
                    );
                  }).toList(),
                ),
                CustomTextField(
                  labelText: 'Date of visit',
                  controller: controller.dateController,
                  hintText: ' Date of visit ${controller.dateController.text}',
                  readOnly: true,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(Icons.calendar_today),
                  onTap: () => controller.openDatePicker(context),
                  onChanged: (value) {
                    // DateTime now = DateTime.now();
                    // controller.addguestm.dateOfVisit = value.toString();
                    // log('message  ${controller.addguestm.dateOfVisit} ');
                  },
                ),
                CustomTextField(
                  readOnly: true,
                  labelText: 'Country',
                  hintText: 'Select your Country',
                  keyboardType: TextInputType.none,
                  prefixIcon: Center(
                    child: CountryListPick(
                      onChanged: (code) {
                        controller.addguestm.country = code!.code!;
                        setState(() {
                          //  countryController.text = code!.code!;
                        });
                      },
                      initialSelection: '+62',
                      useUiOverlay: true,
                    ),
                  ),
                ),
                CustomTextField(
                  labelText: 'State',
                  hintText: 'Enter your state',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your state.';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    controller.addguestm.state = value;
                  },
                ),
                CustomTextField(
                  labelText: 'Special Requests',
                  hintText: 'Enter any special requests',
                  maxLines: 3,
                  // controller: specialRequestsController,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    controller.addguestm.description = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.addGuests();
                      log('message done');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: redColor,
                    textStyle: TextStyle(fontSize: 20),
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  Widget? prefixIcon;
  bool readOnly;
  Function()? onTap;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    this.maxLines,
    this.onTap,
    this.controller,
    this.prefixIcon,
    this.readOnly = false,
    required this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onTap: onTap,
        autovalidateMode: AutovalidateMode.always,
        maxLines: maxLines,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
      ),
    );
  }
}
