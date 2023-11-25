import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new3/notes/view.dart';
import 'package:new3/shared/compoenents/textFormFaild.dart';
import 'package:new3/shared/cubit/cubit.dart';
import 'package:new3/shared/cubit/states.dart';

// ignore: must_be_immutable
class UpNoteScraan extends StatelessWidget {
  final String Noteid;
  final String id;

  UpNoteScraan({super.key, required this.Noteid, required this.id});

  TextEditingController upNote = TextEditingController();
  var form = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (cotext, index) {},
        builder: (cotext, index) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
              appBar: AppBar(),
              body: WillPopScope(
                  child: cubit.islooding
                      ? Center(
                          child: Container(
                              child: const CircularProgressIndicator()))
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormFiledd(
                                key: form,
                                controller: upNote,
                                hinitText: 'upNote',
                                adrres: 'upNote',
                                validate: (value) {
                                  if (value == "") {
                                    return "add";
                                  }
                                  return null;
                                },
                                onprassed: null,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                color: Colors.red,
                                width: double.infinity,
                                child: IconButton(
                                    onPressed: () {
                                      cubit.changislooding(g: true);
                                      // if (form.currentState!.validate()) {
                                      cubit
                                          .upNoteData(
                                              id: id,
                                              idNote: Noteid,
                                              name: upNote.text)
                                          .then((value) {
                                        //cubit.changislooding(g: true);

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return notes(
                                            id: id,
                                          );
                                        }));
                                      }).catchError((lkjb) {
                                        cubit.changislooding(g: true);
                                      });
                                      //  } else {
                                      //   return;
                                      //   }
                                    },
                                    icon: const Icon(
                                        Icons.access_alarms_rounded)),
                              )
                            ],
                          ),
                        ),
                  onWillPop: () async {
                    notes(
                      id: id,
                    );
                    return true;
                  }));
        });
  }
}
