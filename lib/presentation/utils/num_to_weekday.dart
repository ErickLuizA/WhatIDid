List<String> weekDays = [
  'Monday',
  'Sunday',
  'Thirdsday',
  'Wedsneday',
  'Thursday',
  'Friday',
  'Saturday',
];

String numToWeekday(int num) {
  return weekDays[num - 1];
}
