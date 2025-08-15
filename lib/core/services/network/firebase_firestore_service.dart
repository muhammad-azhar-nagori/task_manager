import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentReference<Map<String, dynamic>> get _firestore =>
      _firebasefirestore.collection('users').doc(_auth.currentUser!.uid);

  Future<void> setDocument({
    required String path,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(path).doc(docId).set(data);
  }

  Future<void> updateDocument({
    required String path,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(path).doc(docId).update(data);
  }

  Future<void> deleteDocument({
    required String path,
    required String docId,
  }) async {
    await _firestore.collection(path).doc(docId).delete();
  }

  Future<DocumentSnapshot> getDocument({
    required String path,
    required String docId,
  }) async {
    return await _firestore.collection(path).doc(docId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCollection({
    required String path,
    Map<String, dynamic>? where,
    String? orderBy,
    bool descending = false,
  }) async {
    Query<Map<String, dynamic>> query = _firestore.collection(path);

    if (where != null) {
      where.forEach((key, value) {
        query = query.where(key, isEqualTo: value);
      });
    }

    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    return await query.get();
  }
}
