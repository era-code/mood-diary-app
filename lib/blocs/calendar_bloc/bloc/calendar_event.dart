import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class DaySelected extends CalendarEvent {
  final DateTime selectedDay;

  const DaySelected(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}

class ScrollToCurrentMonth extends CalendarEvent {}
