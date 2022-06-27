import 'package:elmoktaser_elshamel/modules/general_screens/components/news_detail_card.dart';
import 'package:elmoktaser_elshamel/shared/components/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class NewsDetailsScreen extends StatelessWidget {
  final dynamic newsId;
  const NewsDetailsScreen({Key? key, required this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ElmoktaserAppbar(
        context,
        titleText: 'news_details'.tr(),
      ),
      body:NewsDetailCard(newsId: newsId,)
    );
  }
}
