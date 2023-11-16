// import 'package:churchappenings/widgets/bottom-action-button.dart';
// import 'package:churchappenings/widgets/custom_text_field2.dart';
// import 'package:churchappenings/widgets/navigate-back-widget.dart';
// import 'package:churchappenings/widgets/transparentAppbar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../constants/red-material-color.dart';
// import 'create-stewardship-controller.dart';
// import 'create-stewardship-page.dart';

// class PaymentSelectionPage extends StatelessWidget {
//   PaymentSelectionPage({Key? key}) : super(key: key);
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: transparentAppbar(),
//       body: GetBuilder<CreateStewardshipController>(
//         init: CreateStewardshipController(),
//         global: true,
//         builder: (_) {
//           if (_.loading) {
//             return Center(child: CircularProgressIndicator());
//           }

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: SingleChildScrollView(
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           navigateToWidget(),
//                           SizedBox(height: 15),
//                           Text(
//                             'Payment History',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w300,
//                               height: 1.5,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           Text(
//                             'My previous payments',
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.w700,
//                               height: 1.5,
//                             ),
//                           ),
//                           SizedBox(height: 50),

//                           ///
//                           /// payment type selection
//                           ///
//                           // Obx(
//                           //   () => Column(
//                           //     children: [
//                           //       RadioListTile(
//                           //         activeColor: redColor,
//                           //         title: Text('Credit Card'),
//                           //         value: 'Card',
//                           //         groupValue: _.paymentMethod.value,
//                           //         onChanged: (value) {
//                           //           _.paymentMethod = "Card".obs;
//                           //           _.update();
//                           //         },
//                           //       ),
//                           //       RadioListTile(
//                           //         activeColor: redColor,
//                           //         title: Text('Cash'),
//                           //         value: 'Cash',
//                           //         groupValue: _.paymentMethod.value,
//                           //         onChanged: (value) {
//                           //           _.paymentMethod = "Cash".obs;
//                           //           _.update();
//                           //         },
//                           //       ),
//                           //     ],
//                           //   ),
//                           // ),

//                           ///
//                           /// Card details
//                           ///
//                           ///
//                           // _.paymentMethod.value == "Card"
//                           //     ? Column(
//                           //         crossAxisAlignment: CrossAxisAlignment.start,
//                           //         children: [
//                           //           SizedBox(height: 10),
//                           //           Text("Enter Card details"),
//                           //           SizedBox(height: 10),
//                           //           CustomTextField2(
//                           //             labelText: 'Name of Card',
//                           //             hintText: 'e.g: Smith',
//                           //             controller: _.nameController,
//                           //             keyboardType: TextInputType.text,
//                           //             validator: (value) {
//                           //               if (value!.isEmpty) {
//                           //                 return 'Please the name as appear o card';
//                           //               }
//                           //               return null;
//                           //             },
//                           //           ),
//                           //           SizedBox(height: 10),
//                           //           CustomTextField2(
//                           //             controller: _.cardNoController,
//                           //             labelText: 'Card No',
//                           //             hintText: 'xxxx xxxx xxxx xxxx',
//                           //             keyboardType: TextInputType.text,
//                           //             validator: (value) {
//                           //               if (value!.isEmpty) {
//                           //                 return 'Please enter the card no.';
//                           //               }
//                           //               return null;
//                           //             },
//                           //           ),
//                           //           SizedBox(height: 10),
//                           //           Row(
//                           //             children: [
//                           //               Expanded(
//                           //                 child: CustomTextField2(
//                           //                   labelText: 'Expiry Date',
//                           //                   hintText: 'xx/xx',
//                           //                   controller: _.expiryDateController,
//                           //                   keyboardType: TextInputType.text,
//                           //                   validator: (value) {
//                           //                     if (value!.isEmpty) {
//                           //                       return 'Please enter the card expiry.';
//                           //                     }
//                           //                     return null;
//                           //                   },
//                           //                 ),
//                           //               ),
//                           //               SizedBox(width: 10),
//                           //               Expanded(
//                           //                 child: CustomTextField2(
//                           //                   labelText: 'CVV',
//                           //                   hintText: 'xxx',
//                           //                   keyboardType: TextInputType.text,
//                           //                   controller: _.cvvController,
//                           //                   validator: (value) {
//                           //                     if (value!.isEmpty) {
//                           //                       return 'Please enter the cvv no.';
//                           //                     }
//                           //                     return null;
//                           //                   },
//                           //                 ),
//                           //               ),
//                           //             ],
//                           //           ),
//                           //         ],
//                           //       )
//                           //     : Container()
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     Get.to(CreateStewardshipPage());
//                   }
//                 },
//                 child: buildBottomActionButton('Next'),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
