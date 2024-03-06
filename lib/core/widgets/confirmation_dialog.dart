import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class ConfirmationDialog extends StatelessWidget {
  final String alertMsg;
  final VoidCallback onTapConfirm;
  final String? onConfirmText;
  const ConfirmationDialog({
    Key? key,
    required this.alertMsg,
    required this.onTapConfirm,
    this.onConfirmText,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: AppColors.primary,
        ),
      ),
      title: Icon(
        size: 50.sp,
        Icons.info,
        color: Colors.black,
      ),
      content: Text(
        alertMsg,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      actions: <Widget>[
        TextButton(
            style: Theme.of(context).textButtonTheme.style,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'إلغاء',
            )),
        TextButton(
          style: Theme.of(context).textButtonTheme.style,
          onPressed: () => onTapConfirm(),
          child: Text(
            onConfirmText ?? 'موافق',
          ),
        ),
      ],
    );
  }
}
