import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcel_medical_center/blocs/request_list/request_list_bloc.dart';
import 'package:xcel_medical_center/blocs/user_list/user_list_bloc.dart';
import 'package:xcel_medical_center/pages/navbar_patient/tag_request/components/add_tag_request.dart';
import 'package:xcel_medical_center/pages/navbar_patient/tag_request/components/empty_request.dart';
import 'package:xcel_medical_center/pages/navbar_patient/tag_request/components/request_list.dart';

class TagRequestScreen extends StatelessWidget {
  const TagRequestScreen({super.key, required this.performerId});
  final String performerId;

  @override
  Widget build(BuildContext context) {
    context.read<UserListBloc>().add(CallUserListApi());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tag Request"),
        automaticallyImplyLeading: true,
      ),
      body: BlocBuilder<RequestListBloc, RequestListState>(
          builder: (context, state) {
        if (state is RequestListFailed) {
          return EmptyRequest(message: state.msg);
        } else if (state is RequestListDone) {
          return RequestList(
            requestLists: state.requestLists,
            performerId: performerId,
          );
        }
        return Center(
          child: Image.asset(
            'assets/images/loader.gif',
            height: 100,
          ),
        );
      }),
      floatingActionButton:
          BlocBuilder<UserListBloc, UserListState>(builder: (context, state) {
        if (state is UserListDone && state.userList.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>  AddTagRequestScreen(userList: state.userList,performerId: performerId,)));
            },
            child: const Icon(CupertinoIcons.add),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
