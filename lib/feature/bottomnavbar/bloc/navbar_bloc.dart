import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockapi/feature/bottomnavbar/bloc/navbarevent.dart';

class NavbarBloc extends Bloc<NavigationEvent, int> {
  NavbarBloc() : super(0) {
    on<NavigationEvent>((event, emit) {
      emit(event.index);
    });
  }
}
