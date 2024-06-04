String getGreetingMessage({required DateTime date}) {
  int hour = date.hour;
  String greeting;
  // Determine the greeting based on the hour
  if (hour < 12) {
    greeting = 'Good Morning!';
  } else if (hour < 18) {
    greeting = 'Good Afternoon!';
  } else {
    greeting = 'Good Evening!';
  }
  return greeting;
}
