// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new3/shared/compoenents/dauildMateral.dart';
import 'package:new3/shared/compoenents/textFormFaild.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: depend_on_referenced_packages
//import 'package:awesome_dialog/awesome_dialog.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController pasword = TextEditingController();
  var kryform = GlobalKey<FormState>();
  bool looding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: looding
            ? Container(
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black12,
                ),
              )
            : Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: kryform,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const dauilMateral(),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "login",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Loing up to use app",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.grey[400]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormFiledd(
                              validate: (value) {
                                if (value == "") {
                                  return "email is empty";
                                } else {
                                  return null;
                                }
                              },
                              onprassed: () {},
                              controller: email,
                              hinitText: "Emaill adress here",
                              adrres: "Email",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormFiledd(
                                validate: (value) {
                                  if (value == "") {
                                    return "paswoed is empty";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: pasword,
                                hinitText: "pasword",
                                adrres: "paswoed",
                                onprassed: () {}),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: AlignmentDirectional.bottomEnd,
                              height: 50,
                              child: MaterialButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Do you forget passwoed",
                                    maxLines: 1,
                                  )),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blue[400],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: MaterialButton(
                                  onPressed: () async {
                                    if (kryform.currentState!.validate()) {
                                      try {
                                        looding = true;
                                        setState(() {});
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                          email: email.text,
                                          password: pasword.text,
                                        )
                                            .then((value) {
                                          looding = false;
                                          setState(() {});
                                        });

                                        if (FirebaseAuth.instance.currentUser!
                                            .emailVerified) {
                                          Navigator.of(context)
                                              .pushReplacementNamed("home");
                                        } else {
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.leftSlide,
                                            dialogType: DialogType.info,
                                            body: const Center(
                                              child: Text(
                                                "email valideet",
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            title: 'This is Ignored',
                                            desc: 'This is also Ignored',
                                            btnOkOnPress: () {},
                                          ).show();
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        looding = false;
                                        setState(() {});
                                        // showToast(
                                        //     message: e.toString(),
                                        //     state: ToastStates.ERROR,
                                        //     context: context);
                                        if (e.code == 'user-not-found') {
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.leftSlide,
                                            dialogType: DialogType.info,
                                            body: Center(
                                              child: Text(
                                                e.code.trim(),
                                                style: const TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            title: 'This is Ignored',
                                            desc: 'This is also Ignored',
                                            btnOkOnPress: () {},
                                          ).show();
                                        }

                                        if (e.code == 'wrong-password') {
                                          AwesomeDialog(
                                            context: context,
                                            animType: AnimType.leftSlide,
                                            dialogType: DialogType.info,
                                            body: const Center(
                                              child: Text(
                                                'Wrong password provided for that user.',
                                                style: TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            title: 'This is Ignored',
                                            desc: 'This is also Ignored',
                                            btnOkOnPress: () {},
                                          ).show();
                                        }
                                      } catch (e) {
                                        print(
                                            'qwertyuiop[1234567890-${e.toString()}');
                                      }
                                    } else {
                                      return;
                                    }
                                  },
                                  child: const Text(
                                    "login",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                height: 15,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: const Text(
                                  "data",
                                  style: TextStyle(),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blue,
                                    child: Image(
                                        image: AssetImage(
                                            'assets/images/facebook.png'))),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      signInWithGoogle().then((userCredential) {
                                        if (userCredential != null) {
                                          print(
                                              'User signed in: ${userCredential.user!.displayName}');
                                        } else {
                                          setState(() {});
                                          print('Sign-in canceled.');
                                        }
                                        Navigator.of(context)
                                            .pushReplacementNamed("home");
                                      }).catchError((r) {
                                        print(r.toString());
                                      });
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blue,
                                    child: Image(
                                        image: AssetImage(
                                            'assets/images/google.png')),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("have an account ?"),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('singind');
                                  },
                                  child: const Text(
                                    "regester",
                                    style: TextStyle(color: Colors.amberAccent),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )));
  }

  // Trigger the authentication flow
  final GoogleSignIn _googleSignIn = GoogleSignIn();

// Function to handle Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      looding = true;
      setState(() {});
      // Start the Google Sign-In process
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signIn().then((value) {
        looding = false;
        setState(() {});
        return null;
      });

      if (googleUser == null) {
        return null;
      }
      looding = true;
      setState(() {});

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential using the GoogleAuthProvider
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google Auth credentials
      return await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        print("xcvbnm,$value");
        looding = false;
        setState(() {});
        return null;
      });
    } catch (e) {
      looding = false;
      setState(() {});
      print('Google Sign-In error: $e');
      return null;
    }
  }

// Function to sign out
}
