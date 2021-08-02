import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/ui/scenes/gallery/add_photo/add_photo_bloc/add_photo_bloc.dart';
import 'package:webant/presentation/ui/scenes/gallery/add_photo/upload_photo.dart';

class PhotoBottomSheet extends StatelessWidget {
  PhotoBottomSheet({Key key, this.photo, this.index}) : super(key: key);
  final PhotoModel photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: Text(
            S.of(context).actionSheetEditPhoto,
            style: TextStyle(color: AppColors.decorationColor),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadPhoto(photo: photo),
              ),
            );
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            S.of(context).actionSheetDeletePhoto,
            style: TextStyle(color: AppColors.decorationColor),
          ),
          onPressed: () {
            context.read<AddPhotoBloc>().add(DeletingPhoto(photo));
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: S.of(context).msgDeletedPhoto,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColors.mainColorAccent,
                textColor: Colors.white,
                fontSize: 16.0);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          S.of(context).cancel,
          style: TextStyle(color: AppColors.decorationColor),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
