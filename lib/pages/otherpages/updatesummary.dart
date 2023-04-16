import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/constants/snack.dart';
import 'package:jiss/pages/homepage/homepage.dart';

class UpdateCaseSummary extends StatefulWidget {
  const UpdateCaseSummary({super.key});

  @override
  State<UpdateCaseSummary> createState() => _UpdateCaseSummaryState();
}

class _UpdateCaseSummaryState extends State<UpdateCaseSummary> {
  final caseIdController = TextEditingController();
  List<String> caseIds = [];
  Uint8List? uploadFile;
  String selectedCaseId = '';

  Future getCaseId() async {
    await FirebaseFirestore.instance.collection('cases').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              caseIds.add(document.reference.id);
            },
          ),
        );
  }

  void searchForCaseId(String query, List<String> caseIds) {
    if (caseIds.contains(query)) {
      print("Contains query");
      print("Query: ${query}");
      selectedCaseId = query;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            success: true,
            errorText: "Case Selected",
            snackBarColor: Colors.green,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
        ),
      );
    } else {
      print('Case ID not found.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            success: false,
            errorText: "Case Doesn't Exist",
            snackBarColor: Colors.red,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  void CheckCaseId(String selectedCaseId) {
    if (caseIds.contains(selectedCaseId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            success: true,
            errorText: "Case Selected",
            snackBarColor: Colors.green,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            success: false,
            errorText: "Case Doesn't Exist",
            snackBarColor: Colors.red,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  Future getFile() async {
    print("filepicker initiated");
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print("file selected");
      Uint8List sampleFile = result.files.single.bytes!;
      print("path saved, snackbar next");

      setState(() {
        uploadFile = sampleFile;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            success: true,
            errorText: "File Selected.",
            snackBarColor: Colors.green,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
        ),
      );
    } else {
      // User canceled the picker
      print("no files");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomSnackbar(
            success: false,
            errorText: "No files selected",
            snackBarColor: Colors.red,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        backgroundColor: CustomColors().backgroundColor,
        elevation: 0,
        title: const Text("Upload Documents"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: CustomColors().paragraphColor),
                controller: caseIdController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: CustomColors().paragraphColor,
                    ),
                  ),
                  labelText: "Enter Case ID",
                  labelStyle: TextStyle(color: CustomColors().paragraphColor),
                  prefixIcon: Icon(
                    CupertinoIcons.doc,
                    color: CustomColors().paragraphColor,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: CustomColors().buttonColor, width: 3),
                  ),
                  focusColor: CustomColors().paragraphColor,
                ),
              ),
              const SizedBox(height: 10),
              SelectCaseId(onTap: () {
                print("getting case id");
                getCaseId();
                print("success");
                searchForCaseId(caseIdController.text, caseIds);
                print("searching");
              }),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors().paragraphColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                // Upload Documents feild
                height: 250,
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                          child: uploadFile == null
                              ? SvgPicture.asset(
                                  "assets/images/fileupload.svg",
                                  height: 100,
                                  width: 100,
                                )
                              : SvgPicture.asset(
                                  "assets/images/selected.svg",
                                  height: 100,
                                  width: 100,
                                )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SelectFiles(onTap: () {
                            print("get files called");
                            getFile();
                          }),
                          UploadButton(onTap: () {
                            print("upload called");
                            Reference storageReference = FirebaseStorage
                                .instance
                                .ref(selectedCaseId)
                                .child('$selectedCaseId#${DateTime.now()}');
                            print("uploading");
                            final UploadTask task =
                                storageReference.putData(uploadFile!);
                            print("uploading completed");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: CustomSnackbar(
                                  success: true,
                                  errorText: "Uploaded Successfully",
                                  snackBarColor: Colors.green,
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectCaseId extends StatelessWidget {
  void Function()? onTap;
  SelectCaseId({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: CustomColors().buttonColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Select Case",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.doc),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  void Function()? onTap;
  UploadButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: CustomColors().buttonColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Upload Files",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.cloud_upload),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectFiles extends StatelessWidget {
  void Function()? onTap;
  SelectFiles({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: CustomColors().buttonColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Select Files",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(CupertinoIcons.doc_fill),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
