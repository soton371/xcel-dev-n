import 'package:flutter/material.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/all_doctors_tile.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/components/custom_searchbar.dart';
import 'package:xcel_medical_center/pages/navbar_patient/doctors/doctor_details_page.dart';
import '../../../../../model/dept_doctor.dart';

class DoctorListPage extends StatefulWidget {
  final List<Doctor>? doctorListByCategory;
  final List<Doctor>? allDoctorList;
  const DoctorListPage({
    Key? key,
    @required this.doctorListByCategory,
    @required this.allDoctorList,
  }) : super(key: key);

  @override
  DoctorListPageState createState() => DoctorListPageState();
}

class DoctorListPageState extends State<DoctorListPage>
    with SingleTickerProviderStateMixin {
  List<Doctor>? doctorInfoByCategory = [];
  List<Doctor>? displayDoctorInfoByCategory = [];
  List<Doctor>? allDoctorInfo = [];
  List<Doctor>? displayAllDoctorInfo = [];
  final TextEditingController categoryDrController = TextEditingController();
  final TextEditingController allDrController = TextEditingController();
  bool isSearching = false;
  TabController? _tabController;
  final ScrollController scrollcontroller = ScrollController();
  int tabIndex = 0;

  @override
  void initState() {
    setState(() {
      doctorInfoByCategory = widget.doctorListByCategory;
      displayDoctorInfoByCategory = doctorInfoByCategory;
      allDoctorInfo = widget.allDoctorList;
      displayAllDoctorInfo = allDoctorInfo;
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        tabIndex = _tabController!.index;
      });
      debugPrint("tabIndex: $tabIndex");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TabBar(
          tabs: const [
            Tab(
              text: 'Speciality',
            ),
            Tab(
              text: 'All',
            ),
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (value) {
              categoryDrController.clear();
              allDrController.clear();
              displayDoctorInfoByCategory = doctorInfoByCategory ?? [];
              displayAllDoctorInfo = allDoctorInfo ?? [];
          },
        ),
      ),
      body: Column(
        children: [
          tabIndex == 0
              ? CustomSearchBar(
                  controller: categoryDrController,
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      displayDoctorInfoByCategory =
                          (doctorInfoByCategory ?? []).where((value) {
                        var name = (value.doctorName ?? '').toLowerCase();

                        return name.contains(
                            text) /*|| degree.contains(text) || dept.contains(text) || institute.contains(text) || specialityName.contains(text) || sunday.contains(text) || monday.contains(text) || tuesday.contains(text) || wednesday.contains(text) || thursday.contains(text) || friday.contains(text) || saturday.contains(text)*/;
                      }).toList();
                    });
                  },
                )
              : CustomSearchBar(
                  controller: allDrController,
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      displayAllDoctorInfo =
                          (allDoctorInfo ?? []).where((value) {
                        var name = (value.doctorName ?? '').toLowerCase();
                        return name.contains(
                            text) /* || degree.contains(text) || dept.contains(text) || institute.contains(text) || specialityName.contains(text) || sunday.contains(text) || monday.contains(text) || tuesday.contains(text) || wednesday.contains(text) || thursday.contains(text) || friday.contains(text) || saturday.contains(text)*/;
                      }).toList();
                    });
                  },
                ),
          
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                /* :::::::::::::::::::::::::::::: DOCTOR LIST BY CATEGORY [TAB 1] :::::::::::::::::::::::::::::: */
                displayDoctorInfoByCategory!.isEmpty
                    ? const Center(child: Text('not matched!'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: displayDoctorInfoByCategory!.length,
                        padding: const EdgeInsets.only(
                            bottom: 4, left: 8, right: 8, top: 8),
                        itemBuilder: (context, index) {
                          var drInfo = displayDoctorInfoByCategory![index];
                          return InkWell(
                            child: AllDoctorTile(
                              imageUrl: drInfo.photoLoca
                                  .toString(), //drInfo.imgPath.toString(),
                              name: drInfo.doctorName.toString(),
                              speciality: drInfo.qualification
                                  .toString(), //drInfo.specialityName.toString(),
                              degree: null, //drInfo.degree.toString(),
                              institute:
                                  'Xcel Medical Centre', //drInfo.instituteName.toString(),
                              departmentName: drInfo.deptNM
                                  .toString(), //drInfo.departmentName.toString(),
                              rating: drInfo.rating.toString(),
                              callback: (int flag) {
                                debugPrint("flag type $flag");
                                goTpAptPage(context, drInfo, flag);
                              },
                            ),
                            onTap: () {},
                          );
                        }),
                /* :::::::::::::::::::::::::::::: ALL DOCTOR LIST [TAB 2] :::::::::::::::::::::::::::::: */
                displayAllDoctorInfo!.isEmpty
                    ? const Center(child: Text('not matched!'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: displayAllDoctorInfo!.length,
                        // controller: scrollcontroller,
                        padding: const EdgeInsets.only(
                            bottom: 4, left: 8, right: 8, top: 8),
                        itemBuilder: (context, index) {
                          var drInfo = displayAllDoctorInfo![index];
                          return InkWell(
                            child: AllDoctorTile(
                              imageUrl: drInfo.photoLoca
                                  .toString(), //drInfo.imgPath.toString(),
                              name: drInfo.doctorName.toString(),
                              speciality: drInfo.qualification
                                  .toString(), //drInfo.specialityName.toString(),
                              degree: null, //drInfo.degree.toString(),
                              institute:
                                  'Xcel Medical Centre', //drInfo.instituteName.toString(),
                              departmentName: drInfo.deptNM
                                  .toString(), //drInfo.departmentName.toString(),
                              rating: drInfo.rating.toString(),
                              callback: (int flag) {
                                debugPrint("flag type $flag");
                                goTpAptPage(context, drInfo, flag);
                              },
                            ),
                            onTap: () {},
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void goTpAptPage(BuildContext context, Doctor drInfo, int flag) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorDetailsPage(
            imageUrl: drInfo.photoLoca.toString(),
            name: drInfo.doctorName.toString(),
            speciality: drInfo.qualification.toString(),
            degree: null,
            department: drInfo.deptNM.toString(),
            drNo: drInfo.doctorNo.toString(),
            currentChember: null,
            drInfo: drInfo,
            aptFlag: flag),
      ),
    );
  }
}
