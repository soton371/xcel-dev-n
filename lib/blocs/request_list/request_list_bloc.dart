import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/request_list_mod.dart';
import 'package:http/http.dart' as http;
part 'request_list_event.dart';
part 'request_list_state.dart';

class RequestListBloc extends Bloc<RequestListEvent, RequestListState> {
  RequestListBloc() : super(RequestListInitial()) {
    on<CallRequestList>((event, emit) async {
      debugPrint("call CallRequestList");
      final Uri url = Uri.parse(rltnstusUrl);
      final String body = json.encode({"P_PATIENTID": event.userId});
      try {
        final response = await http.post(url,
            headers: {"Content-Type": "application/json"}, body: body);
        if (response.statusCode != 200) {
          emit(RequestListFailed("Oops ${response.statusCode}.."));
          debugPrint(
              "CallRequestList response.statusCode: ${response.statusCode}");
          return;
        }
        
        final requestListModel = requestListModelFromJson(response.body);
        if (requestListModel.pRetrnmsg1 != null &&
            requestListModel.pRetrnmsg1!.isNotEmpty) {
          List<PRetrnmsg1> requestLists = requestListModel.pRetrnmsg1 ?? [];
          emit(RequestListDone(requestLists));
          debugPrint("requestLists length: ${requestLists.length}");
        } else {
          emit(const RequestListFailed("No requests yet.."));
        }
      } catch (e) {
        emit(const RequestListFailed("Maybe something went wrong.."));
        debugPrint("CallRequestList e: $e");
      }
    });
  }
}
