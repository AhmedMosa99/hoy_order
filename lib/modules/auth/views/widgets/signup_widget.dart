import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_increase/modules/auth/controller/auth.dart';
import 'package:social_increase/utils/component/component.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  String dropdownvalue = '+971';

  // List of items in our dropdown menu
  var items = ['+249', '+971'];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Form(
          key: controller.keyRegister,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(height: 18.h),
              Text(
                "Full Name",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: defaultFormField(
                    type: TextInputType.text,
                    controller: controller.nameController,
                    hintText: "Enter your full name",
                    validate: (val) {
                      if (val!.trim().isEmpty) return 'Enter your name!';
                      return null;
                    }),
              ),
              SizedBox(height: 5.h),
              Text(
                "Phone Number",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
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
                          });
                        },
                      ),
                    ),
                    type: TextInputType.number,
                    controller: controller.phoneControllerSignUp,
                    validate: (val) {
                      if (val!.trim().isEmpty ||
                          (!GetUtils.isPhoneNumber(val))) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                    hintStyle: const TextStyle(
                      height: 3.1,
                    )),
              ),
              SizedBox(height: 5.h),
              Text(
                "Email",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: defaultFormField(
                  type: TextInputType.text,
                  controller: controller.emailControllerSignUp,
                  hintText: "Enter your email ",
                  validate: (val) {
                    if (val!.trim().isEmpty || (!GetUtils.isEmail(val))) {
                      return 'Enter a valid email !';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5.h),
              Text('Password',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 5.h),
              SizedBox(
                  height: 50.h,
                  child: defaultFormField(
                      hintText: "********",
                      controller: controller.passwordControllerSignUp,
                      type: TextInputType.text,
                      validate: (val) {
                        if (val!.trim().isEmpty) {
                          return 'Enter correct password';
                        }
                        return null;
                      },
                      isPassword: controller.isPassword,
                      suffix: Icon(controller.iconPass, color: Colors.black),
                      suffixPressed: () {
                        controller.changeVisible(!controller.isPassword);
                      })),
              SizedBox(height: 5.h),
              Text(
                "Country",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: defaultFormField(
                  type: TextInputType.text,
                  controller: controller.country,
                  hintText: "Country ",
                  validate: (val) {
                    if (val!.trim().isEmpty) {
                      return 'Enter Country!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "City",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: defaultFormField(
                  type: TextInputType.text,
                  controller: controller.city,
                  hintText: "City ",
                  validate: (val) {
                    if (val!.trim().isEmpty) {
                      return 'Enter City!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Street",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: defaultFormField(
                  type: TextInputType.text,
                  controller: controller.street,
                  hintText: "Street ",
                  validate: (val) {
                    if (val!.trim().isEmpty) {
                      return 'Enter Your !';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Apartment number",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: defaultFormField(
                  type: TextInputType.text,
                  controller: controller.streetNumber,
                  hintText: "Apartment number ",
                  validate: (val) {
                    if (val!.trim().isEmpty) {
                      return 'Enter Your Apartment number!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Alternate phone number",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: defaultFormField(
                  type: TextInputType.text,
                  controller: controller.alterPhoneNumber,
                  hintText: "Alternate phone number ",
                  validate: (val) {
                    if (val!.trim().isEmpty) {
                      return 'Enter Your Alternate phone number!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await controller.checkRegister(
                          phone: controller.phoneControllerSignUp.text,
                          password: controller.passwordControllerSignUp.text,
                          name: controller.nameController.text,
                          email: controller.emailControllerSignUp.text,
                          city: controller.city.text,
                          street: controller.street.text,
                          streetNumber: controller.streetNumber.text,
                          country: controller.country.text,
                          alterPhoneNumber: controller.alterPhoneNumber.text);
                    } catch (e) {
                      print(e);
                      Get.snackbar('Sorry', "Registration failed");
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Do you already have an account? "),
                  SizedBox(
                    width: 5.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ],
          ));
    });
  }
}
