// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:social_increase/modules/auth/models/login.dart';
import 'package:social_increase/modules/main/models/category.dart';
import 'package:social_increase/utils/constant.dart';

class DioHandler {
  DioHandler._();

  static DioHandler apiHelper = DioHandler._();

  Dio dio = Dio();

  String baseUrl = 'http://hoyorder.com/api';

  Future<LoginModel> fetchLogin(String phone, String password) async {
    var responseData;
    try {
      final loginUrl = '$baseUrl/login';
      final response = await dio.post(
        loginUrl,
        data: {'phone': phone, "password": password},
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
      print(response.data);
      if ((response.statusCode!) <= 400) {
        responseData = (response.data)["data"];
      }
    } catch (e) {
      throw Exception(e);
    }

    return LoginModel.fromJson(responseData);
  }

  fetchDetailsOrder(int id) async {
    try {
      var responseData;
      final orderUrl = '$baseUrl/order/$id';
      final Response response = await dio.get(
        orderUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'lang': "en",
            'Authorization': userInfo!.token.contains('Bearer')
                ? userInfo!.token
                : 'Bearer ${userInfo!.token}'
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! <= 500;
          },
        ),
      );

      if ((response.statusCode!) <= 400) {
        responseData = (response.data)["data"];
        return responseData;
      }

      return responseData;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  makeOrder(String link, String qty, String color, String size) async {
    var responseData;
    try {
      final loginUrl = '$baseUrl/order';
      final response = await dio.post(
        loginUrl,
        data: {
          'link': link,
          "qty": qty,
          'color': color,
          'size': size,
          'lang': 'en',
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': userInfo!.token.contains('Bearer')
                ? userInfo!.token
                : 'Bearer ${userInfo!.token}'
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
      if ((response.statusCode!) <= 400) {
        responseData = (response);
        return true;
      } else {
        return false;
      }
      //return responseData;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<LoginModel> fetchRegister(
    String phone,
    String password,
    String email,
    String name,
    String city,
    String street,
    String streetNumber,
    String country,
    String alternatePhoneNumber,
  ) async {
    var responseData;
    try {
      final loginUrl = '$baseUrl/register';
      final response = await dio.post(
        loginUrl,
        data: {
          'lang': 'en',
          'phone': phone,
          "password": password,
          'email': email,
          'name': name,
          'device': 'mobile',
          'city': city,
          'street': street,
          'street_number': streetNumber,
          'country': country,
          'alter_phone': alternatePhoneNumber,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
      if ((response.statusCode!) <= 400) {
        responseData = (response.data)["data"];
      }
    } catch (e) {
      throw Exception(e);
    }

    return LoginModel.fromJson(responseData);
  }

  Future<LoginModel> changePasswordAndEditProfile({
    required String pastPass,
    required String newPass,
    required String image,
    required String phone,
    required String name,
    required String city,
    required String street,
    required String streetNumber,
  }) async {
    var responseData;
    try {
      Response response;
      final loginUrl = '$baseUrl/edit/user';
      if (image.isNotEmpty) {
        String fileName = image.split('/').last;
        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(image, filename: fileName),
        });
        response = await dio.post(
          loginUrl,
          data: formData,
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': userInfo!.token.contains('Bearer')
                  ? userInfo!.token
                  : 'Bearer ${userInfo!.token}'
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            },
          ),
        );
      } else {
        response = await dio.post(
          loginUrl,
          data: pastPass.isEmpty
              ? {
                  'phone': phone.isEmpty ? userInfo!.phone : phone,
                  'name': name.isEmpty ? userInfo!.name : name,
                  'image': image,
                  'city': city.isEmpty ? userInfo!.city : city,
                  'street': street.isEmpty ? userInfo!.street : street,
                  'streetNumber': streetNumber.isEmpty
                      ? userInfo!.streetNumber
                      : streetNumber,
                }
              : image.isNotEmpty
                  ? {
                      'image': MultipartFile.fromFileSync(image,
                          filename: image.split('/').last),
                    }
                  : {
                      'phone': phone.isEmpty ? userInfo!.phone : phone,
                      "old-password": pastPass,
                      'name': name.isEmpty ? userInfo!.name : name,
                      'image': image.isEmpty ? userInfo!.image : image,
                      'new-password': newPass,
                      'city': city.isEmpty ? userInfo!.city : city,
                      'street': street.isEmpty ? userInfo!.street : street,
                      'streetNumber': streetNumber.isEmpty
                          ? userInfo!.streetNumber
                          : streetNumber,
                    },
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': userInfo!.token.contains('Bearer')
                  ? userInfo!.token
                  : 'Bearer ${userInfo!.token}'
            },
            followRedirects: false,
            validateStatus: (status) {
              return true;
            },
          ),
        );
      }

      if ((response.statusCode!) <= 400) {
        responseData = (response.data)["data"];
      }
    } catch (e) {
      throw Exception(e);
    }
    return LoginModel.fromJson(responseData);
  }

  resetPassword(String email) async {
    try {
      final socialMediaUrl = '$baseUrl/forgot-password';
      final response = await dio.post(
        socialMediaUrl,
        data: {'email': email, 'lang': 'ar'},
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
      if ((response.statusCode!) <= 400) {
        return response.data['code'];
      }

      return response.data['code'];
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  getCategoriy() async {
    try {
      Response response;
      final categoryUrl = '$baseUrl/categories';
      response = await dio.get(
        categoryUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'lang': 'en',
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
      if (response.statusCode! <= 400) {
        return response.data["data"];
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      return "Failed to Add it";
    }
  }

  postRaiting(String rate, String comment) async {
    Response response;
    try {
      final loginUrl = '$baseUrl/make/opinion';
      response = await dio.post(
        loginUrl,
        data: {'comment': comment, "stars": rate},
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': userInfo!.token.contains('Bearer')
                ? userInfo!.token
                : 'Bearer ${userInfo!.token}'
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
      print(response);
      if (response.statusCode! <= 400) {
        return response.data["message"];
      } else {
        throw Exception();
      }
    } catch (e) {
      return "Failed to Add it";
    }
  }

  takePhoto(int? id, File? url) async {
    String path = url!.path.split('/').last;
    var responseData;
    final orderUrl = '$baseUrl/uploadImage';
    var formData = FormData.fromMap({
      'lang': "en",
      'order_id': id,
      'image': MultipartFile.fromFileSync(url.path, filename: path),
    });
    final Response response = await dio.post(
      orderUrl,
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
          "Content-type": "multipart/form-data",
          'Authorization': userInfo!.token.contains('Bearer')
              ? userInfo!.token
              : 'Bearer ${userInfo!.token}'
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      ),
    );

    if ((response.statusCode!) <= 400) {
      return true;
    } else {
      return false;
    }

    //  return responseData;
  }

  cancel(int? id) async {
    var responseData;
    final orderUrl = '$baseUrl/cancelOrderApi';
    final Response response = await dio.post(
      orderUrl,
      data: {
        'lang': "en",
        'order_id': id,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': userInfo!.token.contains('Bearer')
              ? userInfo!.token
              : 'Bearer ${userInfo!.token}'
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! <= 500;
        },
      ),
    );

    if ((response.statusCode!) <= 400) {
      return true;
    } else {
      return false;
    }

    //  return responseData;
  }

  getOrder() async {
    try {
      Response response;
      final categoryUrl = '$baseUrl/order';
      response = await dio.get(
        categoryUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'lang': 'en',
            'Authorization': userInfo!.token.contains('Bearer')
                ? userInfo!.token
                : 'Bearer ${userInfo!.token}'
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );

      if (response.statusCode! <= 400) {
        return response.data["data"];
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      return "Failed to Add it";
    }
  }

  getPrice() async {
    try {
      Response response;
      final categoryUrl = '$baseUrl/getPrice';
      response = await dio.get(
        categoryUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'lang': 'en',
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );

      if (response.statusCode! <= 400) {
        return response.data["data"];
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      return "Failed to Add it";
    }
  }

  getNotifications() async {
    try {
      Response response;
      final categoryUrl = '$baseUrl/notifications';
      response = await dio.get(
        categoryUrl,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'lang': 'en',
            'Authorization': userInfo!.token.contains('Bearer')
                ? userInfo!.token
                : 'Bearer ${userInfo!.token}'
          },
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
      if (response.statusCode! <= 400) {
        return response.data["data"];
      } else {
        throw Exception();
      }
    } on Exception catch (e) {
      return "Failed to Add it";
    }
  }
}


   



/*
try {
  Dio dio = Dio();
  var res = await dio.download(
    url + 'fg',
    savePath.path + "/filename.bin",
    onReceiveProgress: (count, total) {
      progress(count, total);
    },
  );
} on DioError catch (e) {
  if (e.type == DioErrorType.response) {
    print('catched');
    return;
  }
  if (e.type == DioErrorType.connectTimeout) {
    print('check your connection');
    return;
  }

  if (e.type == DioErrorType.receiveTimeout) {
    print('unable to connect to the server');
    return;
  }

  if (e.type == DioErrorType.other) {
    print('Something went wrong');
    return;
  }
  print(e);
} catch (e) {
  print(e);
}
 */