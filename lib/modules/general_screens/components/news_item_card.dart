import 'package:elmoktaser_elshamel/modules/general_screens/_exports.dart';


import 'package:flutter/material.dart';
class NewsItemCard extends StatelessWidget {
  final NewsItem? newsItem;
  final bool isDetailed;
  const NewsItemCard({ Key? key, this.isDetailed =false,  this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppUi.colors.whiteColor,
          boxShadow: [
            BoxShadow(color: AppUi.colors.borderColor, blurRadius: 5)
          ]),
      width: 90.w,
      margin: EdgeInsets.only(top: 2.h,bottom: 1.2.h,left: 4.5.w,right: 4.5.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(AppUi.assets.networkImageBaseLink+newsItem!.image!)),
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                        Icon(IconBroken.Calendar,color: AppUi.colors.mainColor,),
               const SizedBox(
                width: 5,
              ),
             
               AppText(DateFormat.yMd().format(DateTime.parse(newsItem!.createdAt!)) ),
              
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.2.h),
            child:  AppText(
           newsItem?.title??   '',
              maxLines: 2,
              height: 1.7,
              textAlign: TextAlign.end,
            ),
          ),
        RowBtn(route:Routes.newsDetails ,newsId: newsItem!.id!, title:   'show_news'.tr())
        
        ],
      ),
    );
  }
}