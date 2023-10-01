import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/utils/get_user_info.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? patientName,
      patientContact,
      patientPhoto,
      patientEmail,
      userPassport,
      dob,
      bloodGroup,
      gender;

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {
        patientName = value.patientName ?? '';
        patientContact = value.patientMob ?? '';
        patientPhoto = value.patientPhoto ?? '';
        patientEmail = value.patientEmail ?? '';
        userPassport = value.userPass ?? '';
        dob = value.dob ?? '';
        bloodGroup = value.bloodGroup ?? '';
        gender = value.gender ?? '';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              imageUrl: patientPhoto ?? '',
              placeholder: (context, url) => Image.asset(
                "assets/images/avatar.png",
                height: 70,
                width: 60,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/avatar.png",
                height: 70,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Personal Details\n",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  patientContact ?? '',
                  style: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "\nPersonal Information",
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(),
          Row(
            children: [
              infoTile(context, 'Mail', patientEmail ?? ''),
              const SizedBox(width: 8,),
              infoTile(context, 'Blood Group', bloodGroup ?? ''),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              infoTile(context, 'Date of Birth', dob ?? ''),
              infoTile(context, 'Gender', gender ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}

Widget infoTile(context, String level, String value) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          level,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
              color: Colors.blueGrey),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.black54),
        )
      ],
    ),
  );
}
