import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new3/shared/compoenents/textFormFaild.dart';
import 'package:new3/shared/cubit/cubit.dart';
import 'package:new3/shared/cubit/states.dart';

// ignore: must_be_immutable
class upScraan extends StatefulWidget {
  final String docid;
  String oldname;

  upScraan({super.key, required this.docid, required this.oldname});

  @override
  State<upScraan> createState() => _upScraanState();
}

class _upScraanState extends State<upScraan> {
  TextEditingController upp = TextEditingController();

  var form = GlobalKey<FormFieldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    upp.text = widget.oldname;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (cotext, index) {},
        builder: (cotext, index) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: cubit.islooding
                ? Container(child: const CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFiledd(
                          key: form,
                          controller: upp,
                          hinitText: 'upp',
                          adrres: 'Add',
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
                                cubit.changislooding(g: false);
                                //  if (form.currentState!.validate()) {
                                cubit
                                    .upData(id: widget.docid, name: upp.text)
                                    .then((value) {
                                  cubit.getdata();
                                  cubit.changislooding(g: false);

                                  Navigator.of(context).pop();
                                }).catchError((roo) {
                                  cubit.changislooding(g: true);
                                });
                                //} else {
                                //return;j
                                //}
                              },
                              icon: const Icon(Icons.access_alarms_rounded)),
                        )
                      ],
                    ),
                  ),
          );
        });
  }
}
