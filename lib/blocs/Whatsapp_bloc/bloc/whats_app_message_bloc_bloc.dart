import 'package:bloc/bloc.dart';
import 'package:deliveryapp/models/whatApp_Msg_Model.dart';
import 'package:deliveryapp/service/whatapp_service.dart';
import 'package:equatable/equatable.dart';

part 'whats_app_message_bloc_event.dart';
part 'whats_app_message_bloc_state.dart';

class WhatsAppMessageBlocBloc
    extends Bloc<WhatsAppMessageBlocEvent, WhatsAppMessageBlocState> {
  WhatsAppMessageBlocBloc() : super(WhatsAppMessageBlocInitial()) {
    on<WhatsAppMessageBlocEvent>((event, emit) async {
      try{
        if (event is WhatAppMsgSendingEvent) {
        final response = await WhatsappMsgRepo(
            mobileNo: event.mobileNo, message: event.message);

        emit(WhatsAppMessageSuccessState(
            whatsAppMsgModel: response));
      }
      }
      catch(e){
        emit(WhatsAppMessageErrorState(e.toString()));
      }
   
    });
  }
}
