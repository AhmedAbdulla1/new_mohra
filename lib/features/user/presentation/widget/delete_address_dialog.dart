
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/text_style_extension.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/dialogs/show_dialog.dart';
import 'package:starter_application/generated/l10n.dart';

void showDeleteAddressDialog({
  required BuildContext context,
  required Function() onConfirm,
  Function()? onCancel,
}) {
  ShowDialog().showElasticDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return DeleteAddressDialog(
        onConfirm: onConfirm,
        onCancel: onCancel,
      );
    },
  );
}

class DeleteAddressDialog extends StatefulWidget {
  const DeleteAddressDialog(
      { required this.onConfirm, this.onCancel});

  final Function() onConfirm;
  final Function()? onCancel;

  @override
  State createState() => new LanguageDialogState();
}

class LanguageDialogState extends State<DeleteAddressDialog> {
  int? _selectedId = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.dp15),
        ),
      ),
      title: Text(
        Translation.current.delete_address_title,
        style: Colors.black.bodyText1,
      ),
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Gaps.vGap40,
            Text(
              Translation.current.delete_address_message,
              style: const TextStyle(
                color: AppColors.black,
              ),
            ),
            Gaps.vGap40,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Text(
                    Translation.of(context).cancel,
                  ),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    Nav.pop();
                  },
                ),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      ScreenUtil().setWidth(35),
                    ),
                  ),
                  child: Text(
                    Translation.of(context).confirm,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: widget.onConfirm,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}