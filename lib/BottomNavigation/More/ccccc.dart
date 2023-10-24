import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekdayDatePicker extends StatefulWidget {
  @override
  _WeekdayDatePickerState createState() => _WeekdayDatePickerState();
}

class _WeekdayDatePickerState extends State<WeekdayDatePicker> {
  DateTime _selectedDate = DateTime.now();
  List<int> _availableWeekdays = [DateTime.monday,];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: _selectedDate,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return _availableWeekdays.contains(day.weekday);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
          ),
          Text('Selected Date: $_selectedDate'),
        ],
      ),
    );
  }
}
