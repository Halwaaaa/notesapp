import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new3/shared/cubit/cubit.dart';
import 'package:new3/shared/cubit/states.dart';

import '../shared/compoenents/textFormFaild.dart';

class homelayput extends StatelessWidget {
  const homelayput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        var keyform = GlobalKey<ScaffoldState>();
        TextEditingController age = TextEditingController();
        TextEditingController name = TextEditingController();
        TextEditingController mony = TextEditingController();
        return Scaffold(
          key: keyform,
          appBar: AppBar(
            title: const Text("firebase"),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                //cubit.Cangedbootem();

                if (cubit.showBottem) {
                  keyform.currentState
                      ?.showBottomSheet((context) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            TextFormFiledd(
                              controller: age,
                              hinitText: 'age',
                              adrres: 'Age',
                              onprassed: null,
                              validate: null,
                              types: TextInputType.number,
                            ),
                            TextFormFiledd(
                              controller: name,
                              hinitText: "name",
                              adrres: "Namw",
                              validate: null,
                              onprassed: null,
                              types: TextInputType.text,
                            ),
                            TextFormFiledd(
                              controller: mony,
                              hinitText: "many",
                              adrres: "mmm",
                              validate: null,
                              onprassed: null,
                              types: TextInputType.name,
                            )
                          ]),
                        );
                        // ignore: dead_code
                        cubit.Cangedbootem(g: false);
                      }
                          //  cubit.Cangedbootem(g: false);

                          )
                      .closed
                      .then((d) {
                        cubit
                            .addnew(
                                name: name.text,
                                many: int.parse(age.text),
                                age: int.parse(mony.text))
                            .then((value) => {cubit.Cangedbootem(g: true)});
                      });
                  // cubit.Cangedbootem(g: false);
                } else {
                  // cubit.addnew(name: name.text, many: 3, age: 5).then((value) {
                  //cubit.Cangedbootem(g: true);
                  // });
                }
              }),
          body: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onDoubleTap: () {
                        cubit.daltenew(id: index);
                      },
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${cubit.New[index]['name']}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    //mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "${cubit.New[index]['age']}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 190,
                                      ),
                                      Text(
                                        "${cubit.New[index]['many']}",
                                        //textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                );
              },
              itemCount: cubit.New.length),
        );
      },
    );
  }
}
