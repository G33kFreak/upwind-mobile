import 'package:flutter/material.dart';
import 'package:upwind/src/config/colors.dart';

void showGlobalLoader(context) => showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      barrierColor: whiteSnow.withOpacity(0.65),
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
