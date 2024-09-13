import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc()
      : super(CalendarState(
          currentMonthIndex: DateTime.now().month - 1,
        )) {
    on<DaySelected>((event, emit) {
      emit(state.copyWith(selectedDay: event.selectedDay));
    });

    on<ScrollToCurrentMonth>((event, emit) {
      emit(state.copyWith(currentMonthIndex: DateTime.now().month - 1));
    });
  }
}
