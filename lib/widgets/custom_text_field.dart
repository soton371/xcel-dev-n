import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    @required this.nameController,
    @required this.labeltext,
    @required this.inputType,
    this.readOnly = false,
    this.horizontalPadding = 0.0,
  }) : super(key: key);

  final TextEditingController? nameController;
  final String? labeltext;
  final bool readOnly;
  final double horizontalPadding;
  final String? inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        // height: 50,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: TextFormField(
          controller: nameController,
          keyboardType: TYPE_NUMBER == inputType ? TextInputType.number : TYPE_PHONE == inputType ? const TextInputType.numberWithOptions(signed: false,decimal: false) : TextInputType.text,
          onFieldSubmitted: (String value) {
            nameController?.text = value;
          },
          readOnly: readOnly,
          validator: (value) => (value??'').isEmpty ? '* required' : null,
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: primaryColor),
            ),
            border: const OutlineInputBorder(),
            labelText: '$labeltext',
          ),
        ),
      ),
    );
  }
}
