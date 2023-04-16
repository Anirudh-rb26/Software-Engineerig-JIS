import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiss/constants/colours.dart';

class CasePage extends StatelessWidget {
  final String documentId;

  const CasePage({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        title: Text("Case: $documentId"),
        backgroundColor: CustomColors().backgroundColor,
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getDocument('cases', documentId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data?.data();
          if (data == null) {
            return const Center(
              child: Text("No Data found"),
            );
          }

          // You can use the data variable to display the contents of the document
          return SingleChildScrollView(
            child: Container(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Case ID: ",
                      value: data['caseID'],
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Case Status: ",
                      value: data['caseStatus'],
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Case Type: ",
                      value: data['caseType'],
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Case Verdict: ",
                      value: data['caseVerdict'],
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Defendant: ",
                      value: data['defendant'],
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Defendant's Address: ",
                      value: data['defendantsAddress'],
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Date of Arrest: ",
                      value: getDate(data['arrestingDate']),
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Location of Arrest: ",
                      value: data['arrestingLocation'],
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Arresting Officer: ",
                      value: data['arrestingOfficer'],
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Case registered on: ",
                      value: getDate(data['registerDate']),
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Date of Hearing: ",
                      value: getDate(data['hearingDate']),
                    ),
                    const SizedBox(height: 10),
                    CaseDatafeild(
                      feildName: "Lawyer ID: ",
                      value: data['lawyerEnrollmentID'],
                    ),
                  ],
                ),
              ),
            ),
          );
          // return Center(
          //   child: Text("Data: $data"),
          // );
        },
      ),
    );
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
    String collectionName, String documentId) async {
  // Get a reference to the document
  final docRef =
      FirebaseFirestore.instance.collection(collectionName).doc(documentId);

  // Get the document snapshot
  final docSnapshot = await docRef.get();

  // Return the document snapshot
  return docSnapshot;
}

class CaseDatafeild extends StatefulWidget {
  final String feildName;
  dynamic value;
  CaseDatafeild({super.key, required this.feildName, required this.value});

  @override
  State<CaseDatafeild> createState() => _CaseDatafeildState();
}

class _CaseDatafeildState extends State<CaseDatafeild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1500,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CustomColors().buttonColor,
      ),
      // color: CustomColors().headlineColor,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          widget.feildName + widget.value,
          style: TextStyle(color: CustomColors().buttonTextColor),
          // style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

String getDate(Timestamp timestamp) {
  DateTime dateWithTime = timestamp.toDate();
  String dateWithoutTime = DateFormat("dd-MM-yyyy").format(dateWithTime);
  return dateWithoutTime;
}
