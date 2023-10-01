import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forked_slider_button/forked_slider_button.dart';
import 'package:xcel_medical_center/blocs/lookup/lookup_bloc.dart';
import 'package:xcel_medical_center/blocs/request_list/request_list_bloc.dart';
import 'package:xcel_medical_center/model/lookup_model.dart';
import 'package:xcel_medical_center/model/user_list_mod.dart';
import 'package:xcel_medical_center/services/request/relation_request.dart';
import 'package:xcel_medical_center/widgets/my_alert.dart';
import 'package:xcel_medical_center/widgets/my_loader.dart';

class AddTagRequestScreen extends StatefulWidget {
  const AddTagRequestScreen(
      {super.key, required this.userList, required this.performerId});
  final List<UserListModel> userList;
  final String performerId;

  @override
  State<AddTagRequestScreen> createState() => _AddTagRequestScreenState();
}

class _AddTagRequestScreenState extends State<AddTagRequestScreen> {
  String searchText = '';
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  String selectRelationship = "Select Relationship";
  String selectPeople = '';
  List<UserListModel> userListCopy = [];
  UserListModel selectUser = UserListModel();
  List<Country> relations = [];
  Country selectRelation = Country();

  @override
  void initState() {
    super.initState();
    userListCopy = widget.userList;
    relations = context.read<LookupBloc>().relationList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //add for search
            TextField(
              onSubmitted: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                  isSearching = false;
                });
              },
              onTap: () {
                setState(() {
                  isSearching = true;
                });
              },
              onChanged: (value) {
                searchText = value.toLowerCase();
                setState(() {
                  userListCopy = widget.userList.where((value) {
                    var name = (value.patientNm ?? '').toLowerCase();
                    var no = (value.patientNo ?? '').toLowerCase();
                    return name.contains(searchText) || no.contains(searchText);
                  }).toList();
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Search People",
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                      borderRadius: isSearching
                          ? const BorderRadius.vertical(
                              top: Radius.circular(10))
                          : BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  prefixIcon: isSearching
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isSearching = false;
                            });
                          },
                          icon: const Icon(CupertinoIcons.back))
                      : const Icon(CupertinoIcons.search),
                  suffixIcon: searchText.isNotEmpty && isSearching
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              searchText = '';
                              searchController =
                                  TextEditingController(text: searchText);
                            });
                          },
                          icon: const Icon(CupertinoIcons.multiply))
                      : const SizedBox()),
              readOnly: isSearching ? false : true,
            ),

            //for suggestions
            isSearching
                ? Flexible(
                    child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(10))),
                        child: searchText.isEmpty
                            ? const Center(
                                child: Text('No person has been search yet'))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: userListCopy.length,
                                itemBuilder: (context, index) {
                                  var data = userListCopy[index];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectUser = data;
                                        selectPeople = "patientName";
                                        isSearching = false;
                                        searchText = '';
                                        searchController =
                                            TextEditingController(
                                                text: searchText);
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceVariant),
                                      ),
                                      child: Row(
                                        children: [
                                          //image
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                              imageUrl: "${data.photoLoca}",
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                "assets/images/avatar.png",
                                                height: 70,
                                                width: 70,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/avatar.png",
                                                height: 70,
                                                width: 70,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          //name
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.patientNm ?? '',
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                Divider(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceVariant,
                                                ),
                                                Text(
                                                  data.patientNo ?? '',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .fontSize,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                  )
                : const SizedBox(),

            //add for relationship
            selectUser.patientNm == null && selectPeople.isEmpty
                ? const SizedBox()
                : Column(
                    children: [
                      //add for people
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant),
                        ),
                        child: Row(
                          children: [
                            //image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                                imageUrl: selectUser.photoLoca ?? '',
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/avatar.png",
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/avatar.png",
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),
                            //name
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectUser.patientNm ?? 'n',
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                  ),
                                  Text(
                                    selectUser.patientNo ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .fontSize,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //add for relationship dropdown
                      const SizedBox(
                        height: 12,
                      ),
                      PopupMenuButton(
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectRelationship,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        onSelected: (value) {
                          selectRelation = value;
                          setState(() {
                            selectRelationship = value.rName ?? '';
                          });
                        },
                        itemBuilder: (BuildContext bc) {
                          return relations
                              .map((e) => PopupMenuItem(
                                    value: e,
                                    child: Text(e.rName ?? ''),
                                  ))
                              .toList();
                        },
                      ),
                      //end Relationship
                    ],
                  )
          ],
        ),
      ),
      bottomNavigationBar: selectRelationship == "Select Relationship"
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: SliderButton(
                action: () {
                  myLoader(context);
                  requestRelation(
                          patientId: widget.performerId,
                          requestForId: "${selectUser.patientId}",
                          relationId: "${selectRelation.rId}")
                      .then((value) {
                    if (value["status"] == "200") {
                      myAlertDialog(context,
                          titleMsg: "Successful",
                          contentMsg: "Your request has been sent",
                          actions: [
                            TextButton(
                                onPressed: () {
                                  context
                                      .read<RequestListBloc>()
                                      .add(CallRequestList(widget.performerId));
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(
                                      context); // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>TagRequestScreen(performerId: widget.performerId)));
                                },
                                child: const Text('Okay'))
                          ]);
                    } else {
                      myAlertDialog(context,
                          titleMsg: "Unsuccessful",
                          contentMsg: "${value["message"]}",
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Okay'))
                          ]);
                    }
                  });
                },
                label: Center(
                  child: Text(
                    "Slide to send request",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                icon: const Icon(CupertinoIcons.forward),
                height: 50,
                buttonSize: 45,
                radius: 10,
                width: double.maxFinite,
                dismissible: false,
              ),
            ),
    );
  }
}
