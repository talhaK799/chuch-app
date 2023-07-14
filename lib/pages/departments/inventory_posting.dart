import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/inventory.dart';
import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';
import 'departments-controller.dart';

class InventoryPosting extends StatelessWidget {
  const InventoryPosting({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(DepartmentController());
    // DepartmentController departmentController =
    //     Get.find<DepartmentController>();

    final List<Widget> pages = [
      InventoryScreen(),
      Container(
        color: Colors.green,
        child: Center(child: Text("Page 2")),
      ),
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inventory"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Own Inventory",
              ),
              Tab(
                text: "Borrowed Inventory",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InventoryScreen(),
            BorrowedInventory(),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: departmentController.currentPageIndex.value,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: "Page 1",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.work),
        //       label: "Page 2",
        //     ),
        //   ],
        //   onTap: (index) {
        //     departmentController.onChangePage(index);
        //   },
        // ),
      ),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DepartmentController>(
        init: DepartmentController("InventoryScreen"),
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return _.inventoryList.isEmpty
              ? SizedBox()
              : Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _.inventoryList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      DetailInventory(
                                        inventory: _.inventoryList[index],
                                      ),
                                    );
                                  },
                                  child: Container(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Name:',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      _.inventoryList[index]
                                                          .name
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Quantity:',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      _.inventoryList[index]
                                                          .quantity
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    // Text(
                                                    //   "${DateFormat('yyy-MM-dd').format(_.inventoryList[index].createdAt)}",
                                                    //   overflow:
                                                    //       TextOverflow.ellipsis,
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                    color: Colors.black45,
                                                    width: 1,
                                                  )),
                                                  child: Icon(Icons.edit),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                    color: Colors.black45,
                                                    width: 1,
                                                  )),
                                                  child: Icon(Icons.person),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                    )
                  ],
                );
        },
      ),
    );
  }
}

class BorrowedInventory extends StatelessWidget {
  const BorrowedInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<DepartmentController>(
            init: DepartmentController("BorrowedInventory"),
            builder: (_) {
              if (_.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return _.inventoryBorrowedList.isEmpty
                  ? SizedBox()
                  : Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: _.inventoryBorrowedList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          DetailInventory(
                                            inventory:
                                                _.inventoryBorrowedList[index],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Borrowed From:',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          _
                                                              .inventoryBorrowedList[
                                                                  index]
                                                              .borrowedFrom
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Name:',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          _
                                                              .inventoryBorrowedList[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Quantity:',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${_.inventoryBorrowedList[index].quantity}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   "${DateFormat('yyy-MM-dd').format(_.inventoryBorrowedList[index].createdAt)}",
                                                        //   overflow: TextOverflow
                                                        //       .ellipsis,
                                                        // ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        log("click...");
                                                      },
                                                      child: Container(
                                                        child: PopupMenuTheme(
                                                          data:
                                                              PopupMenuThemeData(
                                                            color: Colors
                                                                .white, // Set the desired color here
                                                          ),
                                                          child:
                                                              PopupMenuButton(
                                                            itemBuilder:
                                                                (context) => [
                                                              PopupMenuItem(
                                                                child: Text(
                                                                    "Edit"),
                                                                value: "Edit",
                                                              ),
                                                              PopupMenuItem(
                                                                child: Text(
                                                                    "Delete"),
                                                                value: "Delete",
                                                              ),
                                                            ],
                                                            elevation: 8.0,
                                                            onSelected:
                                                                (value) {
                                                              if (value ==
                                                                  "Edit") {
                                                                // Perform Edit operation
                                                              } else if (value ==
                                                                  "Delete") {
                                                                // Perform Delete operation
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                        )
                      ],
                    );
            }));
  }
}

class DetailInventory extends StatelessWidget {
  const DetailInventory({super.key, required this.inventory});
  final Inventory inventory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navigateToWidget(),

                // IconButton(onPressed: () {}, icon: Icon(Icons.add))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inventory.borrowedFrom.isNotEmpty
                        ? Row(
                            children: [
                              Text("Borrowed From: "),
                              SizedBox(
                                width: 5,
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.12,
                              // ),
                              Text(inventory.borrowedFrom.toString()),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("Name: "),
                        SizedBox(
                          width: 5,
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.12,
                        // ),
                        Text(inventory.name.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Description: "),
                        Flexible(child: Html(data: "${inventory.description}")),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Quantity: "),
                        SizedBox(
                          width: 5,
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.08,
                        // ),
                        Text(inventory.quantity.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text("Crated At: "),
                        SizedBox(
                          width: 5,
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.08,
                        // ),
                        Text(
                          "${DateFormat('yyy-MM-dd').format(inventory.createdAt)}",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
