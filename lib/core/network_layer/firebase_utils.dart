import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/provider/app_provider.dart';
import '../../core/utils/extract_date.dart';
import '../../model/task_model.dart';

class FirebaseUtils {
  static Future<Either<String?, UserCredential>> register(
      String email, String password) async {
    late UserCredential user;
    try {
      user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await verifyEmail();
    } on FirebaseAuthException catch (e) {
      return left(e.code);
    }
    return Right(user);
  }

  static verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  static String getCurrentUserEmail() {
    String email = "";
    try {
      email = FirebaseAuth.instance.currentUser!.email!;
    } on FirebaseAuthException catch (e) {
      return (e.code);
    }
    return email;
  }

  static Future<Either<String, UserCredential>> logIn(
      String email, String password) async {
    late UserCredential user;
    try {
      user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }
    return Right(user);
  }

  static Future<String> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.code;
    }
    return "success";
  }

  static logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection(AppProvider.userID)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (task, _) => task.toFirestore(),
        );
  }

  static Future<void> addDataToFirestore(TaskModel task) {
    var collectionRef = getCollection();
    var docRef = collectionRef.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> deleteDataFromFirestore(TaskModel task) {
    var collectionRef = getCollection();
    var docRef = collectionRef.doc(task.id);
    return docRef.delete();
  }

  static Future<void> updateDataOnFirestore(TaskModel task) {
    var collectionRef = getCollection();
    var docRef = collectionRef.doc(task.id);
    return docRef.update(task.toFirestore());
  }

  static Future<List<TaskModel>> getDataFromFirestore() async {
    var snapshot = await getCollection().get();
    return snapshot.docs.map((element) => element.data()).toList();
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFirestore(
      DateTime date) {
    var reqDate = ExtractDate.extractDate(date);
    var snapshot = getCollection()
        .where('date', isEqualTo: reqDate.millisecondsSinceEpoch)
        .snapshots();
    return snapshot;
  }
}
