import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_final_project/core/theme/style_managers.dart';

void addOptionsPopup(BuildContext context) {
  final RenderBox button = context.findRenderObject() as RenderBox;
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      // Top-left of popup
      button.localToGlobal(
        const Offset(-20, 40), // ← left 20, ↓ down 40
        ancestor: overlay,
      ),

      // Bottom-right of popup
      button.localToGlobal(
        button.size.bottomRight(const Offset(-20, 40)),
        ancestor: overlay,
      ),
    ),

    Offset.zero & overlay.size,
  );

  showMenu(
    context: context,
    position: position,
    color: Colors.transparent,
    elevation: 0,
    items: [
      PopupMenuItem(
        enabled: false,
        padding: EdgeInsets.zero,
        child: Container(
          width: 329.w,
          height: 160.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 100,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 297.w,
                height: 56.h,
                child: Row(
                  children: [
                    SizedBox(width: 32.w),
                    Icon(Icons.person_outline_rounded),
                    SizedBox(width: 16.w),
                    Text('Add Friend', style: StyleManagers.font16Black500),
                  ],
                ),
              ),
              SizedBox(
                width: 297.w,
                height: 56.h,
                child: Row(
                  children: [
                    SizedBox(width: 32.w),
                    Icon(Icons.groups_outlined),
                    SizedBox(width: 16.w),
                    Text('Create Group', style: StyleManagers.font16Black500),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
