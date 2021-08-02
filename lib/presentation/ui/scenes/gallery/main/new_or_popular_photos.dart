import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant/data/repositories/http_photo_gateway.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/ui/scenes/gallery/photos_pages/gallery_bloc/gallery_bloc.dart';
import 'package:webant/presentation/ui/scenes/gallery/photos_pages/gallery_grid.dart';

import 'package:webant/presentation/ui/scenes/gallery/search_photo/search_bar.dart';
import 'package:webant/presentation/ui/scenes/gallery/search_photo/search_photo_bloc/search_photo_bloc.dart';

class NewOrPopularPhotos extends StatefulWidget {
  const NewOrPopularPhotos({Key key}) : super(key: key);

  @override
  _NewOrPopularPhotosState createState() => _NewOrPopularPhotosState();
}

enum typePhoto { NEW, POPULAR, SEARCH_BY_USER, SEARCH }
enum typeGrid { PHOTOS, SEARCH }

class _NewOrPopularPhotosState extends State<NewOrPopularPhotos> {
  TextEditingController _searchController;
  bool _search;
  String _queryText;

  @override
  void initState() {
    super.initState();
    _search = false;
    _searchController = TextEditingController();
    _searchController.addListener(_searchListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _searchListener() {
    String searchText = _searchController.text;
    if (_searchController.text.isEmpty) {
      setState(() {
        _queryText = '';
        _search = false;
      });
    } else if (searchText != _queryText) {
      setState(() {
        _search = true;
        _queryText = _searchController.text;
        context
            .read<SearchPhotoBloc>()
            .add(Searching(queryText: _queryText, newQuery: true));
      });
    }
  }

  String _getQueryText() {
    return _queryText;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onHorizontalDragCancel: () =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: DefaultTabController(
          length: _search ? 1 : 2,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.colorWhite,
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      title: SearchBar(
                        searchController: _searchController,
                      ),
                      floating: true,
                      pinned: true,
                      snap: true,
                      forceElevated: innerBoxIsScrolled,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: AppColors.colorWhite,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(48),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TabBar(
                            tabs: _search
                                ? [Tab(text: S.of(context).tabBarTitleSearch)]
                                : ([
                                    Tab(text: S.of(context).tabBarTitleNew),
                                    Tab(text: S.of(context).tabBarTitlePopular)
                                  ]),
                            indicatorColor: AppColors.decorationColor,
                            labelColor: AppColors.mainColor,
                            unselectedLabelColor: AppColors.mainColorAccent,
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: _search
                  ? Builder(builder: (BuildContext context) {
                      return GalleryGrid(
                        type: typeGrid.SEARCH,
                        queryText: _getQueryText(),
                        keyName: 'search',
                      );
                    })
                  : TabBarView(
                      children: <Widget>[
                        BlocProvider<GalleryBloc>(
                            create: (context) => GalleryBloc<PhotoModel>(
                                HttpPhotoGateway(type: typePhoto.NEW))
                              ..add(GalleryFetch()),
                            child: Builder(builder: (BuildContext context) {
                              return GalleryGrid(
                                type: typeGrid.PHOTOS,
                                keyName: 'new',
                              );
                            })),
                        BlocProvider<GalleryBloc>(
                            create: (context) => GalleryBloc<PhotoModel>(
                                HttpPhotoGateway(type: typePhoto.POPULAR))
                              ..add(GalleryFetch()),
                            child: Builder(builder: (BuildContext context) {
                              return GalleryGrid(
                                type: typeGrid.PHOTOS,
                                keyName: 'popular',
                              );
                            })),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
