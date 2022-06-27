

import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/_exports.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getUserCertificates(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: ElmoktaserAppbar(
            context,
            titleText: 'Certificates'.tr(),
          ),
          body: BuildCondition(
              condition: state is GetUserCertificatesLoadingState,
              builder: (context) => AppUtil.appLoader(height: 18.h),
              fallback: (context) {
                return 
               cubit.userCertificateModel!.data!.isEmpty? Column(
                        children: [
                          SizedBox(
                            height: 7.h,
                          ),
                          AppUtil.emptyLottie(),
                          SizedBox(
                            height: 4.h,
                          ),
                           AppText('there_are_no_certificates_yet'.tr())
                        ],
                      ):
                AnimatedListHandler(children: [
                  ...cubit.userCertificateModel!.data!
                      .asMap()
                      .entries
                      .map((e) => CertificateCard(
                            certificateItem: e.value,
                          ))
                ]);
              }),
        );
      },
    );
  }
}
