import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime? plusMonth(DateTime? input) {
  // add a month to input
  if (input == null) {
    return null;
  }
  final year = input.year;
  final month = input.month + 1;
  final day = math.min(input.day, DateTime(year, month + 1, 0).day);
  final hour = input.hour;
  final minute = input.minute;
  final second = input.second;
  final millisecond = input.millisecond;
  final microsecond = input.microsecond;
  return DateTime(
    year,
    month,
    day,
    hour,
    minute,
    second,
    millisecond,
    microsecond,
  );
}

String? toStr(String? image) {
  return image.toString();
}
