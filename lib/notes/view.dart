import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new3/notes/updata.dart';
import 'package:new3/shared/cubit/cubit.dart';
import 'package:new3/shared/cubit/states.dart';

class notes extends StatelessWidget {
  final String id;
  const notes({super.key, required this.id});

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
              ],
              title: const Text("notes"),
            ),
            body: WillPopScope(
              onWillPop: () async {
                Navigator.of(context).pushNamed('addscraan');
                return Future.value(true);
              },
              child: cubit.islooding
                  ? Center(
                      child: Container(
                          child: const CircularProgressIndicator(
                        // semanticsLabel: "jhv",
                        color: Colors.green,
                        strokeWidth: 2,
                      )),
                    )
                  : GridView.builder(
                      itemCount: cubit.notes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        //childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return UpNoteScraan(
                              Noteid: cubit.notes[index].id,
                              id: id,
                            );
                          }));
                        },
                        onDoubleTap: () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            dialogType: DialogType.info,
                            body: const Center(
                              child: Text(
                                "هل متاكد من انك تريد الحذف",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            title: 'note',
                            btnOkIcon: Icons.accessible_forward,
                            desc: 'This is also Ignored',
                            btnOkOnPress: () {
                              cubit
                                  .daletUpdata(
                                      id: id, idNote: cubit.notes[index].id)
                                  .then((value) {
                                cubit.getNotedata(noteid: id);
                              }).catchError((tyu) {});
                            },
                          ).show();
                        },
                        child: Container(
                          color: Colors.grey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset(
                              // 'assets/images/network.png',
                              //color: Colors.amber,
                              //   ),
                              Text(
                                "${cubit.notes[index]['note']}",
                                style: const TextStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          );
        });
  }
}
