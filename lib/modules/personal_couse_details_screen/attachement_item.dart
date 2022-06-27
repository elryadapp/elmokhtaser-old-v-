import 'dart:isolate';
import 'dart:ui';
import 'package:elmoktaser_elshamel/blocs/courses_cubit/courses_cubit.dart';
import 'package:elmoktaser_elshamel/models/course_attachment_model.dart';
import 'package:elmoktaser_elshamel/shared/components/app_btn.dart';
import 'package:elmoktaser_elshamel/shared/components/app_text.dart';
import 'package:elmoktaser_elshamel/shared/utilities/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';

class AttachementItemWidget extends StatefulWidget {
  final AttachmentItem attachmentItem;
  const AttachementItemWidget({Key? key, required this.attachmentItem})
      : super(key: key);

  @override
  State<AttachementItemWidget> createState() => _AttachementItemWidgetState();
}

class _AttachementItemWidgetState extends State<AttachementItemWidget> {
downloadPDF(String link) async {
      final status = await Permission.storage.request();

    if(status.isGranted){
          final externalDir = await getExternalStorageDirectory();

          await FlutterDownloader.enqueue(
      url: link,
      savedDir: externalDir!.path,
      fileName: externalDir.path.split('/').last,
      showNotification: true,
      openFileFromNotification: true,
    );
    }
 
  }
final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      data[0];
     data[1];
      data[2];
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }
  @override
  void dispose() {
    
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }
   static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppUi.colors.mainColor),
          color: AppUi.colors.whiteColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AppUi.assets.pdfIcon,
            width: 15.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: AppText(
              widget.attachmentItem.title!,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (widget.attachmentItem.download == 1)
                Expanded(
                    child: AppButton(
                  height: 4.h,
                  title: 'download'.tr(),
                  onTap: ()async {
                   
              await downloadPDF('https://emary.azq1.com/Mo5tsr/' +
                        widget.attachmentItem.link!);
           
                  },
                  color: AppUi.colors.mainColor.withOpacity(.7),
                )),
              SizedBox(
                width: 3.w,
              ),
              Expanded(
                  child: AppButton(
                height: 4.h,
                onTap: () {
                  CoursesCubit.get(context).launchInBrowser(Uri.parse(
                      'https://emary.azq1.com/Mo5tsr/' + widget.attachmentItem.link!));
                },
                title: 'show'.tr(),
                color: AppUi.colors.buttonColor.withOpacity(.7),
              ))
            ],
          )
        ],
      ),
    );
  }
}
