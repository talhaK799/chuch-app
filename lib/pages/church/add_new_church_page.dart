import 'dart:io';

import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/country_code.dart';
import 'package:churchappenings/pages/church/add_church_controller.dart';
import 'package:churchappenings/pages/google/google_map_page.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/widgets/custom_textform_field.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddNewChurchPage extends StatelessWidget {
  AddNewChurchPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddChurchController>(
      init: AddChurchController(),
      builder: (model) => ModalProgressHUD(
        inAsyncCall: model.isLoaded == true,
        child: Scaffold(
          appBar: transparentAppbar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      navigateToWidget(),
                      15.height,
                      Text("Church Details",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700)),
                      20.height,
                      CustomTextFormFeild(
                        labelText: "Church Name",
                        controller: model.nameController,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            model.addChurch.name = val;
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter church name";
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              model.uploadEventImage();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              // height: 35,
                              // width: 110,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Colors.black54)),
                              child: Center(
                                child: Text(
                                  "Church Logo",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8),
                                ),
                              ),
                            ),
                          ),
                          15.width,
                          model.imagePath != null
                              ? UnconstrainedBox(
                                  child: Image.file(
                                    File('${model.imagePath}'),
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      15.height,
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: DropdownButton<CountryAndDivision>(
                            borderRadius: BorderRadius.circular(8),
                            isExpanded: true,
                            hint: Text("Select Country"),
                            underline: Container(),
                            value: model.selectedCountryAndDivision,
                            items: model.countryAndDivisions
                                .map((CountryAndDivision countryAndDivision) {
                              return DropdownMenuItem<CountryAndDivision>(
                                value: countryAndDivision,
                                child: Text("${countryAndDivision.country}"),
                              );
                            }).toList(),
                            onChanged: (countryAndDivision) {
                              model.selectCountry(countryAndDivision!);
                            },
                          )),
                      15.height,
                      Text("Division"),
                      5.height,
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            "${model.selectedCountryAndDivision.devision}",
                            style: TextStyle(fontSize: 15),
                          )),
                      15.height,
                      CustomTextFormFeild(
                        labelText: "No Of Members",
                        controller: model.noOfMembersController,
                        type: TextInputType.number,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            model.addChurch.noOfMembers = int.parse(val);
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter No Of Members";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormFeild(
                        labelText: "Territory",
                        controller: model.territoryController,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            model.addChurch.territory = val;
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter territory";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormFeild(
                        labelText: "Address",
                        controller: model.addressController,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            model.searchPickUpLocation(val);
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter address";
                          }
                          return null;
                        },
                      ),
                      model.predictions.isEmpty
                          ? Container()
                          : Container(
                              color: Colors.white,
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      model.getSearchedLocationDetails(
                                          model.predictions[index].placeId!,
                                          index);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 6),
                                      child: Text(
                                          "${model.predictions[index].address}"),
                                    ),
                                  );
                                },
                                separatorBuilder: (conext, index) {
                                  return Divider(thickness: 2);
                                },
                                itemCount: model.predictions.length,
                              ),
                            ),
                      1.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              model.addressController.text =
                                  await Get.to(() => SelectLocation()) ?? '';
                            },
                            child: Container(
                              // height: 38,
                              // width: 130,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Colors.black54)),
                              child: Center(
                                child: Text(
                                  "Select On Map",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8),
                                ),
                              ),
                            ),
                          ),
                          15.width,
                          GestureDetector(
                            onTap: () => model.getCurrentLocation(),
                            child: Container(
                              // height: 38,
                              // width: 152,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 1, color: Colors.black54)),
                              child: Center(
                                child: Text(
                                  "Current Location",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      15.height,
                      Text("Admin Details",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700)),
                      15.height,
                      CustomTextFormFeild(
                        labelText: "Name",
                        controller: model.adminNameController,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            model.addChurch.adminName = val;
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter admin name";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormFeild(
                        labelText: "Email",
                        controller: model.adminEmailController,
                        type: TextInputType.emailAddress,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            model.addChurch.adminEmail = val;
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter admin email";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormFeild(
                        labelText: "Phone Number",
                        type: TextInputType.number,
                        controller: model.adminPhoneController,
                        onChanged: (val) {
                          if (val.isNotEmpty) {
                            model.addChurch.adminPhone = int.parse(val);
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter admin phone number";
                          }
                          return null;
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          if (model.imagePath == null) {
                            Get.snackbar("Alert", "Please select church logo");
                          }
                          if (_formKey.currentState!.validate() &&
                              (model.imagePath != null)) {
                            model.createChurch();
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: redColor.shade900,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(width: 1, color: Colors.black54)),
                          child: Center(
                            child: Text(
                              "Add Church",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            ),
                          ),
                        ),
                      ),
                      15.height
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
