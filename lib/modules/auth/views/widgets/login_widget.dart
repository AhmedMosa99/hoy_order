import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_increase/modules/auth/controller/auth.dart';
import 'package:social_increase/modules/auth/views/screen/reset_password.dart';
import 'package:social_increase/modules/auth/views/screen/sign_up.dart';
import 'package:social_increase/utils/component/component.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String dropdownvalue = '+971';

  // List of items in our dropdown menu
  var items = ['+249', '+971'];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Form(
        key: controller.keyLogin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign In",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 18.h,
            ),
            Text(
              "Phone Number",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 54.h,
              width: double.infinity,
              child: defaultFormField(
                  label: '000 000 000',
                  prefix: Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;

                          controller.countryCode = dropdownvalue;
                          print(controller.countryCode);
                        });
                      },
                    ),
                  ),
                  type: TextInputType.number,
                  controller: controller.phoneControllerLogin,
                  validate: (val) {
                    if (val!.trim().isEmpty || (!GetUtils.isPhoneNumber(val))) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                  hintStyle: const TextStyle(
                    height: 3.1,
                  )),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text('Password',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
                height: 54.h,
                child: defaultFormField(
                    hintText: "********",
                    validate: (val) {
                      if (val!.trim().isEmpty)
                        return 'Enter correct password !';
                      return null;
                    },
                    controller: controller.passwordControllerSignUp,
                    type: TextInputType.text,
                    isPassword: controller.isPassword,
                    suffix: Icon(controller.iconPass, color: Colors.black),
                    suffixPressed: () {
                      controller.changeVisible(!controller.isPassword);
                    })),
            SizedBox(
              height: 4.h,
            ),
            InkWell(
                onTap: () {
                  Get.to(const ResetPassword());
                },
                child: Text(
                  "Forget Password",
                  style: Theme.of(context).textTheme.bodyText2,
                )),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 44.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await controller.checkLogin(
                        controller.phoneControllerLogin.text,
                        controller.passwordControllerSignUp.text);
                  } catch (e) {
                    Get.snackbar(
                        'sorry', 'The password or number is incorrect.');
                  }
                },
                child: const Text('Sign In'),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Don't have an account?"),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(const SignUp());
                    },
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      );
    });
  }
}
