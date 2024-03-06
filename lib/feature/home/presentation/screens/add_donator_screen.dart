import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/commons.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/home_cubit.dart';

class AddDonatorScreen extends StatelessWidget {
  const AddDonatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إضافة متبرع جديد',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is AddDonatorSucessfulltyState) {
              showToast(message: state.message, state: ToastStates.success);
              Navigator.pop(context);
            }
            if (state is AddDonatorErrorState) {
              showToast(message: state.message, state: ToastStates.error);
            }
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<HomeCubit>(context);
            return state is AddDonatorLoadingState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: cubit.formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            //name
                            CustomTextFormField(
                                lable: 'الاسم كامل',
                                controller: cubit.nameController,
                                type: TextInputType.name,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return 'مطلوب';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),
                            //address
                            CustomTextFormField(
                                lable: 'العنوان',
                                controller: cubit.addressController,
                                type: TextInputType.name,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return 'مطلوب';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),
                            //phone
                            CustomTextFormField(
                                lable: 'رقم الهاتف',
                                controller: cubit.phoneNumberController,
                                type: TextInputType.phone,
                                validate: (val) {
                                  if (val!.isEmpty || val.length != 11) {
                                    return 'أدخل رقم هاتف صالح';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),
                            //type
                            CustomTextFormField(
                                lable: 'الفصيلة',
                                controller: cubit.type,
                                type: TextInputType.text,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return 'مطلوب';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),
                            //date
                            CustomTextFormField(
                                lable: 'التاريخ',
                                controller: cubit.date,
                                type: TextInputType.datetime,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return 'مطلوب';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.h,
                            ),

                            //submit button

                            CustomButton(
                              text: 'تسجيل',
                              onPressed: () async {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.addDonator();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
