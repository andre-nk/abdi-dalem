import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:abdi_dalem_alpha/models/models.dart';
import "package:abdi_dalem_alpha/ui/widget/widgets.dart";
import "package:abdi_dalem_alpha/services/services.dart";
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abdi_dalem_alpha/shared/shared.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:abdi_dalem_alpha/ui/widget/DraggableTopBar.dart';
import 'package:vibration/vibration.dart';

part 'login.dart';
part 'homepage.dart';
part 'to-do-landing.dart';
part "to-do-details.dart";
part "iq-landing.dart";
part "pomodoro-timer.dart";
part 'flowtime-timer.dart';
part "eq-landing.dart";
part "bad-habit-landing.dart";