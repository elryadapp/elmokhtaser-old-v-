
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/certificates_screens/_exports.dart';

class CertificateCard extends StatelessWidget {
  final CertificateItem certificateItem;
  const CertificateCard({Key? key, required this.certificateItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        child: Row(
          children: [
             ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                AppUi.assets.networkImageBaseLink+certificateItem.course!.image!,
                width: 32.w,
                height: 12.h,
                fit: BoxFit.cover,
              ),
            ),
           
          SizedBox(
              width: 5.w,
            ),
               Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
               const SizedBox(
                  height: 5,
                ),
                AppText(
                 certificateItem.course!.title!,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
                     Padding(
                       padding:  EdgeInsets.symmetric(vertical: 1.h),
                       child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
                        Icon(IconBroken.Calendar,color: AppUi.colors.mainColor,),
             const SizedBox(
              width: 5,
            ),
             AppText(DateFormat.yMd().format(DateTime.parse(certificateItem.createdAt??certificateItem.updatedAt)) ),
           
          ],
        ),
                     ),
                 RowBtn(route:Routes.certificateView ,args: certificateItem ,title:   'show_certificate'.tr())
              ],
            )),
            
           
          ],
        ),
      ),
    );
  }
}
