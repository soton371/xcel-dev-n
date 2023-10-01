import 'package:flutter/material.dart';

Widget settingListTile(BuildContext context,
    {required String? title,
    required Color? leadingColor,
    required IconData? icon,
    void Function()? onTap}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 3),
    title: Text(
      "$title",
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    leading: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: leadingColor!.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(color: leadingColor)),
        child: Icon(icon, color: leadingColor)),
    trailing: Icon(
      Icons.arrow_forward_ios,
      color: Theme.of(context).colorScheme.outlineVariant,
      size: 18,
    ),
    onTap: onTap
  );
}
