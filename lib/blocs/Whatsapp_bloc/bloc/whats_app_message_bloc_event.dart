part of 'whats_app_message_bloc_bloc.dart';

sealed class WhatsAppMessageBlocEvent extends Equatable {
  const WhatsAppMessageBlocEvent();

  @override
  List<Object> get props => [];
}
final class  WhatAppMsgSendingEvent extends WhatsAppMessageBlocEvent {
 final String mobileNo;
  final String message;
  const WhatAppMsgSendingEvent({required this.mobileNo,required this.message});

}