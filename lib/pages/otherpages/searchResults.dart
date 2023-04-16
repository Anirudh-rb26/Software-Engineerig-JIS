import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  final List<String> caseIds;
  final String query;
  final String documentId;
  const SearchResults(
      {super.key,
      required this.caseIds,
      required this.query,
      required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference cases = FirebaseFirestore.instance.collection('cases');

    return FutureBuilder<DocumentSnapshot>(
      future: cases.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("caseId: ${data['caseID']}");
        }
        return const Text("loading...");
      }),
    );
  }
}
