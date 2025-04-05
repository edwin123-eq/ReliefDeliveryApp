part of 'whats_app_message_bloc_bloc.dart';

sealed class WhatsAppMessageBlocState extends Equatable {
  const WhatsAppMessageBlocState();

  @override
  List<Object> get props => [];
}

final class WhatsAppMessageBlocInitial extends WhatsAppMessageBlocState {}

final class WhatsAppMessageSuccessState extends WhatsAppMessageBlocState {
  final WhatsappMsgModel whatsAppMsgModel;
  WhatsAppMessageSuccessState({required this.whatsAppMsgModel});
}

final class WhatsAppMessageErrorState extends WhatsAppMessageBlocState {
  final String error;
  WhatsAppMessageErrorState(this.error);
}