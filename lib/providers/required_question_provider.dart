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
}
