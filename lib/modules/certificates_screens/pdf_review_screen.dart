
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/_exports.dart';

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
