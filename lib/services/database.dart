import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery_app/pages/wallet.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future<void> UpdateUserWallet(String id, String amount) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'Wallet': amount,
      });
      print('Wallet updated successfully for user: $id');
    } catch (e) {
      print('Error updating wallet for user $id: $e');
      throw e;
    }
  }

  Future addFoodImage(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  //Stream enable to get data from firebaSe
  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future AddFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("Cart")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("Cart")
        .snapshots();
  }
}
