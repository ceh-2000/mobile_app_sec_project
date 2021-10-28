import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

Future<void> uploadBillLocation(String bill_id, LocationData? loc_data) async {
  final snapShot = await FirebaseFirestore.instance
      .collection('bills')
      .doc(bill_id)
      .get();

  if (loc_data == null || loc_data.longitude == null || loc_data.latitude == null) {
    return;
  }

  print("Uploading");

  if (snapShot == null || !snapShot.exists) {
    // Document doesn't exist yet
    await FirebaseFirestore.instance
        .collection('bills')
        .doc(bill_id)
        .set({
          'bill_id': FieldValue.arrayUnion([GeoPoint(loc_data.latitude ?? 0, loc_data.longitude ?? 0)])
        });
  } else {
    await FirebaseFirestore.instance
        .collection('bills')
        .doc(bill_id)
        .update({
          'bill_id': FieldValue.arrayUnion([GeoPoint(loc_data.latitude ?? 0, loc_data.longitude ?? 0)])
        });
  }

  print("Done uploading.");
}