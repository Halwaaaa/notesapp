import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_sign_in/google_sign_in.dart';

Widget dafaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required var funaction,
  required String textt,
  bool isuppcase = true,
}) =>
    Container(
      color: Colors.blue,
      width: width,
      child: MaterialButton(
        onPressed: funaction,
        child: Text(
          isuppcase ? textt.toUpperCase() : textt,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
Widget dafaultTrxtFormFaild({
  required TextEditingController controller,
  bool obscuretext = false,
  required Text lableText,
  required Icon prefixicon,
  IconButton? suffixIcon,
  required TextInputType keyboardType,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required Null Function(dynamic b) onFieldSubmitted,
  required String? Function(dynamic value) vlidata,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscuretext,
    decoration: InputDecoration(
        labelText: "$lableText",
        border: const OutlineInputBorder(),
        prefixIcon: prefixicon,
        suffixIcon: suffixIcon),
    keyboardType: keyboardType,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    onTap: onTap,
    validator: validate,
  );
}

Widget dafaulttextItem(Map map, contest) {
  return Slidable(
    key: Key(map['data']),

    startActionPane: ActionPane(
      motion: const StretchMotion(),
      dismissible: Container(
        color: Colors.amber,
        child: DismissiblePane(
            key: Key(map['id'].toString()),
            onDismissed: () {
              //  if (AppCubit.get(contest).h = false) {
              // AppCubit.get(contest).updalteBase(id: map['id']);
              // }
            }),
      ),

      extentRatio: 0.25,
      openThreshold: 0.25,
      closeThreshold: 0.25,
      key: Key("$map['id']"),
      // motion: //InkWell(
      // onTap: () {
      //   AppCubit.get(contest).updalteBase(id: map['id']);
      //},
      //child: Container(
      // color: Colors.red,
      // child: const Icon(Icons.delete),
      // ),
      //),
      children: [
        SlidableAction(
          onPressed: (context) {
            // AppCubit.get(context).h;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Center(child: Text("data")),
              backgroundColor: Colors.teal,
            ));
            //  AppCubit.get(contest).updalteBase(id: map['id']);
          },
          borderRadius: BorderRadius.circular(20),
          icon: Icons.abc_sharp,
          label: "Dalate",
        )
        //IconButton(

        //onPressed: () {},
        // icon: const Icon(Icons.access_alarm_rounded),
        //),
      ],
    ),
    // child:// Dismissible(
    //   key: Key(map['id'].toString()),
    child: InkWell(
      onTap: () {
        print("object");
        final y = Slidable.of(contest);
        final isclosd = y?.actionPaneType.value == ActionPaneType.none;
        if (isclosd) {
          print(isclosd);
          y!.openStartActionPane();
        } else {
          y?.close();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              //title, data, timr
              child: Text(
                "${map['timr']} ",
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Text(
                      "${map['title']} ",
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text("${map['data']} ",
                        maxLines: 1, style: const TextStyle(fontSize: 15))
                  ],
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      //AppCubit.get(contest)
                      //   .upDataBase(status: "done", id: map['id']);
                    },
                    icon: const Icon(Icons.done_all)),
                IconButton(
                    onPressed: () {
                      /// AppCubit.get(contest)
                      //.upDataBase(status: "archived", id: map['id']);
                    },
                    icon: const Icon(Icons.abc_outlined)),
              ],
            )
          ],
        ),
      ),
    ),
    // confirmDismiss: (direction) async {
    //  if (direction == DismissDirection.startToEnd) {}
    // },
    //onResize: () {},
    //onDismissed: (direction) {
    //  AppCubit.get(contest).getDataBase(map);
    //  },
    //background: Container(
    //child: IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
    //width: 20,
    //color: Colors.white,
    // ),
    //),
  );
}

enum ToastStates { SUCCESS, ERROR, WARNIG }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.redAccent;
      break;
    case ToastStates.WARNIG:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast({
  required String message,
  required ToastStates state,
  required BuildContext context,
}) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 5),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      color: choseToastColor(state),
      title: 'Oh Hey!',
      message: message,
      contentType: ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
