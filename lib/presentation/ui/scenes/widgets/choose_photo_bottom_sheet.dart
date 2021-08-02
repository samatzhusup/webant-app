import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';


class ChoosePhotoBottomSheet extends StatelessWidget {
  ChoosePhotoBottomSheet(this._callBack);

  final void Function(ImageSource) _callBack;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              S
                  .of(context)
                  .bottomSheetCamera,
              style: TextStyle(color: AppColors.decorationColor),
            ),
          ),
          onPressed: () async {
            if (await Permission.camera
                .request()
                .isGranted) {
              Navigator.pop(context);
              _callBack(ImageSource.camera);
            }
          },
        ),
        CupertinoActionSheetAction(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              S
                  .of(context)
                  .bottomSheetGallery,
              style: TextStyle(color: AppColors.decorationColor),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            _callBack(ImageSource.gallery);
          },
        ),
      ],
    );
  }
}
