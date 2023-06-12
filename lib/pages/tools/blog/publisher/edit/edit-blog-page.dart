import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/blog/publisher/edit/edit-blog-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';

class EditBlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<EditBlogController>(
        init: EditBlogController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  if (!_.blog["no_data"]) {
                                    _.togglePublish();
                                  }
                                },
                                child: Text(
                                  _.blog["published"] ? 'Unpublish' : 'Publish',
                                  style: TextStyle(
                                    color: _.blog["no_data"]
                                        ? Colors.grey
                                        : (_.blog["published"]
                                            ? Colors.red
                                            : redColor),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_.saveButtonEnabled) {
                                    _.saveBlog();
                                  }
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: _.saveButtonEnabled
                                        ? redColor
                                        : Colors.grey,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Edit Blog',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        maxLines: 1,
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        controller: _.titleController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _.blog['no_data']
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: DropdownButton<String>(
                                items: <String>[
                                  'Money Matters',
                                  'Healthy Living',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: _.selectedType,
                                elevation: 1,
                                onChanged: (value) => _.selectType(value),
                                hint: Text("Type of event"),
                                isExpanded: true,
                                underline: SizedBox(),
                              ),
                            )
                          : Container(),
                      Column(
                        children: [
                          QuillToolbar.basic(
                            controller: _.quillcontroller,
                            showUnderLineButton: false,
                            showStrikeThrough: false,
                            showColorButton: false,
                            showBackgroundColorButton: false,
                            showListCheck: false,
                            showIndent: false,
                          ),
                          QuillEditor(
                            controller: _.quillcontroller,
                            focusNode: _.editorFocusNode,
                            readOnly: false,
                            autoFocus: true,
                            expands: false,
                            scrollController: ScrollController(),
                            scrollable: true,
                            padding: EdgeInsets.zero,
                            minHeight: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
