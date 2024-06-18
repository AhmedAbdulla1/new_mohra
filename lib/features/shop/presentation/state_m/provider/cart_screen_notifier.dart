import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/checkout_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class CartScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late bool isSelectAll = false;
  late int numOfItem = 0;
  late double total = 0;
  late int selectShipping = -1;
  Cart? cart = AppConfig().appContext.read<Cart>();

  /// Getters and Setters

//Methods
  void onItemCartTap(int index) {
    /*   print("index$index");
    print("value$value");
    if (selectedCartIndexes.contains(index)) {
      selectedCartIndexes.remove(index);
      total -= double.parse(items[index].price) * value;
      AppConstants.totalP = total;
    } else {
      total += double.parse(items[index].price) * value;
      AppConstants.totalP = total;
      selectedCartIndexes.add(index);
    }
    notifyListeners(); */
  }

  // void deleteItem(int index, int value) {
  //   if(selectedCartItemIndexes.contains(index))
  //     {
  //       selectedCartItemIndexes.length--;
  //       total -= double.parse(items[index].price) * value;
  //       items.removeAt(index);
  //     }
  //   else
  //     {
  //       items.removeAt(index);
  //       selectedCartIndexes.add(index);
  //     }
  //   notifyListeners();
  //   // print("indexDelete$index");
  //   // print("valueDelete$value");
  //   // if (selectedCartItemIndexes.contains(index)) {
  //   //   selectedCartItemIndexes.length--;
  //   //   total-=double.parse(items[index].price)*value;
  //   //   items.removeAt(index);
  //   // } else {
  //   //   selectedCartItemIndexes.length--;
  //   //   selectedCartIndexes.add(index);
  //   //   items.removeAt(index);
  //   // }
  //   // notifyListeners();
  // }
  //
  // void onInAdd(int value, int index) {
  //   /* if (selectedCartItemIndexes.contains(index)) {
  //     total += double.parse(items[index].price);
  //     AppConstants.totalP = total;
  //   }
  //   notifyListeners(); */
  // }
  //
  // void deleteAll() {
  //   /* items.clear();
  //   items.clear(); */
  // }
  //
  // void onInRemove(int value, int index) {
  //   /*    if (selectedCartItemIndexes.contains(index)) {
  //     total -= double.parse(items[index].price);
  //     AppConstants.totalP = total;
  //   }
  //   notifyListeners(); */
  // }

  void onClearCartTap() {
    cart!.clear();
    notifyListeners();
  }

  void onCheckout() {
    Nav.to(CheckoutScreen.routeName);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) =>
    //           PaymentPage()), // Notice that i send the Picked date in
    // );
    notifyListeners();
  }

  @override
  void closeNotifier() {
    cart = null;
    this.dispose();
  }
}

// .test

class ShippingMethod {
  String image;
  String name;
  String title;
  String price;

  ShippingMethod(this.image, this.name, this.title, this.price);
}
