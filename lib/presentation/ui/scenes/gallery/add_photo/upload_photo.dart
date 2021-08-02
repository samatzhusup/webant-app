import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/resources/app_styles.dart';
import 'package:webant/presentation/ui/scenes/gallery/main/gallery.dart';
import 'package:webant/presentation/ui/scenes/widgets/back_widget.dart';
import 'package:webant/presentation/ui/scenes/widgets/loading_circular.dart';

import 'add_photo_bloc/add_photo_bloc.dart';
import 'input_tags.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({Key key, this.image, this.photo}) : super(key: key);
  final File image;
  final PhotoModel photo;

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

enum typeValidator { NAME, DESCRIPTION }

class _UploadPhotoState extends State<UploadPhoto> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.photo?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.photo?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.colorWhite,
        appBar: AppBar(
          leading: BackWidget(),
          backgroundColor: AppColors.colorWhite,
          elevation: 1,
          actions: [
            TextButton(
              onPressed: _postPhoto,
              child: Text(
                (widget.photo == null
                    ? S.of(context).buttonAddPhoto
                    : S.of(context).buttonEditPhoto),
                style: TextStyle(
                    color: AppColors.decorationColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 17),
              ),
            ),
          ],
        ),
        body: BlocConsumer<AddPhotoBloc, AddPhotoState>(
          listener: (context, state) {
            if (state is ErrorPostPhoto) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.err),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingPostPhoto) {
              return Scaffold(
                backgroundColor: AppColors.colorWhite,
                body: LoadingCircular(),
              );
            }
            if (state is CompletePost) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<AddPhotoBloc>().add(InitialEvent());
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Gallery()),
                    (Route<dynamic> route) => false);
                Fluttertoast.showToast(
                    msg: S.of(context).msgPhotoModerated,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: AppColors.mainColorAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              });
            } else
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorOfSearchBar,
                        border: Border(
                          bottom: BorderSide(
                              color: AppColors.mainColorAccent, width: 1.0),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.center,
                        child: widget.photo == null
                            ? Image.file(widget.image)
                            : Image.network(widget.photo.getImage()),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                              child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).labelPhotoName,
                                    contentPadding: EdgeInsets.all(8.0),
                                    focusedBorder: AppStyles.borderTextField
                                        .copyWith(
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.decorationColor)),
                                    enabledBorder: AppStyles.borderTextField,
                                    focusedErrorBorder:
                                        AppStyles.borderTextField,
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return S.of(context).errorEmptyPhotoName;
                                    }
                                    return null;
                                  }),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              height: 100,
                              child: TextFormField(
                                controller: _descriptionController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: S.of(context).labelDescription,
                                  contentPadding: EdgeInsets.all(8.0),
                                  focusedBorder: AppStyles.borderTextField
                                      .copyWith(
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.mainColorAccent)),
                                  enabledBorder: AppStyles.borderTextField,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: InputTags(tags: _tags),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            return Container();
          },
        ),
      ),
    );
  }

  void _postPhoto() {
    if (_formKey.currentState.validate()) {
      if (widget.image != null) {
        context.read<AddPhotoBloc>().add(
              PostPhoto(
                  file: widget.image,
                  name: _nameController.text,
                  tags: _tags,
                  description: _descriptionController.text),
            );
      } else {
        context.read<AddPhotoBloc>().add(
              EditingPhoto(
                  photo: widget.photo,
                  name: _nameController.text,
                  tags: _tags,
                  description: _descriptionController.text),
            );
      }
    }
  }
}
