import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
void toast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
  );
}

String formatDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  return "$twoDigitMinutes:$twoDigitSeconds";
}

// String mapFailureToMessage(Failure failure) {
//   switch (failure.runtimeType) {
//     case ServerFailure:
//       return failure.message;
//     case CacheFailure:
//       return failure.message;
//     case UnauthFailure:
//       return failure.message;
//     case NetworkFailure:
//       return failure.message;
//     default:
//       return "Unexpected Error , Please try again later .";
//   }
// }

// void signout(context) {
//   SecureStorage secureStorage = getIt<SecureStorage>();
//   secureStorage.clearAll();
//   context.push("/login");
// }

Future<DateTime?> getDate(context) async {
  DateTime? dateTime = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2040),
  );

  return dateTime;
}

Future<TimeOfDay?> getTime(context) async {
  TimeOfDay? timeOfDay = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return timeOfDay;
}

String convertDate(String dateString) {
  final date = DateTime.parse(dateString);
  return DateFormat('EEEE, MMMM d, yyyy \'at\' h:mm a').format(date);
}

String convertDateToAgo(String dateString) {
  final date = DateTime.parse(dateString);
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays >= 1) {
    if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays ~/ 7} weeks ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays ~/ 30} months ago';
    } else {
      return '${difference.inDays ~/ 365} years ago';
    }
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'just now';
  }
}
