import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mood_diary/blocs/calendar_bloc/bloc/calendar_bloc.dart';
import 'package:mood_diary/blocs/calendar_bloc/bloc/calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthCalendar extends StatelessWidget {
  final DateTime month;
  final void Function(DateTime) onDaySelected;

  const MonthCalendar({
    super.key,
    required this.month,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    String year = DateFormat.y('ru').format(month);
    String monthName =
        toBeginningOfSentenceCase(DateFormat.MMMM('ru').format(month))!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          year,
          style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Nunito-bold',
              color: Color(0xffbcbcbf)),
        ),
        Text(
          monthName,
          style: const TextStyle(fontSize: 24, fontFamily: 'Nunito-bold'),
        ),
        BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            return TableCalendar(
              daysOfWeekVisible: false,
              locale: 'ru_RU',
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: month,
              headerVisible: false,
              pageJumpingEnabled: false,
              availableGestures: AvailableGestures.none,
              pageAnimationEnabled: false,
              selectedDayPredicate: (day) => isSameDay(state.selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                onDaySelected(selectedDay);
              },
              calendarStyle: CalendarStyle(
                weekendTextStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    color: Color(0xff4C4C69)),
                selectedTextStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    color: Color(0xff4C4C69)),
                outsideDaysVisible: false,
                defaultTextStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Nunito',
                    color: Color(0xff4C4C69)),
                todayDecoration: const BoxDecoration(
                    color: Colors.orange, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange.withOpacity(0.3)),
                markersMaxCount: 1,
                markerDecoration: const BoxDecoration(
                    color: Colors.orange, shape: BoxShape.circle),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (isSameDay(state.selectedDay, date)) {
                    return Positioned(
                      bottom: 10,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.orange),
                      ),
                    );
                  }
                  return null;
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
