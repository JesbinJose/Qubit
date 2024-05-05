String formatDateTime(DateTime dateTime) {
  final now = DateTime.now().day;
  final difference = now - dateTime.day;

  if (difference== 0) {
    return 'Today';
  } else if (difference== 1) {
    return 'Yesterday';
  } else if (difference < 7 && dateTime.weekday < DateTime.now().weekday) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      default:
        return 'Sunday';
    }
  } else if (dateTime.year == DateTime.now().year && dateTime.month == DateTime.now().month) {
    return '${dateTime.day} ${_getMonthName(dateTime.month)}';
  } else {
    return '${dateTime.day} ${_getMonthName(dateTime.month)} ${dateTime.year}';
  }
}

String _getMonthName(int month) {
  switch (month) {
    case DateTime.january:
      return 'January';
    case DateTime.february:
      return 'February';
    case DateTime.march:
      return 'March';
    case DateTime.april:
      return 'April';
    case DateTime.may:
      return 'May';
    case DateTime.june:
      return 'June';
    case DateTime.july:
      return 'July';
    case DateTime.august:
      return 'August';
    case DateTime.september:
      return 'September';
    case DateTime.october:
      return 'October';
    case DateTime.november:
      return 'November';
    default:
      return 'December';
  }
}
