class DateUtil {
  
  static int getYear(String dateString) {
    String  date = dateString.split(" ")[0];
    String  year = date.split("/")[0];
    // Extract the year component
    return int.parse(year);
  }

  static int getMonth(String dateString) {
    String  date = dateString.split(" ")[0];
    String  month = date.split("/")[1];
    // Extract the month component
    return  int.parse(month);
  }

  static int getDay(String dateString) {
    String  date = dateString.split(" ")[0];
    String  day = date.split("/")[2];
    // Extract the day component
    return  int.parse(day);
  }
  static String getTime(String dateString) {
    String  date = dateString.split(" ")[1];
    final time = date.split(':');
    final hour = time[0];
    final min = time[1];
    return ' $hour:$min ';
  }

}

