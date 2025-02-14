import 'package:booking_system_flutter/component/price_widget.dart';
import 'package:booking_system_flutter/services/flutter_wave_service_new.dart';
import 'package:booking_system_flutter/utils/extensions/num_extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/payment_params.dart';
import 'package:starter_application/core/ui/screens/payment_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../component/base_scaffold_widget.dart';
import '../../component/empty_error_state_widget.dart';
import '../../main.dart';
import '../../model/configuration_response.dart';
import '../../network/rest_apis.dart';
import '../../services/cinet_pay_services_new.dart';
import '../../services/razorpay_service_new.dart';
import '../../services/sadad_services_new.dart';
import '../../services/stripe_service_new.dart';
import '../../utils/colors.dart';
import '../../utils/common.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import 'package:moyasar/moyasar.dart';

class UserWalletBalanceScreen extends StatefulWidget {
  const UserWalletBalanceScreen({Key? key}) : super(key: key);

  @override
  State<UserWalletBalanceScreen> createState() =>
      _UserWalletBalanceScreenState();
}

class _UserWalletBalanceScreenState extends State<UserWalletBalanceScreen> {
  TextEditingController walletAmountCont = TextEditingController(text: '0');
  FocusNode walletAmountFocus = FocusNode();
  late CardPaymentResponseSource sourceMap;

  List<int> defaultAmounts = [150, 200, 500, 1000, 5000, 10000];
  List<PaymentSetting> paymentList = [];
  PaymentSetting? currentPaymentMethod;

  @override
  void initState() {
    super.initState();
    appStore.setUserWalletAmount();

    paymentList = PaymentSetting.decode(getStringAsync(PAYMENT_LIST));
    paymentList.removeWhere((element) => element.type == PAYMENT_METHOD_COD);

    ///TODO We are disabling razorpay temporarily because razorpay library has issue in wallet payments
    paymentList.removeWhere((element) => element.type == PAYMENT_METHOD_RAZOR);
  }

  void _handleClick() async {
    if (currentPaymentMethod == null) {
      return toast(language.pleaseChooseAnyOnePayment);
    } else if (walletAmountCont.text.toDouble() == 0) {
      return toast(language.theAmountShouldBeEntered);
    }

    if (currentPaymentMethod!.type == PAYMENT_METHOD_STRIPE) {
      StripeServiceNew stripeServiceNew = StripeServiceNew(
        paymentSetting: currentPaymentMethod!,
        totalAmount: walletAmountCont.text.toDouble(),
        onComplete: (p0) {
          Map req = {
            "amount": walletAmountCont.text.toDouble(),
            "transaction_type": PAYMENT_METHOD_STRIPE,
            "transaction_id": p0['transaction_id']
          };

          walletTopUp(req);
        },
      );

      stripeServiceNew.stripePay();
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_RAZOR) {
      RazorPayServiceNew razorPayServiceNew = RazorPayServiceNew(
        paymentSetting: currentPaymentMethod!,
        totalAmount: walletAmountCont.text.toDouble(),
        onComplete: (p0) {
          log(p0);
          Map req = {
            "amount": walletAmountCont.text.toDouble(),
            "transaction_type": PAYMENT_METHOD_RAZOR,
            "transaction_id": p0['orderId']
          };

          walletTopUp(req);
        },
      );
      razorPayServiceNew.razorPayCheckout();
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_FLUTTER_WAVE) {
      FlutterWaveServiceNew flutterWaveServiceNew = FlutterWaveServiceNew();

      flutterWaveServiceNew.checkout(
        paymentSetting: currentPaymentMethod!,
        totalAmount: walletAmountCont.text.toDouble(),
        onComplete: (p0) {
          Map req = {
            "amount": walletAmountCont.text.toDouble(),
            "transaction_type": PAYMENT_METHOD_FLUTTER_WAVE,
            "transaction_id": p0['transaction_id']
          };

          walletTopUp(req);
        },
      );
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_CINETPAY) {
      List<String> supportedCurrencies = ["XOF", "XAF", "CDF", "GNF", "USD"];

      if (!supportedCurrencies.contains(appStore.currencyCode)) {
        toast(language.cinetPayNotSupportedMessage);
        return;
      } else if (walletAmountCont.text.toDouble() < 100) {
        return toast(
            '${language.totalAmountShouldBeMoreThan} ${100.toPriceFormat()}');
      } else if (walletAmountCont.text.toDouble() > 1500000) {
        return toast(
            '${language.totalAmountShouldBeLessThan} ${1500000.toPriceFormat()}');
      }

      CinetPayServicesNew cinetPayServices = CinetPayServicesNew(
        paymentSetting: currentPaymentMethod!,
        totalAmount: walletAmountCont.text.toDouble(),
        onComplete: (p0) {
          Map req = {
            "amount": walletAmountCont.text.toDouble(),
            "transaction_type": PAYMENT_METHOD_CINETPAY,
            "transaction_id": p0['transaction_id']
          };

          walletTopUp(req);
        },
      );

      cinetPayServices.payWithCinetPay(context: context);
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_SADAD_PAYMENT) {
      SadadServicesNew sadadServices = SadadServicesNew(
        paymentSetting: currentPaymentMethod!,
        totalAmount: walletAmountCont.text.toDouble(),
        remarks: language.topUpWallet,
        onComplete: (p0) {
          Map req = {
            "amount": walletAmountCont.text.toDouble(),
            "transaction_type": PAYMENT_METHOD_SADAD_PAYMENT,
            "transaction_id": p0['transaction_id'],
          };

          walletTopUp(req);
        },
      );

      sadadServices.payWithSadad(context);
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_Mohra) {
      showMohraPayment();
    }
    // else if (currentPaymentMethod!.type == PAYMENT_METHOD_PAYPAL) {
    //   PayPalService.paypalCheckOut(
    //     context: context,
    //     paymentSetting: currentPaymentMethod!,
    //     totalAmount: walletAmountCont.text.toDouble(),
    //     onComplete: (p0) {
    //       debugPrint('PayPalService onComplete: $p0');
    //       Map req = {"amount": walletAmountCont.text.toDouble(), "transaction_type": PAYMENT_METHOD_PAYPAL, "transaction_id": p0['transaction_id']};
    //       walletTopUp(req);
    //     },
    //   );
    // }
  }

  showMohraPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentPage(
                params: PaymentParams(
                  amount: walletAmountCont.text.toDouble(),
                  onSuccessPayment: (p0) {
                    finish(context);
                    Map req = {
                      "amount": walletAmountCont.text.toDouble(),
                      "transaction_type": PAYMENT_METHOD_SADAD_PAYMENT,
                      "transaction_id": p0.id,
                    };

                    walletTopUp(req);
                    setState(() {});
                  },
                  onFailedPayment: (p0) {
                    if (p0.source is CardPaymentResponseSource) {
                      sourceMap = p0.source as CardPaymentResponseSource;
                      finish(context);
                      setState(() {});
                    }
                    Fluttertoast.showToast(
                        msg: getErrorMessages(sourceMap.message ??
                            Translation.of(context).paymentFailed));
                  },
                ),
                metadata: {
                  "User Name": "${UserSessionDataModel.fullName}",
                  "Email": "${UserSessionDataModel.emailAddress}",
                  "Phone Number": "${UserSessionDataModel.phoneNumber}",
                  "Wallet": "Fill the wallet"
                },
              )), // Notice that i send the Picked date in
    );
  }

  getErrorMessages(String msg) {
    switch (msg) {
      case "INSUFFICIENT_FUNDS":
        return language.card_funds;
      case "3-D Secure transaction attempt failed (Not Enrolled)":
        return language.transaction_attempt_failed;
      case "3-D Secure transaction attempt failed (DECLINED_INVALID_PIN)":
        return language.Invalid_PIN_rejected;
      case "DECLINED":
        return language.card_declined;
      case "UNSPECIFIED_FAILUER":
        return language.paymentFailed;
      default:
        return language.paymentFailed;
    }
  }

  String getPaymentMethodIcon(String value) {
    if (value == PAYMENT_METHOD_STRIPE) {
      return stripe_logo;
    } else if (value == PAYMENT_METHOD_RAZOR) {
      return razorpay_logo;
    } else if (value == PAYMENT_METHOD_CINETPAY) {
      return cinetpay_logo;
    } else if (value == PAYMENT_METHOD_FLUTTER_WAVE) {
      return flutter_wave_logo;
    } else if (value == PAYMENT_METHOD_SADAD_PAYMENT) {
      return "";
    } else if (value == PAYMENT_METHOD_PAYPAL) {
      return paypal_logo;
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: language.myWallet,
      child: AnimatedScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        listAnimationType: ListAnimationType.None,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width(),
                padding: const EdgeInsets.all(16),
                color: context.cardColor,
                child: Row(
                  children: [
                    Text(language.balance,
                            style: boldTextStyle(color: context.primaryColor))
                        .expand(),
                    Observer(
                        builder: (context) => PriceWidget(
                            price: appStore.userWalletAmount,
                            size: 16,
                            isBoldText: true)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.height,
                  Text(language.topUpWallet,
                      style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                  8.height,
                  Text(language.topUpAmountQuestion,
                      style: secondaryTextStyle()),
                  Container(
                    width: context.width(),
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: boxDecorationDefault(
                      color: walletCardColor,
                      borderRadius: radius(8),
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                          textFieldType: TextFieldType.NUMBER,
                          textAlign: TextAlign.center,
                          controller: walletAmountCont,
                          focus: walletAmountFocus,
                          textStyle: primaryTextStyle(color: Colors.white),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onTap: () {
                            if (walletAmountCont.text == '0') {
                              walletAmountCont.selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: walletAmountCont.text.length);
                            }
                          },
                          decoration: InputDecoration(
                            prefixText:
                                '${isCurrencyPositionLeft ? appStore.currencySymbol : ''}${isCurrencyPositionRight ? appStore.currencySymbol : ''}',
                            prefixStyle: primaryTextStyle(color: Colors.white),
                          ),
                          onChanged: (p0) {
                            //
                          },
                        ),
                        24.height,
                        Wrap(
                          spacing: 30,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children:
                              List.generate(defaultAmounts.length, (index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: boxDecorationDefault(
                                color: defaultAmounts[index].toString() ==
                                        walletAmountCont.text
                                    ? context.cardColor
                                    : Colors.white12,
                                borderRadius: radius(8),
                              ),
                              child: Text(
                                defaultAmounts[index]
                                    .toString()
                                    .formatNumberWithComma(),
                                style: primaryTextStyle(
                                    color: defaultAmounts[index].toString() ==
                                            walletAmountCont.text
                                        ? context.primaryColor
                                        : Colors.white),
                              ),
                            ).onTap(() {
                              walletAmountCont.text =
                                  defaultAmounts[index].toString();
                              setState(() {});
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  Text(language.paymentMethod,
                      style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                  4.height,
                  Text(language.selectYourPaymentMethodToAddBalance,
                      style: secondaryTextStyle()),
                  if (paymentList.isNotEmpty) 16.height,
                  if (paymentList.isNotEmpty)
                    AnimatedWrap(
                      itemCount: paymentList.length,
                      listAnimationType: ListAnimationType.FadeIn,
                      fadeInConfiguration:
                          FadeInConfiguration(duration: 2.seconds),
                      spacing: 8,
                      runSpacing: 18,
                      itemBuilder: (context, index) {
                        PaymentSetting value = paymentList[index];

                        if (value.status.validate() == 0) return const Offstage();
                        String icon =
                            getPaymentMethodIcon(value.type.validate());

                        return Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Container(
                                width: context.width() * 0.249,
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: boxDecorationDefault(
                                  borderRadius: radius(8),
                                  border: Border.all(color: primaryColor),
                                ),
                                //decoration: BoxDecoration(border: Border.all(color: primaryColor)),
                                alignment: Alignment.center,
                                child: icon.isNotEmpty
                                    ? Image.asset(icon)
                                    : Text(value.type.validate(),
                                        style: primaryTextStyle()),
                              ).onTap(() {
                                currentPaymentMethod = value;

                                setState(() {});
                              }),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: currentPaymentMethod == value
                                    ? const EdgeInsets.all(2)
                                    : EdgeInsets.zero,
                                decoration: boxDecorationDefault(
                                    color: context.primaryColor),
                                child: currentPaymentMethod == value
                                    ? const Icon(Icons.done,
                                        size: 16, color: Colors.white)
                                    : const Offstage(),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  else
                    NoDataWidget(
                      title: language.lblNoPayments,
                      imageWidget: const EmptyStateWidget(),
                    ),
                  30.height,
                  AppButton(
                    width: context.width(),
                    height: 16,
                    color: context.primaryColor,
                    text: language.proceedToTopUp,
                    textStyle: boldTextStyle(color: white),
                    onTap: () async {
                      hideKeyboard(context);
                      _handleClick();
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        ],
      ),
    );
  }
}
