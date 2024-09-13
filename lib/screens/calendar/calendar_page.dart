import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_diary/blocs/calendar_bloc/bloc/calendar_bloc.dart';
import 'package:mood_diary/blocs/calendar_bloc/bloc/calendar_event.dart';
import 'package:mood_diary/screens/calendar/month_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(),
      child: const CalendarPageContent(),
    );
  }
}

class CalendarPageContent extends StatefulWidget {
  const CalendarPageContent({super.key});

  @override
  CalendarPageContentState createState() => CalendarPageContentState();
}

class CalendarPageContentState extends State<CalendarPageContent> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _monthKeys = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentMonth();
    });
  }

  void _scrollToCurrentMonth() {
    final currentMonthIndex =
        context.read<CalendarBloc>().state.currentMonthIndex;
    if (_monthKeys.containsKey(currentMonthIndex)) {
      final context = _monthKeys[currentMonthIndex]!.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(context,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _goToToday() {
    context.read<CalendarBloc>().add(ScrollToCurrentMonth());
    _scrollToCurrentMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFDFC),
      appBar: AppBar(
        surfaceTintColor: const Color(0xffFFFDFC),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffFFFDFC),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: const Color(0xffBCBCBF),
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: _goToToday,
              child: const Text(
                'Сегодня',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    color: Color(0xffBCBCBF)),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const DaysOfWeekHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: 12,
                cacheExtent: MediaQuery.of(context).size.height * 3,
                itemBuilder: (context, index) {
                  DateTime month = DateTime(DateTime.now().year, index + 1, 1);
                  _monthKeys[index] = GlobalKey();
                  return Container(
                    key: _monthKeys[index],
                    child: MonthCalendar(
                      month: month,
                      onDaySelected: (selectedDay) {
                        context
                            .read<CalendarBloc>()
                            .add(DaySelected(selectedDay));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DaysOfWeekHeader extends StatelessWidget {
  const DaysOfWeekHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> daysOfWeek = ['ВС', 'ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: daysOfWeek.map((day) {
        return Text(
          day,
          style: const TextStyle(
              color: Color(0xffBCBCBF), fontFamily: 'Nunito', fontSize: 16),
        );
      }).toList(),
    );
  }
}
