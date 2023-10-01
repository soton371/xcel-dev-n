import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';

import '../model/password_dto.dart';
import '../services/pass_service.dart';
import '../widgets/custom_button.dart';

class DialogChangePassword extends StatefulWidget {
  final PasswordChangeListener? listener;

  const DialogChangePassword({Key? key, this.listener}) : super(key: key);

  @override
  _DialogChangePassword createState() => _DialogChangePassword();
}

typedef PasswordChangeListener = void Function(bool isSuccess);

class _DialogChangePassword extends State<DialogChangePassword> {
  late PasswordDto passwordDto;
  final oldPassController = TextEditingController();
  final newPassCon = TextEditingController();
  final confirmPassCon = TextEditingController();
  String? confirmPass;
  String? message;
  bool isLoading = false;
  List<bool> hidePassword = [true,true,true];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    passwordDto = PasswordDto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        key: _scaffoldKey,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          height: 500,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              const Text(
                'Change Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(7.0),
                child: TextFormField(
                  scrollPadding: const EdgeInsets.all(2 * 0.41),
                  keyboardType: TextInputType.text,
                  onSaved: (input) => passwordDto.oldPassword = input ?? '',
                  controller: oldPassController,
                  validator: (input) => input != null && input.isEmpty
                      ? "Please Enter Old Password First"
                      : null,
                  obscureText: hidePassword[0],
                  decoration: InputDecoration(
                    hintText: "Type Your Current Password",
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12)),
                    prefixIcon: const Icon(Icons.lock, color: Colors.black12),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword[0] = !hidePassword[0];
                        });
                      },
                      color: Colors.black12.withOpacity(0.4),
                      icon: Icon(hidePassword[0]
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(7.0),
                child: TextFormField(
                  scrollPadding: const EdgeInsets.all(2 * 0.41),
                  keyboardType: TextInputType.text,
                  onSaved: (input) => passwordDto.newPassword = input ?? '',
                  controller: newPassCon,
                  validator: (input) =>
                      input != null && input.isNotEmpty && input.length < 3
                          ? "Password should be at least 3 characters"
                          : null,
                  obscureText: hidePassword[1],
                  decoration: InputDecoration(
                    hintText: "Type New Password",
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12)),
                    prefixIcon: const Icon(Icons.lock, color: Colors.black12),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword[1] = !hidePassword[1];
                        });
                      },
                      color: Colors.black12.withOpacity(0.4),
                      icon: Icon(hidePassword[1]
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(7.0),
                child: TextFormField(
                  scrollPadding: const EdgeInsets.all(2 * 0.41),
                  keyboardType: TextInputType.text,
                  onSaved: (input) => confirmPass = input,
                  controller: confirmPassCon,
                  validator: (input) => input != passwordDto.newPassword
                      ? "Password Didn't Match"
                      : null,
                  obscureText: hidePassword[2],
                  decoration: InputDecoration(
                    hintText: "Type Password Again",
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12)),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12)),
                    prefixIcon: const Icon(Icons.lock, color: Colors.black12),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword[2] = !hidePassword[2];
                        });
                      },
                      color: Colors.black12.withOpacity(0.4),
                      icon: Icon(hidePassword[2]
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
              ),
              message == null
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.all(15.0),
                      child: Text(
                        message ?? '',
                        style: TextStyle(
                          color: message!.contains("successfully")
                              ? Colors.green
                              : Colors.red,
                        ),
                      )),
              isLoading
                  ? Center(
                      child: Image.asset(
                        'assets/images/loader.gif',
                        height: 60,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              SizedBox(
                width: 180,
                child: CustomButton(
                  btnText: "Submit",
                  btnColor: Colors.orange,
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? oldPass = prefs.getString(prefUserPass);
                    String inputOldPass = oldPassController.text;
                    String inputNewPass = newPassCon.text;
                    String confirmPassCo = confirmPassCon.text;
                    if (inputOldPass.isEmpty) {
                      setState(() {
                        message = "Please Type Your Current Password";
                      });
                    } else if (inputOldPass != oldPass) {
                      setState(() {
                        message = "Old Password Didn't Match";
                      });
                    } else if (inputNewPass.isEmpty) {
                      setState(() {
                        message = "Please Type New Password";
                      });
                    } else if (confirmPassCo.isEmpty) {
                      setState(() {
                        message = "Please Type Password Again";
                      });
                    } else if (inputNewPass != confirmPassCo) {
                      setState(() {
                        message =
                            "New Password and Retyped Password Didn't Match";
                      });
                    } else if ((inputNewPass == inputOldPass) && (confirmPassCo == inputOldPass)) {
                      setState(() {
                        message =
                            "New Password and Old Password Are Same";
                      });
                    }
                    else {
                      setState(() {
                        message = null;
                      });
                      passwordDto.userLognId =
                          prefs.getString(prefUserNo) ?? '';
                      passwordDto.newPassword = inputNewPass;
                      passwordDto.oldPassword = inputOldPass;
                      isLoading = true;
                      PassService()
                          .changePassword(passwordDto)
                          .then((value) async {
                        var msg = value['P_RETURNMSG'];
                        setState(() {
                          message = msg;
                        });
                        isLoading = false;
                        debugPrint("'Pass response=>' + $msg");
                        if (msg.contains("successfully") &&
                            widget.listener != null) {
                          widget.listener!(true);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(prefUserPass, inputNewPass);
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
