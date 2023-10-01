import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xcel_medical_center/blocs/lookup/lookup_bloc.dart';
import 'package:xcel_medical_center/model/lookup_model.dart';
import 'package:xcel_medical_center/pages/navbar_patient/edit_profile/profile_view.dart';
import 'package:xcel_medical_center/services/edit_profile_ser.dart';
import 'package:xcel_medical_center/utils/get_user_info.dart';
import 'package:xcel_medical_center/widgets/my_alert.dart';
import 'package:xcel_medical_center/widgets/my_loader.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _editMode = false;
  TextEditingController? _nameController;
  TextEditingController? _contactController;
  TextEditingController? _mailController;
  String _name = '';
  String _number = '';
  String _mail = '';
  List<Blood> _bloodGroupList = [];
  String _selectBlood = "";
  String _preBlood = "";
  String _selectData = "";
  String _preData = '';
  String userGender = '';
  Set<Blood> _selectGender = {Blood(rId: "M", rName: "Male")};
  List<Blood> _genderList = [];
  //add for image
  String previewImgUrl = '';

  @override
  void initState() {
    getUserInfo().then((value) {
      setState(() {
        _name = value.patientName ?? '';
        _number = value.patientMob ?? '';
        _mail = value.patientEmail ?? '';
        _nameController = TextEditingController(text: _name);
        _contactController = TextEditingController(text: _number);
        _mailController = TextEditingController(text: _mail);
        _preBlood = value.bloodGroup ?? '';
        _selectBlood = _preBlood;
        _preData = value.dob ?? '';
        _selectData = _preData;
        userGender = value.gender ?? '';
        _genderList = context.read<LookupBloc>().genderList;
        _selectGender =
            _genderList.where((element) => element.rName == userGender).toSet();
        previewImgUrl = value.userPhoto ?? '';
      });
    });
    _bloodGroupList = context.read<LookupBloc>().bloodGroup;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              if (_editMode) {
                getUserInfo().then((value) {
                  _name = value.patientName ?? '';
                  _number = value.patientMob ?? '';
                  _mail = value.patientEmail ?? '';
                  _preBlood = value.bloodGroup ?? '';
                  _preData = value.dob ?? '';
                  userGender = value.gender ?? '';
                  if (_nameController!.text == _name &&
                          _contactController!.text == _number &&
                          _mailController!.text == _mail &&
                          _selectBlood == _preBlood &&
                          _selectData == _preData &&
                          _selectGender.first.rName == userGender
                      ) {
                    setState(() {
                      _editMode = !_editMode;
                    });
                    return;
                  }
                  var ttt = _formKey.currentState;
                  if (ttt == null) {
                    return;
                  }
                  if (!ttt.validate()) {
                    return;
                  }
                  myLoader(context);
                  editProfile(
                          patientName: _nameController != null
                              ? _nameController!.text
                              : "",
                          mobileNo: _contactController != null
                              ? _contactController!.text
                              : "",
                          mail: _mailController != null
                              ? _mailController!.text
                              : "",
                          blood: _selectBlood,
                          dob: _selectData,
                          gender: _selectGender,
                          photoPath: '',
                          previewPhotoUrl: previewImgUrl)
                      .then((value) {
                    if (value) {
                      myAlertDialog(context,
                          titleMsg: "Success",
                          contentMsg: "Profile Update Successful",
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  setState(() {
                                    _editMode = !_editMode;
                                  });
                                },
                                child: const Text("Okay"))
                          ]);
                    } else {
                      myAlertDialog(context,
                          titleMsg: "Failed",
                          contentMsg: "Profile Update failed",
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("Okay"))
                          ]);
                    }
                  });
                });
              } else {
                setState(() {
                  _editMode = !_editMode;
                });
              }
            },
            icon: Icon(_editMode ? Icons.done : CupertinoIcons.pencil),
          )
        ],
      ),
      body: _editMode ? profileEdit() : const ProfileView(),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget profileEdit() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //start edit Name
              Row(
                children: [
                  Text(
                    '\nFull Name',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.redAccent,
                  )
                ],
              ),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return "This field cannot be empty";
                  }
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
              ),
              //end edit Name

              //start edit contact
              Row(
                children: [
                  Text(
                    '\nContact',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.redAccent,
                  )
                ],
              ),
              TextFormField(
                controller: _contactController,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    return null;
                  } else {
                    return "This field cannot be empty";
                  }
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
              ),
              //end edit contact

              //start edit email
              Text(
                '\nEmail',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextFormField(
                controller: _mailController,
                validator: (value) {
                  if (value != null && value.trim().isEmpty) {
                    return null;
                  } else if (value != null &&
                      RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                    return null;
                  } else {
                    return 'Please enter valid email';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                ),
              ),
              //end edit email

              //start blood group
              Text(
                '\nBlood Group',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              PopupMenuButton<String>(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectBlood,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
                onSelected: (value) {
                  setState(() {
                    _selectBlood = value;
                  });
                },
                itemBuilder: (BuildContext bc) {
                  return _bloodGroupList
                      .map((e) => PopupMenuItem<String>(
                            value: e.rId,
                            child: Text(e.rName ?? ''),
                          ))
                      .toList();
                },
              ),
              //end blood group

              //start date of birth
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\nDate of Birth',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  InkWell(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _preData.isNotEmpty
                              ? DateFormat("dd-MMM-yyyy").parse(_preData)
                              : DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 36500)),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        String formateDate =
                            DateFormat("dd-MMM-yyyy").format(pickedDate);
                        setState(() {
                          _selectData = formateDate;
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectData,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const Icon(CupertinoIcons.calendar)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //end date of birth

              //start Gender
              Row(
                children: [
                  Text(
                    '\nGender',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.redAccent,
                  )
                ],
              ),
              SegmentedButton<Blood>(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                onSelectionChanged: (value) {
                  setState(() {
                    _selectGender = value;
                  });
                },
                segments: _genderList
                    .map(
                      (e) => ButtonSegment<Blood>(
                        value: e,
                        label: SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              e.rName ?? '',
                              textAlign: TextAlign.center,
                            )),
                      ),
                    )
                    .toList(),
                selected: _selectGender,
              ),

              //end Gender
            ],
          ),
        ),
      ),
    );
  }
}
