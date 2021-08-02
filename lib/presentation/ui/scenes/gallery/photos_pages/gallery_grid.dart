import 'dart:async';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/resources/app_strings.dart';
import 'package:webant/presentation/ui/scenes/gallery/add_photo/add_photo_bloc/add_photo_bloc.dart';
import 'package:webant/presentation/ui/scenes/gallery/main/new_or_popular_photos.dart';
import 'package:webant/presentation/ui/scenes/gallery/photos_pages/single_photo.dart';
import 'package:webant/presentation/ui/scenes/gallery/search_photo/search_photo_bloc/search_photo_bloc.dart';
import 'package:webant/presentation/ui/scenes/user_profile/firestore_bloc/firestore_bloc.dart';
import 'package:webant/presentation/ui/scenes/widgets/loading_circular.dart';
import 'package:webant/presentation/ui/scenes/widgets/photo_bottom_sheet.dart';

import 'gallery_bloc/gallery_bloc.dart';

class GalleryGrid extends StatefulWidget {
  final typeGrid type;
  final int crossCount;
  final queryText;
  final String keyName;

  GalleryGrid({Key key, this.type, this.crossCount, this.queryText, this.keyName})
      : super(key: key);

  @override
  _GalleryGridState createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  Completer<void> _reFresh;
  List<PhotoModel> _photos;
  bool _isLastPage;

  @override
  void initState() {
    super.initState();
    _reFresh = Completer<void>();
    _isLastPage = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _photosGrid(List<PhotoModel> photos) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!_isLastPage &&
            scrollInfo.metrics.extentBefore ==
                scrollInfo.metrics.maxScrollExtent &&
            scrollInfo is ScrollEndNotification) {
          if (widget.type == typeGrid.PHOTOS) {
            context.read<GalleryBloc>().add(GalleryFetch());
            return true;
          }
          if (widget.type == typeGrid.SEARCH) {
            context
                .read<SearchPhotoBloc>()
                .add(Searching(queryText: widget.queryText, newQuery: false));
            return true;
          }
        }
        return false;
      },
      child: CustomScrollView(
        key: PageStorageKey<String>(widget.keyName),
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext c, int i) => Container(
                  child: GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(widget.crossCount != null ? 0 : 10.0),
                        child: Hero(
                          tag: photos[i].id,
                          child: photos[i].isPhotoSVG()
                              ? SvgPicture.network(photos[i].getImage())
                              : FancyShimmerImage(
                                  imageUrl: photos[i].getImage(),
                                  boxFit: BoxFit.cover,
                                ),
                        ),
                      ),
                      onTap: () => _toScreenInfo(photos[i]),
                      onLongPress: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                                PhotoBottomSheet(photo: photos[i]));
                      }),
                ),
                childCount: photos?.length ?? 0,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossCount ?? 2,
                childAspectRatio: 1,
                mainAxisSpacing: 9,
                crossAxisSpacing: 9,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child:  _isLastPage
                ? Container()
                : Center(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child:CircularProgressIndicator(
                          color: AppColors.mainColorAccent,
                          strokeWidth: 2.0,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(context) {
    return MultiBlocListener(
      listeners: [
        widget.type == typeGrid.PHOTOS
            ? BlocListener<GalleryBloc, GalleryState>(
                listener: (context, state) {
                  setState(() {
                    _reFresh?.complete();
                    _reFresh = Completer();
                  });
                  if (state is GalleryData) {
                    setState(() {
                      _photos =
                          state.photosBox.values.toList().cast<PhotoModel>();
                    });
                    if (state.isLastPage) {
                      setState(() {
                        _isLastPage = true;
                      });
                    }
                  }
                },
              )
            : BlocListener<SearchPhotoBloc, SearchPhotoState>(
                listener: (context, state) {
                  setState(() {
                    _reFresh?.complete();
                    _reFresh = Completer();
                  });
                  if (state is Search) {
                    _photos = state.photos;
                    if (state.isLastPage) {
                      setState(() {
                        _isLastPage = true;
                      });
                    } else {
                      setState(() {
                        _isLastPage = false;
                      });
                    }
                  }
                },
              ),
      ],
      child: RefreshIndicator(
        color: AppColors.mainColorAccent,
        backgroundColor: AppColors.colorWhite,
        strokeWidth: 2.0,
        onRefresh: () async {
          if (widget.type == typeGrid.PHOTOS) {
            context.read<GalleryBloc>().add(GalleryRefresh());
          }
          if (widget.type == typeGrid.SEARCH) {
            context
                .read<SearchPhotoBloc>()
                .add(Searching(queryText: widget.queryText, newQuery: true));
          }
          return _reFresh.future;
        },
        child: _selectBloc(),
      ),
    );
  }

  Widget _selectBloc() {
    if (widget.type == typeGrid.SEARCH) {
      return BlocBuilder<SearchPhotoBloc, SearchPhotoState>(
        builder: (context, state) {
          if (state is Loading) {
            return LoadingCircular();
          }
          if (state is Search) {
            return _photosGrid(state.photos);
          }
          if (state is NotFound) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                  children: [
                    Image.asset(AppStrings.imageIntersect),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: Text(
                        S.of(context).errorFoundImage,
                        style: TextStyle(
                            color: AppColors.mainColorAccent, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is InternetError) {
            return _pageError();
          }
          return Container();
        },
      );
    }
    if (widget.type == typeGrid.PHOTOS) {
      return BlocBuilder<GalleryBloc, GalleryState>(builder: (context, state) {
        if (state is GalleryLoaded) {
          return LoadingCircular();
        }
        if (state is GalleryData) {
          return _photosGrid(_photos);
        }
        if (state is GalleryInternetLost) {
          return _pageError();
        }
        return Container();
      });
    }
    return Container();
  }

  void _toScreenInfo(PhotoModel photo) {
    context.read<AddPhotoBloc>().add(ViewsCounter(photo));
    context.read<FirestoreBloc>().add(GetTags(photo));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScreenInfo(photo: photo),
      ),
    );
  }

  Widget _pageError() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 250, bottom: 8),
              child: Image.asset(AppStrings.imageIntersect),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                S.of(context).errorSorry,
                style: TextStyle(
                    fontSize: 25,
                    color: AppColors.mainColorAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              S.of(context).errorLoadedPhoto,
              style: TextStyle(color: AppColors.mainColorAccent),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
