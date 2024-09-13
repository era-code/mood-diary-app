import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../calendar/calendar_page.dart'; 

class DateTimeDisplay extends StatefulWidget {
  const DateTimeDisplay({Key? key}) : super(key: key);

  @override
  State<DateTimeDisplay> createState() => _DateTimeDisplayState();
}

class _DateTimeDisplayState extends State<DateTimeDisplay> {
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('d MMMM HH:mm', 'ru').format(DateTime.now());

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CalendarPage()),
        );
      },
      child: SafeArea(
        child: Container(
          height: 30,
          color: const Color(0xfffdfc),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Nunito-bold',
                          color: Color(0xffBCBCBF)),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.calendar_month,
                      size: 26,
                      color: Color(0xffBCBCBF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
