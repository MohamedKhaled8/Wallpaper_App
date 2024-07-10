import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';

// ignore: use_function_type_syntax_for_parameters
void showMessage(BuildContext context, String message,
    {bool isError = true, VoidCallback? onConfimTapped}) {
  QuickAlert.show(
    context: context,
    type: isError ? QuickAlertType.error : QuickAlertType.success,
    title: isError ? "Oops......" : null,
    confirmBtnColor: ColorsManger.primaryColor,
    onConfirmBtnTap: onConfimTapped,
    text: message,
  );
}
