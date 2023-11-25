import 'package:flutter/material.dart';

class TextFormFiledd extends StatelessWidget {
  final TextEditingController controller;
  final String hinitText;
  final String adrres;
  final Icon? suffico;
  final onprassed;
  final validate;
  final TextInputType? types;

  const TextFormFiledd(
      {super.key,
      required this.controller,
      required this.hinitText,
      required this.adrres,
      this.suffico,
      this.types,
      required this.validate,
      required this.onprassed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          adrres,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: types,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validate,
          onTap: onprassed,
          style: const TextStyle(fontSize: 25),
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: suffico,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            filled: true,
            fillColor: Colors.grey[200],
            hintText: hinitText,
            hintStyle: const TextStyle(color: Colors.amber, fontSize: 25),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                style: BorderStyle.solid,
                color: Colors.deepOrangeAccent,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
