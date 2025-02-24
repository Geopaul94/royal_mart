

import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalmart/presentation/bloc/headline/headline_color_event.dart';
import 'package:royalmart/presentation/bloc/headline/headline_color_state.dart';
import 'package:royalmart/utilities/constants/constants.dart';

class ContainerBloc extends Bloc<ContainerEvent, ContainerState> {
  ContainerBloc() : super(ContainerState(2)) {
    on<SelectContainerEvent>((event, emit) {
      emit(ContainerState(event.index));
    });
  }

  Color getBackgroundColor(int index) {
    return state.selectedIndex == index ?white : black;
  }

  Color getTextColor(int index) {
    return state.selectedIndex == index ? black : grey;
  }
}