import 'dart:html' as html;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiss/constants/colours.dart';
import 'package:jiss/constants/snack.dart';
import 'package:jiss/pages/homepage/homepage.dart';
import 'package:path_provider/path_provider.dart';

class ViewDocuments extends StatefulWidget {
  final String documentId;

  const ViewDocuments({super.key, required this.documentId});

  @override
  State<ViewDocuments> createState() => _ViewDocumentsState();
}

class _ViewDocumentsState extends State<ViewDocuments> {
  late String imageUrl;
  final storage = FirebaseStorage.instance;
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref(widget.documentId).listAll();
    imageUrl = '';
    // getImageUrl();
  }

  Future<void> getImageUrl(String documentId, String imageName) async {
    print("inside get image url");
    final ref = storage.ref(documentId).child(imageName);
    print("1");
    final imageUrl = await ref.getDownloadURL();
    print("2");
    print(imageUrl);
    print("3");
    html.window.open(imageUrl, "_blank");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomSnackbar(
          errorText: "Download Successful",
          success: true,
          snackBarColor: Colors.green,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        title: Text("Case: ${widget.documentId}, Documents"),
        backgroundColor: CustomColors().backgroundColor,
        elevation: 0,
      ),
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;

            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    side:
                        BorderSide(width: 2, color: CustomColors().buttonColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    file.name,
                    style: TextStyle(color: CustomColors().paragraphColor),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      getImageUrl(widget.documentId, file.name);
                    },
                    icon: Icon(
                      CupertinoIcons.cloud_download,
                      color: CustomColors().paragraphColor,
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error Occured'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
