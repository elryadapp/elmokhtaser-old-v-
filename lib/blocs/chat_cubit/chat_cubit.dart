import 'package:bloc/bloc.dart';
import 'package:elmoktaser_elshamel/models/message_model.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context)=>ChatCubit();
  List<MessageModel>messages=[
    MessageModel(mess: 'لدينا اجتماع غدا الساعة 6 مساء', isSend: true),
      MessageModel(mess: 'حسنا سأكون هناك بالمعاد', isSend: false),
       MessageModel(mess: 'هل لديك اى استفسار بخصوص الدرس', isSend: true),
      MessageModel(mess: 'شكرا لك لا يوجد اى استفسار', isSend: false)
  ];
}
