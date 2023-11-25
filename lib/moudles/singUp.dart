import 'package:flutter/material.dart';
import 'package:new3/shared/compoenents/dauildMateral.dart';
import 'package:new3/shared/compoenents/textFormFaild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  var email = TextEditingController();
  var password = TextEditingController();
  var keyform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: keyform,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const dauilMateral(),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Register",
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
                          style:
                              TextStyle(fontSize: 25, color: Colors.grey[400]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormFiledd(
                          validate: (value) {
                            if (value == "") {
                              return "email is empty";
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
                                return "password is empty";
                              } else {
                                return null;
                              }
                            },
                            controller: password,
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: MaterialButton(
                              onPressed: () async {
                                if (keyform.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text,
                                    );
                                    FirebaseAuth.instance.currentUser!
                                        .sendEmailVerification();
                                    Navigator.of(context)
                                        .pushReplacementNamed('email');
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      // ignore: use_build_context_synchronously
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.leftSlide,
                                        dialogType: DialogType.info,
                                        body: const Center(
                                          child: Text(
                                            'the paswword is so weesk.',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        title: 'This is Ignored',
                                        desc: 'This is also Ignored',
                                        btnOkOnPress: () {},
                                      ).show();
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      // ignore: use_build_context_synchronously
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.leftSlide,
                                        dialogType: DialogType.info,
                                        body: const Center(
                                          child: Text(
                                            'The account already exists for that email.',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        title: 'This is Ignored',
                                        desc: 'This is also Ignored',
                                        btnOkOnPress: () {},
                                      ).show();

                                      print(
                                          'The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                } else {
                                  return;
                                }
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("have an account ?"),
                            MaterialButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('email');
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
}
