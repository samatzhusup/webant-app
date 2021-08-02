import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';

import '../../../../gallery_icons_icons.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key, this.searchController}) : super(key: key);
  final TextEditingController searchController;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      child: TextFormField(
        cursorColor: AppColors.mainColorAccent,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.colorOfSearchBar,
          contentPadding: EdgeInsets.all(8),
          hintText: S.of(context).hintSearch,
          hintStyle: TextStyle(
            fontSize: 17,
            color: AppColors.mainColorAccent,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.mainColorAccent,
          ),
          suffixIcon: widget.searchController.text.isEmpty ? null :
          IconButton(
            icon: Icon(GalleryIcons.cancel),
            onPressed: () => widget.searchController.clear(),
            color: AppColors.mainColorAccent,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: AppColors.decorationColor)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.colorWhite),
          ),
        ),
        controller: widget.searchController,
      ),
    );
  }
}
