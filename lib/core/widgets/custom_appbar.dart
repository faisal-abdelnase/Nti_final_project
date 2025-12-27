import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/widgets/top_appbar/background.dart';
import 'package:nti_final_project/core/widgets/top_appbar/default_content.dart';
import 'package:nti_final_project/core/widgets/top_appbar/search_content.dart';
import 'package:flutter/services.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTopAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(110.h);

  @override
  State<CustomTopAppBar> createState() => _CustomTopAppBarState();
}

class _CustomTopAppBarState extends State<CustomTopAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openSearch() {
    setState(() => _isSearching = true);
  }

  void _closeSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: SizedBox(
        height: 100.h,
        width: double.infinity,
        child: Stack(
          children: [
            const TopAppBarBackground(),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SizedBox(
                  height: 75.h,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _isSearching
                        ? TopAppBarSearchContent(
                            controller: _searchController,
                            onClosePressed: _closeSearch,
                          )
                        : TopAppBarDefaultContent(onSearchPressed: _openSearch),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
