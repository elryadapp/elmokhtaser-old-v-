import 'package:easy_localization/easy_localization.dart';
import 'package:elmoktaser_elshamel/blocs/profile_cubit/profile_cubit.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/components/certificate_image.dart';
import 'package:elmoktaser_elshamel/routes/app_routes.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:elmoktaser_elshamel/shared/utilities/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CertificateViewScreen extends StatefulWidget {
  final dynamic certificateItem;

  const CertificateViewScreen({Key? key, required this.certificateItem})
      : super(key: key);

  @override
  State<CertificateViewScreen> createState() => _CertificateViewScreenState();
}

class _CertificateViewScreenState extends State<CertificateViewScreen> {
  @override
  void initState() {
    var cubit = ProfileCubit.get(context);
    cubit
        .takeImage(widget.certificateItem)
        .then((value) => cubit.makeDir(cubit.imageFile));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: ElmoktaserAppbar(
              context,
              titleText: 'show_certificate'.tr(),
            ),
            body: Container(
              margin: EdgeInsets.all(1.5.h),
              padding: EdgeInsets.all(2.h),
              decoration: BoxDecoration(
                  color: AppUi.colors.whiteColor,
                  boxShadow: [
                    BoxShadow(blurRadius: 4, color: AppUi.colors.shadeColor)
                  ],
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CertificateImage(certificateItem: widget.certificateItem),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: AppText(
                      widget.certificateItem.course!.title!,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(IconBroken.Calendar,color: AppUi.colors.mainColor,),
                        const SizedBox(
                          width: 5,
                        ),
                        AppText(DateFormat.yMd().format(DateTime.parse(
                            widget.certificateItem.createdAt ??
                                widget.certificateItem.updatedAt))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  AppButton(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.pdfPreview);
                    },
                    height: 5.5.h,
                    title: 'certificate_download'.tr(),
                  )
                ],
              ),
            ));
      },
    );
  }
}
