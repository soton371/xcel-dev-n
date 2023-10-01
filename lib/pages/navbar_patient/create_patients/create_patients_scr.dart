import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcel_medical_center/blocs/lookup/lookup_bloc.dart';
import 'package:xcel_medical_center/pages/navbar_patient/create_patients/components/add_patient_scr.dart';
import 'package:xcel_medical_center/pages/navbar_patient/create_patients/components/not_prepare_scr.dart';

class CreatePatientScreen extends StatefulWidget {
  const CreatePatientScreen({
    super.key
  });

  @override
  State<CreatePatientScreen> createState() => _CreatePatientScreenState();
}

class _CreatePatientScreenState extends State<CreatePatientScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LookupBloc,LookupState>(
        builder: (context,state){
          if (state is LookupDataState) {
            return AddPatientScreen(bloodGroupList: state.bloodGroup, genderList: state.genderList, relationList: state.relationList, religionList: state.religionList, maritalList: state.maritalList, countryList: state.countryList);
          } else if(state is LookupFailedState){
            return NotPrepareScreen(errorMsg: state.errorMsg);
          }else{
            return Center(
              child: Image.asset(
                'assets/images/loader.gif',
                height: 100,
              ),
            );
          }
        }
      ),
    );
  }
}
