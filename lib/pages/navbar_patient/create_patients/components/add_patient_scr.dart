import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/lookup_model.dart';
import 'package:xcel_medical_center/pages/navbar_patient/create_patients/create_patients_scr.dart';
import 'package:xcel_medical_center/services/create_patient.dart';
import 'package:xcel_medical_center/services/profile_image_service.dart';
import 'package:xcel_medical_center/widgets/custom_button.dart';
import 'package:xcel_medical_center/widgets/my_alert.dart';
import 'package:xcel_medical_center/widgets/my_loader.dart';
import 'package:xcel_medical_center/widgets/show_snack.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({
    super.key,
    required this.bloodGroupList,
    required this.genderList,
    required this.relationList,
    required this.religionList,
    required this.maritalList,
    required this.countryList,
  });
  final List<Country> relationList, religionList, maritalList, countryList;
  final List<Blood> bloodGroupList, genderList;

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  File? _image;
  Set<Blood> selectGender = {Blood(rId: "M", rName: "Male")};
  String genderIsSelected = '';
  Set<String> selectIdentity = {"NID"};
  Set<Country> selectMaritalStatus = {Country(rId: 1, rName: "Single")};
  String maritalStatusIsSelected = '';
  String selectBlood = "Select";
  Country selectReligion = Country(rId: 0, rName: "Select");
  String selectData = "Select Birth Day";
  Country selectedNationality = Country(rId: 0, rName: "Select");
  Country selectedRelation = Country(rId: 0, rName: "Select");
  TextEditingController voterId = TextEditingController();
  TextEditingController nId = TextEditingController();
  TextEditingController passport = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String completeNumber = '';
  TextEditingController email = TextEditingController();
  TextEditingController occupation = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int buttonClick = 0;
  bool canFocus = false;
  String nameValidatorMsg(String value) {
    if (value.trim().isEmpty) {
      return "Please enter full name";
    } else if (RegExp(r'\d').hasMatch(value)) {
      return "Please avoid numeric number";
    } else if (3 > value.length || value.length > 50) {
      return "Minimum 3 and maximum 50 characters are allowed";
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Country> countryList = widget.countryList;
    countryList.sort((a,b)=>(a.rId ?? 0).compareTo(b.rId ?? 0));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Create Patient'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CreatePatientScreen()));
              },
              icon: const Icon(CupertinoIcons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //start edit image
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(_image!),
                                )
                              : const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage("assets/images/avatar.png"),
                                ),
                          const CircleAvatar(
                            radius: 3,
                            child: Icon(
                              CupertinoIcons.staroflife_fill,
                              color: CupertinoColors.systemRed,
                              size: 8,
                            ),
                          )
                        ],
                      ),
                      CircleAvatar(
                        child: IconButton(
                            onPressed: () {
                              _showImagePicker(context);
                            },
                            icon: const Icon(CupertinoIcons.pencil)),
                      )
                    ],
                  ),
                ),
                _image == null && buttonClick > 0
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Please choose image',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .fontSize,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                //end edit image
                const SizedBox(
                  height: 30,
                ),

                //start Nid/Passport
                Center(
                  child: SegmentedButton<String>(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    onSelectionChanged: (value) {
                      setState(() {
                        selectIdentity = value;
                      });
                    },
                    segments: const <ButtonSegment<String>>[
                      ButtonSegment<String>(
                        value: "Voter ID",
                        label: Text("Voter ID"),
                      ),
                      ButtonSegment<String>(
                        value: "NID",
                        label: Text("NID"),
                      ),
                      ButtonSegment<String>(
                          value: 'Passport', label: Text('Passport')),
                    ],
                    selected: selectIdentity,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: chooseIdentity(),
                  focusNode: FocusNode(canRequestFocus: canFocus),
                  validator: (value) {
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Please Provide ${selectIdentity.first} No *",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),
                chooseIdentity().text.isEmpty && buttonClick > 0
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Please enter ${selectIdentity.first.toLowerCase()} no",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                          ),
                        ),
                      )
                    : const SizedBox(),
                //end Nid/Passport

                //start Full Name
                Row(
                  children: [
                    Text(
                      '\nFull Name',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(
                      CupertinoIcons.staroflife_fill,
                      color: CupertinoColors.systemRed,
                      size: 8,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: fullName,
                  focusNode: FocusNode(canRequestFocus: false),
                  validator: (value) {
                    return null;
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
                nameValidatorMsg(fullName.text).isNotEmpty && buttonClick > 0
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          nameValidatorMsg(fullName.text),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                          ),
                        ),
                      )
                    : const SizedBox(),
                //end Full Name

                //start Gender
                Row(
                  children: [
                    Text(
                      '\nGender',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(
                      CupertinoIcons.staroflife_fill,
                      color: CupertinoColors.systemRed,
                      size: 8,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SegmentedButton<Blood>(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  onSelectionChanged: (value) {
                    genderIsSelected = '${value.first.rId}';
                    setState(() {
                      selectGender = value;
                    });
                  },
                  segments: widget.genderList
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
                  selected: selectGender,
                ),
                genderIsSelected.isEmpty && buttonClick > 0
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Please select gender',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                          ),
                        ),
                      )
                    : const SizedBox(),
                //end Gender

                //start blood group
                Text(
                  '\nBlood Group',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
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
                          selectBlood,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                  onSelected: (value) {
                    setState(() {
                      selectBlood = value;
                    });
                  },
                  itemBuilder: (BuildContext bc) {
                    return widget.bloodGroupList
                        .map((e) => PopupMenuItem<String>(
                              value: e.rName,
                              child: Text(e.rName ?? ''),
                            ))
                        .toList();
                  },
                ),
                //end blood group

                //start Religion
                Text(
                  '\nReligion',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                PopupMenuButton(
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
                          selectReligion.rName ?? '',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                  onSelected: (value) {
                    setState(() {
                      selectReligion = value;
                    });
                  },
                  itemBuilder: (BuildContext bc) {
                    return widget.religionList
                        .map(
                          (e) => PopupMenuItem(
                            value: e,
                            child: Text(e.rName ?? ''),
                          ),
                        )
                        .toList();
                  },
                ),
                //end Religion

                //start Marital Status
                Row(
                  children: [
                    Text(
                      '\nMarital Status',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(
                      CupertinoIcons.staroflife_fill,
                      color: CupertinoColors.systemRed,
                      size: 8,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SegmentedButton<Country>(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  onSelectionChanged: (value) {
                    maritalStatusIsSelected = "${value.first.rId}";
                    setState(() {
                      selectMaritalStatus = value;
                    });
                  },
                  segments: widget.maritalList
                      .map((e) => ButtonSegment<Country>(
                            value: e,
                            label: SizedBox(
                                width: double.maxFinite,
                                child: Text(
                                  e.rName ?? '',
                                  textAlign: TextAlign.center,
                                )),
                          ))
                      .toList(),
                  selected: selectMaritalStatus,
                ),
                maritalStatusIsSelected.isEmpty && buttonClick > 0
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Please select marital status',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                          ),
                        ),
                      )
                    : const SizedBox(),
                //end Marital Status

                //start date of birth
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\nDate of Birth',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 36500)),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          String formateDate =
                              DateFormat("dd-MMM-yyyy").format(pickedDate);
                          setState(() {
                            selectData = formateDate;
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
                              selectData,
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

                //start phone number
                Row(
                  children: [
                    Text(
                      '\nPhone No:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(
                      CupertinoIcons.staroflife_fill,
                      color: CupertinoColors.systemRed,
                      size: 8,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                IntlPhoneField(
                  focusNode: FocusNode(canRequestFocus: canFocus),
                  controller: phoneNumber,
                  invalidNumberMessage: "",
                  onChanged: (value) {
                    completeNumber = value.completeNumber;
                  },
                  //for validation setup here
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  initialCountryCode: "GH",
                ),
                phoneValid(phoneNumber.text.trim()).isNotEmpty &&
                        buttonClick > 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          phoneValid(phoneNumber.text.trim()),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize:
                                Theme.of(context).textTheme.bodySmall!.fontSize,
                          ),
                        ),
                      )
                    : const SizedBox(),
                //end phone number

                //start E-mail
                Text(
                  '\nE-mail',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: email,
                  focusNode: FocusNode(canRequestFocus: canFocus),
                  validator: (input) {
                    if (input != null &&
                        input.isNotEmpty &&
                        !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(input)) {
                      return 'Please enter valid email';
                    } else {
                      return null;
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
                //end E-mail

                //start Nationality
                Text(
                  '\nNationality',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownSearch<Country>(
                  popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      searchDelay: Duration(milliseconds: 10),
                      searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                              hintText: "Search for Nationality here",
                              border: OutlineInputBorder()))),
                  items: countryList,
                  itemAsString: (item) => item.rName ?? '',
                  onChanged: (v) {
                    if (v == null) {
                      return;
                    }
                    setState(() {
                      selectedNationality = v;
                    });
                  },
                  selectedItem: selectedNationality,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: Theme.of(context).textTheme.labelLarge,
                      dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.surfaceVariant,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none))),
                ),
                //end Nationality

                //start Occupation
                Text(
                  '\nOccupation',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: occupation,
                  keyboardType: TextInputType.name,
                  focusNode: FocusNode(canRequestFocus: canFocus),
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),
                //end Occupation

                //start Relation
                Text(
                  '\nRelation with logged-in user',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                PopupMenuButton<Country>(
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
                          selectedRelation.rName ?? '',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                  onSelected: (value) {
                    setState(() {
                      selectedRelation = value;
                    });
                  },
                  itemBuilder: (BuildContext bc) {
                    return widget.relationList
                        .map((e) => PopupMenuItem<Country>(
                              value: e,
                              child: Text(e.rName ?? ''),
                            ))
                        .toList();
                  },
                ),
                //end Relation
                const SizedBox(
                  height: 50,
                ),

                CustomButton(
                  btnText: "Submit",
                  btnColor: cViolet,
                  onTap: () {
                    setState(() {
                      buttonClick++;
                    });

                    var ttt = _formKey.currentState;
                    if (ttt == null) {
                      return;
                    }

                    if (!ttt.validate()) {
                      myToast("Please fill in the required fields");
                      return;
                    }

                    if (_image == null) {
                      myToast("Please choose image");
                      return;
                    }

                    //add for chooseIdentity
                    if (chooseIdentity().text.trim().isEmpty) {
                      myToast("Please enter identity number");
                      return;
                    }
                    //end for chooseIdentity

                    //add for full name
                    if (fullName.text.trim().isEmpty) {
                      myToast("Please enter name");
                      return;
                    }
                    if (RegExp(r'\d').hasMatch(fullName.text.trim())) {
                      myToast("Please avoid numeric number");
                      return;
                    } else if (3 > fullName.text.trim().length ||
                        fullName.text.trim().length > 50) {
                      myToast(
                          "Minimum 3 and maximum 50 characters are allowed");
                      return;
                    }
                    //end for full name

                    if (genderIsSelected.isEmpty ||
                        maritalStatusIsSelected.isEmpty) {
                      myToast("Please fill in the required fields");
                      return;
                    }
                    if (email.text.isNotEmpty &&
                        !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(email.text)) {
                      myToast("Please enter valid email");
                      return;
                    }

                    //start for phone number
                    if (phoneNumber.text.trim().isEmpty) {
                      myToast("Please enter valid phone number");
                      return;
                    } else if (7 > phoneNumber.text.trim().length) {
                      myToast("Minimum 7 digits are allowed");
                      return;
                    } else if (RegExp(r'[.,]')
                        .hasMatch(phoneNumber.text.trim())) {
                      myToast("Please enter valid phone number");
                      return;
                    }

                    myLoader(context);
                    profileImageService(_image?.path ?? '').then((value) {
                      var res = value.listResponse;
                      if (value.statusCode == 200 &&
                          res != null &&
                          res.isNotEmpty) {
                        createPatient(
                                patientName: fullName.text,
                                dob: selectData == "Select Birth Day"
                                    ? ''
                                    : selectData,
                                genderNo: selectGender ==
                                        {Blood(rId: "M", rName: "Male")}
                                    ? ''
                                    : selectGender.first.rId ?? '',
                                bloodNo:
                                    selectBlood == "Select" ? '' : selectBlood,
                                religionId: selectReligion ==
                                        Country(rId: 0, rName: "Select")
                                    ? ''
                                    : "${selectReligion.rId}",
                                maritalStatusId: selectMaritalStatus ==
                                        {Country(rId: 1, rName: "Single")}
                                    ? ''
                                    : "${selectMaritalStatus.first.rId}",
                                nId: nId.text,
                                passportNo: passport.text,
                                voterId: voterId.text,
                                mobileNo: completeNumber,
                                email: email.text,
                                ocupation: occupation.text,
                                relationId: selectedRelation ==
                                        Country(rId: 0, rName: "Select")
                                    ? ''
                                    : "${selectedRelation.rId}",
                                countryId: selectedNationality ==
                                        Country(rId: 0, rName: "Select")
                                    ? ''
                                    : "${selectedNationality.rId}",
                                photoLoca: res[0].filePath ?? '')
                            .then((value) {
                          if (value) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Success"),
                                content:
                                    const Text("Patient creation succeeded"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const CreatePatientScreen()));
                                    },
                                    child: const Text("okay"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            myAlertDialog(context,
                                titleMsg: "Failed",
                                contentMsg: "Patient creation failed",
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("okay"),
                                  ),
                                ]);
                          }
                        });
                      } else {
                        myAlertDialog(context,
                            titleMsg: "Failed",
                            contentMsg: "Patient creation failed",
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("okay"),
                              ),
                            ]);
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //add all method
  Future<void> _pickImage(ImageSource source, context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
    Navigator.pop(context); // Close the bottom sheet
  }

  Future<void> _showImagePicker(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery, context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController chooseIdentity() {
    if (selectIdentity.first == "NID") {
      return nId;
    } else if (selectIdentity.first == 'Passport') {
      return passport;
    } else if (selectIdentity.first == "Voter ID") {
      return voterId;
    } else {
      return TextEditingController();
    }
  }

  String phoneValid(String value) {
    if (value.isEmpty) {
      return "Please enter valid phone number";
    } else if (7 > value.length) {
      return "Minimum 7 digits are allowed";
    } else if (RegExp(r'[.,]').hasMatch(value)) {
      return "Please enter valid phone number";
    } else {
      return '';
    }
  }
}
