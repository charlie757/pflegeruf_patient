import 'package:flutter/material.dart';

class RequiredQuestionProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final insuranceController = TextEditingController();
  final birthDateController = TextEditingController();
  bool privateInsurance = false;
  bool nationalInsurance = false;

  clearValues() {
    nameController.clear();
    addressController.clear();
    postalCodeController.clear();
    streetController.clear();
    cityController.clear();
    insuranceController.clear();
    birthDateController.clear();
    privateInsurance = false;
    nationalInsurance = false;
  }

  updatePrivateInsurance(value) {
    privateInsurance = value;
    notifyListeners();
  }

  updateNiationalInsurance(value) {
    nationalInsurance = value;
    notifyListeners();
  }
}
