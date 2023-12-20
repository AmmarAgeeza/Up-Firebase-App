import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          final scroll = ScrollController();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: cubit.formRegisterKey,
              child: SingleChildScrollView(
                controller: scroll,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                        height: 300.h,
                        width: double.infinity,
                        // color: AppColor.primaryColor,
                        child: Image.asset(AppAssets.auth)),
                    SizedBox(
                      height: 15.h,
                    ),

                    //name
                    CustomTextFormField(
                        lable: 'Full Name',
                        controller: cubit.nameController,
                        type: TextInputType.name,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter E-mail';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15.h,
                    ),
                    //phone
                    CustomTextFormField(
                        lable: 'Phone Number',
                        controller: cubit.phoneNumberController,
                        type: TextInputType.phone,
                        validate: (val) {
                          if (val!.isEmpty || val.length != 11) {
                            return 'Please Enter valid phone number';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15.h,
                    ),
                    //email
                    CustomTextFormField(
                        lable: 'E-mail',
                        controller: cubit.emailRegisterController,
                        type: TextInputType.emailAddress,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter E-mail';
                          }
                          if (!(val.contains('@gmail.com'))) {
                            return 'E-mail must contains @gmail.com';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15.h,
                    ),

                    //password
                    CustomTextFormField(
                        lable: 'Password',
                        controller: cubit.passwordRegisterController,
                        type: TextInputType.visiblePassword,
                        isPassword: cubit.isPasswordShown,
                        icon: cubit.suffixIcon,
                        suffixIconOnPressed: () {
                          cubit.changePasswordIcon();
                        },
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter valid password';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 15.h,
                    ),

                    customDropMenu(
                        function: (d) {
                          cubit.changeDepartmentValue(d);
                        },
                        dropDownValue: cubit.dropDownValueDepartment,
                        items: cubit.itemsDepartments.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        title: 'Choose your Department'),
                    SizedBox(
                      height: 15.h,
                    ),
                    //submit button

                    CustomButton(
                      text: 'Submit',
                      onPressed: () async {
                        context.read<AuthCubit>().register();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}

Widget customDropMenu(
    {required String title,
    required String dropDownValue,
    required Function(String?) function,
    required List<DropdownMenuItem<String>>? items}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      const SizedBox(
        height: 15,
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        child: DropdownButton(
          isExpanded: true,
          underline: Container(),
          value: dropDownValue,
          borderRadius: BorderRadius.circular(10),
          // dropdownColor: Colors.deepOrange,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items,
          onChanged: function,
        ),
      ),
    ],
  );
}
