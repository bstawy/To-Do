class ExtractDate {

  static DateTime extractDate(DateTime date) {
    var newDate =  DateTime(
      date.year,
      date.month,
      date.day,
    );
    print("newDate = $newDate");
    return newDate;
  }
}
