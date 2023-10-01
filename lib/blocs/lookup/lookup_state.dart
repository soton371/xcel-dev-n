part of 'lookup_bloc.dart';

abstract class LookupState extends Equatable {
  const LookupState();

  @override
  List<Object> get props => [];
}

class LookupInitial extends LookupState {}

class LookupDataState extends LookupState {
  final List<String> galleryItems;
  final List<Country> relationList, religionList, maritalList, countryList;
  final List<Blood> bloodGroup, genderList;
  const LookupDataState({
    required this.galleryItems,
    required this.bloodGroup,
    required this.genderList,
    required this.relationList,
    required this.religionList,
    required this.maritalList,
    required this.countryList,
  });
  @override
  List<Object> get props => [galleryItems,bloodGroup, genderList,relationList, religionList, maritalList, countryList];
}

class LookupFailedState extends LookupState {
  final String errorMsg;
  const LookupFailedState(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
