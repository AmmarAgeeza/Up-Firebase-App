import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_firebase/feature/home/data/models/donator_model.dart';
import 'package:test_firebase/feature/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(HomeInitial());
  final HomeRepo repo;
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> numberKey = GlobalKey();
  final TextEditingController date = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController numbers = TextEditingController();
  void addDonator() async {
    emit(AddDonatorLoadingState());
    var res = await repo.addDonator(
      model: DonatorModel(
        name: nameController.text,
        address: addressController.text,
        phone: phoneNumberController.text,
        type: type.text,
        date: currentDate,
      ),
    );
    res.fold(
      (l) => emit(
        AddDonatorErrorState(message: l),
      ),
      (r) {
        nameController.clear();
        addressController.clear();
        phoneNumberController.clear();
        type.clear();
        date.clear();
        emit(AddDonatorSucessfulltyState(message: r));
      },
    );
  }

  void decreaseBagsNumbers({int number = 1}) async {
    try {
      emit(DecreaseBagsNumbersLoadingState());
      var data = await FirebaseFirestore.instance
          .collection('BagNumbers')
          .doc('nUD3z9bG7JjaNz6rfs1o')
          .get();
      int realNumber = data.data()!['number'];
      log(data.data()!['number'].toString());
      if (realNumber > 0 && realNumber >= number) {
        FirebaseFirestore.instance
            .collection('BagNumbers')
            .doc('nUD3z9bG7JjaNz6rfs1o')
            .set({
          'number': (realNumber - number),
        });
        numbers.clear();
        emit(DecreaseBagsNumbersSucessfulltyState(message: 'تم صرف كيس بنجاح'));
      } else {
        emit(DecreaseBagsNumbersErrorState(
            message: 'لا يمكن صرف كيس - الكمية غير كافية'));
      }
    } catch (e) {
      emit(DecreaseBagsNumbersErrorState(message: 'حدث خطأ - حاول مرة أخرى'));
    }
  }

  DateTime currentDate = DateTime.now();
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      locale: const Locale('ar', 'EG'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      // initialDatePickerMode: DatePickerMode.day,
      // initialEntryMode: DatePickerEntryMode.inputOnly,
    );

    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSucessState());
    } else {
      log('pickedDate == null');
      emit(GetDateErrorState());
    }
  }
}
