import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/lookup_model.dart';
import 'package:http/http.dart' as http;
part 'lookup_event.dart';
part 'lookup_state.dart';

class LookupBloc extends Bloc<LookupEvent, LookupState> {
  //for slider image
  List<String> imageUrls = [];
  List<Country> relationList = [];
  List<Blood> bloodGroup = [];
  List<Country> religionList = [];
  List<Blood> genderList = [];
  List<Country> maritalList = [];
  List<Country> countryList = [];

  LookupBloc() : super(LookupInitial()) {
    on<CallLookupService>((event, emit) async {
      debugPrint("call CallLookupService");
      Uri url = Uri.parse(lookupUrl);
      try {
        final response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
        );
        if (response.statusCode == 200) {
          debugPrint('lookupUrl retrieved successful!!!');
          final lookupModel = lookupModelFromJson(response.body);
          final items = lookupModel.items;
          List<Gallery>? galleryItems;
          if (items != null) {
            galleryItems = items[0].gallery ?? [];
            relationList = items[0].relation ?? [];
            bloodGroup = items[0].blood ?? [];
            religionList = items[0].religion ?? [];
            genderList = items[0].gender ?? [];
            maritalList = items[0].marital ?? [];
            countryList = items[0].country ?? [];

            imageUrls = galleryItems
                .map((e) =>
                    e.fncImgDirPhotoLoca ??
                    'https://images.unsplash.com/photo-1581093450021-4a7360e9a6b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80')
                .toList();
            if (imageUrls.isNotEmpty) {
              // emit(LookupDataState(imageUrls));
              emit(LookupDataState(
                  galleryItems: imageUrls,
                  bloodGroup: bloodGroup,
                  genderList: genderList,
                  relationList: relationList,
                  religionList: religionList,
                  maritalList: maritalList,
                  countryList: countryList));
            } else {
              List<String> defaultImageUrls = [
                  'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
                  'https://images.unsplash.com/photo-1581093450021-4a7360e9a6b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
                  'https://images.unsplash.com/photo-1579154204601-01588f351e67?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
                ];
              emit(LookupDataState(
                  galleryItems: defaultImageUrls,
                  bloodGroup: bloodGroup,
                  genderList: genderList,
                  relationList: relationList,
                  religionList: religionList,
                  maritalList: maritalList,
                  countryList: countryList));
            }
          } else {
            galleryItems = [];
            relationList = [];
            emit(const LookupFailedState(''));
          }
        } else {
          debugPrint(
              'response.statusCode.toString(): ${response.statusCode.toString()}');
          emit(LookupFailedState("${response.statusCode}"));
        }
      } catch (e) {
        debugPrint("CallLookupService e: $e");
        emit(const LookupFailedState("Something went wrong."));
      }
      debugPrint('imageUrl length: ${imageUrls.length}');
    });
  }
}
