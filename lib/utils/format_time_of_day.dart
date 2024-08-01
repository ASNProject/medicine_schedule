// Copyright 2024 ariefsetyonugroho
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return DateFormat('HH:mm').format(dateTime);
}

String parseAndFormatTimeOfDayString(String timeString) {
  final RegExp regex = RegExp(r"TimeOfDay\((\d{1,2}):(\d{2})\)");
  final match = regex.firstMatch(timeString);

  if (match != null) {
    final hour = int.tryParse(match.group(1) ?? '');
    final minute = int.tryParse(match.group(2) ?? '');

    if (hour != null && minute != null) {
      final timeOfDay = TimeOfDay(hour: hour, minute: minute);
      return formatTimeOfDay(timeOfDay);
    }
  }

  return 'Invalid time';
}
