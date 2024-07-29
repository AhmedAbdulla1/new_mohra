import 'dart:convert';
import 'dart:io';

import 'package:booking_system_flutter/model/user_data_model.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/user_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/errv_toast_options.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/toast/show_error_toast.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/account/data/model/request/confirmPassword_request.dart';
import 'package:starter_application/features/account/data/model/request/confirm_phone_number_params.dart';
import 'package:starter_application/features/account/data/model/request/forgetpassword_request.dart';
import 'package:starter_application/features/account/data/model/request/login_request.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/data/model/request/verify_request.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/presentation/screen/confirmPassword_screen.dart';
import 'package:starter_application/features/account/presentation/screen/set_username_screen.dart';
import 'package:starter_application/features/account/presentation/screen/start_personality_test.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/handman_help.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

import '../../../../../core/common/utils.dart';
import 'firebase_otp.dart';

class VerifyCodeNotifier extends ScreenNotifier {
  late BuildContext context;
  late RegisterRequest registerRequest;
  bool signUpCode = false;
  late FireBaseOTP fireBaseOTP;
  double? lat;
  double? lon;

  /// Variables
  String? code;
  bool? _isEditing;
  final accountCubit = AccountCubit();
  String? countryCode;
  bool isVerifyPhone = false;
  bool isSendingCode = false;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  /// Method

  void onCodeComplete(String value) {
    if (FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
    code = value;
    notifyListeners();
  }

  void onEditing(bool value) {
    _isEditing = value;
    code = null;
    notifyListeners();
  }

  void onVerifyTap() {
    if (code == null) {
      showErrorSnackBar(
          message: isArabic
              ? "لا يُمكن أن يكون الرمز فارغ"
              : "Verification code can't be empty");
    } else if (code!.isEmpty) {
      showErrorSnackBar(
          message: isArabic
              ? "لا يُمكن أن يكون الرمز فارغ"
              : "Verification code can't be empty");
    } else if (code!.length < 6) {
      showErrorSnackBar(
          message: isArabic
              ? "يجب ان يتكون الرمز من 6 أرقام"
              : "Verification code must be 6 numbers");
    } else {
      if (signUpCode) {
        if (code?.length == 6) {
          verifyPhoneCode();
        } else {
          showErrorSnackBar(
            message: "The code is not valid",
          );
        }
      } else {
        if (registerRequest.phoneNumber != null) {
          countryCode = countryCode
              .toString()
              .split('+')[countryCode.toString().split('+').length - 1];
          if (code?.length == 6) {
            registerRequest.verifyCode = code;
            verifyForgetPasswordCode();
          } else {
            showErrorSnackBar(
              message: "The code is not valid",
            );
          }
        } else {
          if (code?.length == 6) {
            registerRequest.verifyCode = code;

            accountCubit.ConfirmPasswordCode(
              ConfirmPasswordRequest(
                userNameOrEmailAddressOrPhoneNumber:
                    "${registerRequest.emailAddress}",
                code: registerRequest.verifyCode,
                isFromGooleAccount: false,
              ),
            );
          } else {
            showErrorSnackBar(
              message: "The code is not valid",
            );
          }
        }
      }
    }
  }

  onVerifyDone() {
    if (signUpCode) {
      print('dooooooooooone');
    } else {
      Nav.toAndRemoveAll(ConfirmPasswordScreen.routeName,
          arguments: registerRequest);
    }
  }

  @override
  void closeNotifier() {}

  verifyPhoneCode() async {
    changeVerifyStatus();
    fireBaseOTP = FireBaseOTP(
        phoneNumber: registerRequest.phoneNumber!,
        countryCode: registerRequest.countryCode!);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: registerRequest.verificationId!, smsCode: code!);
    bool result = await fireBaseOTP.verifyCode(phoneAuthCredential: credential);
    changeVerifyStatusToFalse();
    if (result) {
      if (registerRequest.register_or_confirm ?? false) {
          register();
      } else {
        int deviceType = 0;
        String deviceId = '';
        if (Platform.isAndroid) {
          deviceType = 1;
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.id;
        } else if (Platform.isIOS) {
          deviceType = 2;
          IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
          deviceId = iosDeviceInfo.identifierForVendor;
        }
        await getLocation();
        accountCubit.login(LoginRequest(
            userNameOrEmailAddressOrPhoneNumber: registerRequest.phoneNumber,
            password: registerRequest.password,
            countryCode: '00${registerRequest.countryCode}',
            devicedType: deviceType,
            devicedId: deviceId,
            long: lon,
            lat: lat));
      }
    } else {
      changeVerifyStatusToFalse();
    }
  }

  Future<void> getLocation() async {
    final location = await getUserLocationLogic(
        onBackTap: () {
          Nav.pop();
        },
        onRetryTap: () {
          getLocation();
          Nav.pop();
        },
        withoutDialogue: true);
    if (location != null) {
      lon = location.longitude;
      lat = location.latitude;
      notifyListeners();
    }
  }

  verifyForgetPasswordCode() async {
    changeVerifyStatus();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: registerRequest.verificationId!, smsCode: code!);
    fireBaseOTP = FireBaseOTP(
        phoneNumber: registerRequest.phoneNumber!,
        countryCode: registerRequest.countryCode!);
    bool result = await fireBaseOTP.verifyCode(phoneAuthCredential: credential);
    changeVerifyStatusToFalse();
    if (result) {
      Nav.toAndRemoveAll(ConfirmPasswordScreen.routeName,
          arguments: registerRequest);
    } else {
      changeVerifyStatusToFalse();
    }
  }

  changeVerifyStatus() {
    isVerifyPhone = !isVerifyPhone;
    notifyListeners();
  }

  changeVerifyStatusToFalse() {
    isVerifyPhone = false;
    notifyListeners();
  }

  reSendCode() async {
    if (signUpCode) {
      reSendOTPCodeFromFirebase();
    } else {
      if (registerRequest.phoneNumber != null) {
        reSendOTPCodeFromFirebase();
      } else {
        accountCubit.ForgetPassword(ForgetPasswordRequest(
            usernameOrEmailOrPhone: registerRequest.emailAddress));
      }
    }
  }

  void reSendOTPCodeFromFirebase() async {
    changeSendingCodeStatus();
    String codeForFirebase = registerRequest.countryCode!.substring(2);
    fireBaseOTP = FireBaseOTP(
        phoneNumber: registerRequest.phoneNumber!,
        countryCode: registerRequest.countryCode!);
    fireBaseOTP.sendCode(
      verificationCompleted: (PhoneAuthCredential credential) {
        print('complete');
        changeSendingCodeStatusToFalse();
      },
      verificationFailed: (e) {
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());
        showErrorSnackBar(
            message: e.message,
            context: context,
            callback: reSendOTPCodeFromFirebase);
      },
      onCodeSent: (verificationId, resendToken) {
        changeSendingCodeStatusToFalse();
        registerRequest.verificationId = verificationId;
        accountCubit.emit(AccountState.accountInit());
        showSnackbar(isArabic
            ? "لقد ارسلنا رسالة نصية تحوي كود التفعيل إلى الرقم "
            : "We’ve sent a text message with your verification code to");
      },
    );
  }

  changeSendingCodeStatusToFalse() {
    isSendingCode = false;
    notifyListeners();
  }

  changeSendingCodeStatus() {
    isSendingCode = !isSendingCode;
    notifyListeners();
  }

  // new code for register without username

  void register() {
    DateTime defaultBirthDate = DateTime(2000, 1, 1);
    registerRequest.firstName = registerRequest.emailAddress!.split('@')[0];
    registerRequest.lastName = registerRequest.emailAddress!.split('@')[0];
    registerRequest.userName = registerRequest.emailAddress!.split('@')[0];
    registerRequest.birthDate = DateFormat.yMd('en').format(defaultBirthDate);
    UserSessionDataModel.provider = 'normal';
    accountCubit.register(
      registerRequest,
    );
  }

  confirmPhoneNumber() {
    accountCubit.confirmPhoneNumber(
        ConfirmPhoneNumberParams(phoneNumbr: registerRequest.phoneNumber!));
  }


  onPhoneNumberConfirmed() async {
    int deviceType = 0;
    String deviceId = '';
    if (Platform.isAndroid) {
      deviceType = 1;
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      deviceType = 2;
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    }
    await getLocation();
    accountCubit.login(LoginRequest(
        userNameOrEmailAddressOrPhoneNumber: registerRequest.phoneNumber,
        password: registerRequest.password,
        countryCode: '00${registerRequest.countryCode}',
        devicedType: deviceType,
        devicedId: deviceId,
        lat: lat,
        long: lon));
  }

  Future<void> onLoginSuccess(LoginEntity loginEntity) async {
    final userType = int2UserType(loginEntity.result.userType);
    if (userType == UserType.OTHER) {
      showErrorToast(
          message: "Phone number or password are not correct",
          errVToastOptions: const ErrVToastOptions());
      return;
    }
    final prefs = await SpUtil.getInstance();
    await prefs.putString(
        AppConstants.KEY_TOKEN, 'Bearer ${loginEntity.result.accessToken}');
    await prefs.putInt(AppConstants.KEY_USERID, loginEntity.result.userId);
    final session = Provider.of<SessionData>(context, listen: false);
    await session.getSessionDataFromSP();
    await UserSessionDataModel.saveProfile(
        loginEntity.result.accessToken,
        loginEntity.result.userId,
        loginEntity.result.shopId,
        loginEntity.result.userType,
        loginEntity.result.fullName,
        loginEntity.result.name,
        loginEntity.result.birthday,
        loginEntity.result.surname,
        loginEntity.result.emailAddress,
        loginEntity.result.isEmailConfirmed,
        loginEntity.result.phoneNumber,
        loginEntity.result.isPhoneNumberConfirmed,
        loginEntity.result.cityId,
        loginEntity.result.imageUrl,
        loginEntity.result.cover,
        loginEntity.result.code,
        loginEntity.result.points,
        loginEntity.result.status,
        loginEntity.result.gender,
        loginEntity.result.userName,
        loginEntity.result.address,
        loginEntity.result.qrCode,
        loginEntity.result.countryCode,
        loginEntity.result.avatarMonth);
    await loginHandyMan(userEntity: loginEntity);

    Nav.toAndRemoveAll(AppMainScreen.routeName);
  }

  Future<bool> loginHandyMan({LoginEntity? userEntity}) async {
    try {
      final prefs = await SpUtil.getInstance();
      Map<String, dynamic> request = {
        'email': userEntity!.result.emailAddress.trim(),
        'password': registerRequest.password,
        'player_id': '',
      };
      var res = await HandManHelp.loginCurrentUsers(context, req: request);

      final userDataJson = json.encode(res.toJson());
      await prefs.putString(AppConstants.KEY_HANDYMAN_SERVICE, userDataJson);
      return true;
    } catch (e) {
      registerHandyMan(userEntity: userEntity);
      return false;
    }
  }

  Future<bool> registerHandyMan({LoginEntity? userEntity}) async {
    try {
      UserData userResponse = UserData()
        ..contactNumber = userEntity!.result.phoneNumber
        ..firstName = userEntity.result.name
        ..lastName = userEntity.result.surname
        ..loginType = "mobile"
        ..username = userEntity.result.fullName
        ..email = userEntity.result.emailAddress
        ..password = registerRequest.password;
      await HandManHelp.createUser(userResponse.toJson())
          .then((registerResponse) async {
        var response = registerResponse;

        await loginHandyMan(
          userEntity: userEntity,
        );
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
