// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:jiss/constants/snack.dart';

// String authAccess() {
//   User? user = FirebaseAuth.instance.currentUser;
//   var kk =
//       FirebaseFirestore.instance.collection('/users').doc(user!.uid).get().then(
//     (DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         String currentUserRole = documentSnapshot.get('role');
//         switch (currentUserRole) {
//           case "judge":
//             {
//               return "judge";
//             }
//           case "registrar":
//             {
//               return "registrar";
//             }
//           case "lawyer":
//             {
//               return "lawyer";
//             }
//           case "client":
//             {
//               return "client";
//             }
//           default:
//             return const CustomSnackbar(
//                 errorText: "Internal Error, please contact us.");
//         }
//       } else {
//         return const CustomSnackbar(
//             errorText: "Internal Error, please contact us.");
//       }
//     },
//   );
//   return "null";
// }
