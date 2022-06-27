
import 'package:flutter/material.dart';
import 'package:elmoktaser_elshamel/modules/general_screens/_exports.dart';
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
