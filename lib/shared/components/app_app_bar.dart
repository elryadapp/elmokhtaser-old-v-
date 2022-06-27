
import 'package:elmoktaser_elshamel/blocs/cart_cubit/cart_cubit.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'app_text.dart';

class ElmoktaserAppbar extends AppBar {
  ElmoktaserAppbar(
    context, {
    Key? key,
    bool? isTitleCenterd,
    Widget? leading,
    bool? isLeading = true,
    bool? isActionAvilable = true,
    Color? leadingIconColor,
    Color? backIconColor,
    Widget? title,
    bool? showMenu,
    Widget? flexibleSpace,
    String? titleText,
    List<Widget>? actions,
    void Function()? onActionTap,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
  }) : super(
          key: key,
          leadingWidth: isLeading! ? 12.w : 0,
          bottom: bottom,
          leading: leading ??
              (isLeading
                  ? IconButton(
                      onPressed: () {
       

                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ))
                  : Container()),
          title: title ??
              AppText(
                titleText ?? '',
                color: AppUi.colors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                textOverflow: TextOverflow.visible,
              ),
          actions: actions ??
              [
                !isActionAvilable!
                    ? Container()
                    :   InkWell(
                      onTap:(){
                        Navigator.pushNamed(context, Routes.card).then((value) {
                          
                        });

                      },
                      child: Stack(
                                    alignment: AlignmentDirectional.topStart,
                                    children: [
                                      Image.asset(AppUi.assets.cardIcon),
                                      CircleAvatar(
                      radius: 2.5.w,
                      child: AppText(
                       '${CartCubit.get(context).cartItemList.length}',
                        fontSize: 8.sp,
                        textAlign: TextAlign.center,
                        color:CartCubit.get(context).cartItemList.isNotEmpty
                            ? AppUi.colors.whiteColor
                            : Colors.transparent,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor:CartCubit.get(context).cartItemList.isNotEmpty
                          ? AppUi.colors.buttonColor
                          : Colors.transparent,
                                      )
                                    ],
                                  ),
                    ),
              ],
          centerTitle: isTitleCenterd ?? true,
          flexibleSpace: flexibleSpace,
          elevation: 0.0,
        );
}
