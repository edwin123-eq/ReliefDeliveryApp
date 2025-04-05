import 'package:bloc/bloc.dart';

import 'package:deliveryapp/report_module/controller/closing_report_repo.dart';
import 'package:deliveryapp/report_module/model/closing_report_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'closingreport_event.dart';
part 'closingreport_state.dart';

class ClosingreportBloc extends Bloc<ClosingreportEvent, ClosingreportState> {
  ClosingreportBloc() : super(ClosingreportInitial()) {
  
    on<ClosingreportEvent>((event, emit) async {
        emit(ClosingreportLoading());
      try{
       
if(event is GetClosingReport){

  print("aa============>");
         final closingreport = await fetchclosingreport();
      emit(ClosingreportSuccessState(closingReport: closingreport));
      }
      }catch(e){
emit(Closingreporterror(error: e.toString()));
     }
      
     
      
     
    });
  
  }
}
