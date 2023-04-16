import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jiss/constants/colours.dart';

class SortedPendingCases extends StatefulWidget {
  const SortedPendingCases({super.key});

  @override
  State<SortedPendingCases> createState() => _SortedPendingCasesState();
}

List<String> caseIds = [];
List<String> pendingCaseIds = [];
Map<String, dynamic>? data;

Future getCaseId() async {
  print("getting Case ID");
  await FirebaseFirestore.instance.collection('cases').get().then(
        (snapshot) => snapshot.docs.forEach(
          (document) {
            print("adding normal caseID: ${document.reference.id}");
            caseIds.add(document.reference.id);
          },
        ),
      );
  print("getting Case ID DONE");
  print("Searcing");
  FirebaseFirestore.instance
      .collection('cases')
      .where('caseStatus', isEqualTo: true)
      .get()
      .then(
        (snapshot) => snapshot.docs.forEach(
          (document) {
            print("adding pending caseID: ${document.reference.id}");
            pendingCaseIds.add(document.reference.id);
          },
        ),
      );
}

class _SortedPendingCasesState extends State<SortedPendingCases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors().backgroundColor,
        appBar: AppBar(
          title: const Text("Pending Cases"),
          backgroundColor: CustomColors().backgroundColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getCaseId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: pendingCaseIds.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2, color: CustomColors().buttonColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              "Case ID: ${pendingCaseIds[index]}",
                              style: TextStyle(
                                  color: CustomColors().paragraphColor),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
