import 'package:equatable/equatable.dart';

class CalendarState extends Equatable {
  final DateTime? selectedDay;
  final int currentMonthIndex;

  const CalendarState({
    this.selectedDay,
    required this.currentMonthIndex,
  });

  CalendarState copyWith({
    DateTime? selectedDay,
    int? currentMonthIndex,
  }) {
    return CalendarState(
      selectedDay: selectedDay ?? this.selectedDay,
      currentMonthIndex: currentMonthIndex ?? this.currentMonthIndex,
    );
  }

  @override
  List<Object?> get props => [selectedDay, currentMonthIndex];
}
