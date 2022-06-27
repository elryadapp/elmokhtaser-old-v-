import 'package:elmoktaser_elshamel/blocs/profile_cubit/profile_cubit.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart'as tr;
class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=ProfileCubit.get(context);

        return Scaffold(
           appBar: ElmoktaserAppbar(
              context,
              actions: const [],
              titleText: 'show_certificate'.tr(),
            ),
          body: PdfPreview(
            
            loadingWidget: AppUtil.appLoader(height: 16.h),
            build: (context) => cubit.makeDir(cubit.imageFile),
          ),
        );
      },
    );
  }
}
