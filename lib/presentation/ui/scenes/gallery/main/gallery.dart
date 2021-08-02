import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant/data/repositories/http_photo_gateway.dart';
import 'package:webant/domain/models/photos_model/photo_model.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/ui/scenes/gallery/add_photo/select_photo.dart';
import 'package:webant/presentation/ui/scenes/gallery/search_photo/search_photo_bloc/search_photo_bloc.dart';
import 'package:webant/presentation/ui/scenes/user_profile/user_page.dart';

import '../../../../gallery_icons_icons.dart';
import 'new_or_popular_photos.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  int _bottomSelectedIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    _bottomSelectedIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _pageChanged(int index) {
    setState(() {
      _bottomSelectedIndex = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (int index) {
        _pageChanged(index);
      },
      children: <Widget>[
        BlocProvider<SearchPhotoBloc>(
            create: (BuildContext c) => SearchPhotoBloc<PhotoModel>(
                HttpPhotoGateway(type: typePhoto.SEARCH)),
            child: NewOrPopularPhotos()),
        SelectPhoto(),
        UserPage(),
      ],
    );
  }

  void _bottomTapped(int index) {
    setState(() {
      _bottomSelectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInCirc);
    });
  }

  List<BottomNavigationBarItem> _buildBottomBar() {
    return <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(GalleryIcons.home, size: 23),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(GalleryIcons.camera, size: 23),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(GalleryIcons.profile, size: 26),
        label: '',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: buildPageView(),
        bottomNavigationBar: SafeArea(
          child: BottomNavigationBar(
            backgroundColor: AppColors.colorWhite,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.decorationColor,
            unselectedItemColor: AppColors.mainColorAccent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: _buildBottomBar(),
            currentIndex: _bottomSelectedIndex,
            onTap: (int index) => _bottomTapped(index),
          ),
        ),
      ),
    );
  }
}
