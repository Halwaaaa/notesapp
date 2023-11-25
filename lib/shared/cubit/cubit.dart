import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new3/shared/cubit/states.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppCubit extends Cubit<AppStates> {
  // ignore: avoid_types_as_parameter_names
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  bool islooding = false;
  void changislooding({required bool g}) {
    islooding = g;
    emit(AppchanStates());
  }
// Import the firebase_core and cloud_firestore plugin

  CollectionReference data = FirebaseFirestore.instance.collection('data');

  Future<void> addUdata({
    required String categories,
  }) {
    // Call the user's CollectionReference to add a new user
    return data.add({
      'categories': categories,
      //'email': FirebaseAuth.instance
      //'id': FirebaseAuth.instance.currentUser!.uid // John Doe
      // Stokes and Sons
    }).then((value) {
      getdata();
      emit(AppAddFireBaseStates());
      // print(value);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addnotedata({
    required String id,
    required String categories,
  }) {
    // Call the user's CollectionReference to add a new user
    return FirebaseFirestore.instance
        .collection('data')
        .doc(id)
        .collection('note')
        .add({
      'note': categories,
      //'email': FirebaseAuth.instance
      //'id': FirebaseAuth.instance.currentUser!.uid // John Doe
      // Stokes and Sons
    }).then((value) {
      getNotedata(noteid: id);
      emit(AppAddNoteFireBaseStates());
      // print(value);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print("Failed to add user: $error"));
  }

  List dataa = [];

  Future<void> getdata() async {
    FirebaseFirestore.instance
        .collection('data')
        //  .where("emai", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      // if (value.docs.isNotEmpty) {
      dataa = value.docs;
      islooding = false;
      //  } else {}

      print(dataa);
      emit(AppGetFireBaseStates());
    });
  }

  List notes = [];

  Future<void> getNotedata({
    required String noteid,
  }) async {
    FirebaseFirestore.instance
        .collection('data')
        .doc(noteid)
        .collection('note')
        .get()
        .then((value) {
      // if (value.docs.isNotEmpty) {
      notes = value.docs;
      islooding = false;
      //  } else {}

      // print(dataa);
      emit(AppGetnoteFireBaseStates());
    });
  }
  //CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> delateget({required int id}) async {
    FirebaseFirestore.instance
        .collection('data')
        .doc(dataa[id].id)
        .delete()
        .then((value) {
      getdata();
      emit(AppDaletFireBaseStates());
    });
  }

  Future<void> daletUpdata({required String id, required String idNote}) async {
    FirebaseFirestore.instance
        .collection('data')
        .doc(id)
        .collection('note')
        .doc(idNote)
        .delete()
        .then((value) {
      getNotedata(noteid: id);
      emit(AppDaletUppFireBaseStates());
    });
  }

  Future<void> upData({
    required String id,
    required String name,
  }) async {
    FirebaseFirestore.instance
        .collection('data')
        .doc(id)
        .set({"categories": name}, SetOptions(merge: true)).then((value) {
      getdata();
      emit(AppUppFireBaseStates());
    });
  }

  Future<void> upNoteData({
    required String id,
    required String idNote,
    required String name,
  }) async {
    FirebaseFirestore.instance
        .collection('data')
        .doc(id)
        .collection('note')
        .doc(idNote)
        .set({"note": name}, SetOptions(merge: true)).then((value) {
      getNotedata(noteid: id);
      emit(AppUppNoteFireBaseStates());
    });

    // Create a CollectionReference called users that references the firestore collection
  }

  //for fairbase
  // ignore: unused_local_variable
  bool showBottem = true;
  void Cangedbootem({required bool g}) {
    showBottem = g;
    print(showBottem);

    emit(AppChangedBottem());
  }

  List New = [];
  Future<void> getnew() async {
    FirebaseFirestore.instance
        .collection('new')
        .orderBy('age', descending: true)
        //.where('name',)
        //  .where("emai", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      // if (value.docs.isNotEmpty) {
      New = value.docs;
      islooding = false;
      emit(AppGetNewFireBaseStates());
      //  } else {}

      //print(dataa);
    });
  }

  Future<void> addnew({
    required String name,
    required int many,
    required int age,
  }) {
    // Call the user's CollectionReference to add a new user
    return FirebaseFirestore.instance.collection('new').add({
      'name': name,
      'many': many,
      'age': age,
    }).then((value) {
      getnew();
      emit(AppAddNewFireBaseStates());
    });
  }

  Future<void> daltenew({required int id}) async {
    FirebaseFirestore.instance
        .collection('new')
        .doc(New[id].id)
        .delete()
        .then((value) {
      getnew();
      emit(AppBalteNewFireBaseStates());
    });
  }

  Future<void> transaction({
    required int idnew,
  }) async {
    DocumentReference document =
        FirebaseFirestore.instance.collection('new').doc(New[idnew].id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(document);

      if (snapshot.exists) {
        var snap = snapshot.data();
        if (snap is Map<String, dynamic>) {
          var many = snap['mony'] + 100;
          transaction.update(document, {"many": many});
        }
      }
    });
  }

  var many;

  Future<void> BatchTransaction({required int idnew}) async {
    var colec = FirebaseFirestore.instance.collection('new').doc(New[idnew].id);
    var colec11 =
        FirebaseFirestore.instance.collection('new').doc(New[idnew].id);
    var batch = FirebaseFirestore.instance.batch();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(colec);

      if (snapshot.exists) {
        var snap = snapshot.data();
        if (snap is Map<String, dynamic>) {
          many = snap['mony'] + 100;
          transaction.update(colec, {"many": many});
        }
      }
      batch.update(colec, {'mony': many});
    });
    batch.update(colec11, {
      'age': 10,
    });
    return batch.commit();
  }
}
