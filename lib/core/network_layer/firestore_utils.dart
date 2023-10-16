import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/core/provider/app_provider.dart';
import 'package:todo/core/utils/extract_date.dart';

import '../../model/task_model.dart';

class FirestoreUtils {

  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection(AppProvider.userID!)
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

  static Future <List<TaskModel>> getDataFromFirestore() async {
    var snapshot = await getCollection().get();
    return snapshot.docs.map((element) => element.data()).toList();
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDataFromFirestore(DateTime date) {
    var reqDate = ExtractDate.extractDate(date);
    var snapshot = getCollection().where('date', isEqualTo: reqDate.millisecondsSinceEpoch).snapshots();
    return snapshot;
  }
}
