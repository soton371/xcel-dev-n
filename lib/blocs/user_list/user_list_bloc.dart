import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/user_list_mod.dart';
part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  List<UserListModel> userList = [];
  UserListBloc() : super(UserListInitial()) {
    on<CallUserListApi>((event, emit) async {
      debugPrint("call CallUserListApi");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String patientId = prefs.getInt(prefUserId).toString();
      Uri url = Uri.parse(patlistsUrl);
      Map body = {"P_PATIENTID": patientId};
      try {
        final response = await http.post(url, body: body);
        if (response.statusCode != 200) {
          emit(UserListFailed());
          debugPrint(
              "CallUserListApi response.statusCode: ${response.statusCode}");
          return;
        }
        final data = json.decode(response.body);
        String jsonString = json.encode(data['P_RETRNMSG1']).toString();
        userList = userListModelFromJson(jsonString);
        emit(UserListDone(userList));
        debugPrint("CallUserListApi userList size: ${userList.length}");
      } catch (e) {
        debugPrint("CallUserListApi e: $e");
        emit(UserListFailed());
      }
    });
  }
}
