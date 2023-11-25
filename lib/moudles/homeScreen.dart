import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new3/moudles/upScreen.dart';
import 'package:new3/notes/view.dart';
import 'package:new3/shared/cubit/cubit.dart';
import 'package:new3/shared/cubit/states.dart';

class homeScrren extends StatelessWidget {
  const homeScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (cotext, index) {},
        builder: (cotext, index) {
          // ignore: unused_local_variable
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.abc_sharp)),
                IconButton(
                    onPressed: () async {
                      GoogleSignIn google = GoogleSignIn();
                      google.disconnect();
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("email", (route) => false);
                    },
                    icon: const Icon(Icons.radio))
              ],
              title: const Text("login"),
            ),
            body: cubit.islooding
                ? Center(
                    child: Container(
                        child: const CircularProgressIndicator(
                      // semanticsLabel: "jhv",
                      color: Colors.green,
                      strokeWidth: 2,
                    )),
                  )
                : GridView.builder(
                    itemCount: cubit.dataa.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      //childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        cubit
                            .getNotedata(noteid: cubit.dataa[index].id)
                            .then((value) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => notes(
                                    id: cubit.dataa[index].id,
                                  )));
                        });
                      },
                      onLongPress: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          dialogType: DialogType.info,
                          body: const Center(
                            child: Text(
                              'اختر نوع التعديل .',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          title: 'Updata',
                          desc: 'اختر نوع التعديل',
                          btnCancelText: 'حذف',
                          btnCancelOnPress: () {
                            cubit.changislooding(g: false);
                            cubit
                                .delateget(id: cubit.dataa[index].id)
                                .then((value) {
                              cubit.changislooding(g: true);
                            }).catchError((d) {
                              cubit.changislooding(g: true);
                            });
                          },
                          btnOkText: "تعديل",
                          btnOkOnPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => upScraan(
                                docid: cubit.dataa[index].id,
                                oldname: cubit.dataa[index]["categories"],
                              ),
                            ));
                          },
                        ).show();
                      },
                      child: Container(
                        color: Colors.grey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/network.png',
                              color: Colors.amber,
                            ),
                            Text(
                              "${cubit.dataa[index]['categories']}",
                              style: const TextStyle(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("addscraan");
              },
              backgroundColor: Colors.blue,
              child: const Text(
                "add",
                style: TextStyle(fontSize: 10),
              ),
            ),
          );
        });
  }
}
