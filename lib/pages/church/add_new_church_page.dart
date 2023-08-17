import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/country_code.dart';
import 'package:churchappenings/pages/church/add_church_controller.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/widgets/custom_textform_field.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewChurchPage extends StatelessWidget {
  const AddNewChurchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddChurchController>(
      init: AddChurchController(),
      builder: (model) => Scaffold(
        appBar: transparentAppbar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              navigateToWidget(),
              15.height,
              Text("Church Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              20.height,
              CustomTextFormFeild(
                labelText: "Church Name",
              ),
              Container(
                height: 35,
                width: 110,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.black54)),
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
              15.height,
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<CountryAndTerritory>(
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    hint: Text("Select Country"),
                    underline: Container(),
                    value: model
                        .selectedCountryAndTerritory, // Assign the selected CountryAndTerritory object
                    items: model.countryAndTerritory
                        .map((CountryAndTerritory countryAndTerritory) {
                      return DropdownMenuItem<CountryAndTerritory>(
                        value: countryAndTerritory,
                        child: Text("${countryAndTerritory.country}"),
                      );
                    }).toList(),
                    onChanged: (countryCode) {
                      model.selectCountry(countryCode!);
                    },
                  )),
              15.height,
              Text("Territory"),
              5.height,
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child:
                      Text("${model.selectedCountryAndTerritory.territory}")),
              15.height,
              CustomTextFormFeild(
                labelText: "Conference",
              ),
              Text("Admin Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              15.height,
              CustomTextFormFeild(
                labelText: "Name",
              ),
              CustomTextFormFeild(
                labelText: "Email",
                type: TextInputType.emailAddress,
              ),
              CustomTextFormFeild(
                labelText: "Phone Number",
                type: TextInputType.number,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: redColor.shade900,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.black54)),
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
              15.height
            ]),
          ),
        ),
      ),
    );
  }
}

class CustomTuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  CustomTuple2(this.item1, this.item2);
}
