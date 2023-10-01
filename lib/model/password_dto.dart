

class PasswordDto  {
  String? userLognId;
  String? oldPassword;
  String? newPassword;

  PasswordDto ({this.userLognId, this.oldPassword, this.newPassword});

  PasswordDto.fromJson(Map<String, dynamic> json) {
    userLognId = json['P_USRLOGNID'];
    oldPassword = json['P_OLDUSRPWD'];
    newPassword = json['P_NEWUSRPWD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['P_USRLOGNID'] = userLognId;
    data['P_OLDUSRPWD'] = oldPassword;
    data['P_NEWUSRPWD'] = newPassword;
    return data;
  }
}
