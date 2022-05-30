import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../repositories/relapses_repository/src/models/report.dart';

class ReportView extends StatelessWidget implements AutoRouteWrapper {
  const ReportView({Key? key}) : super(key: key);

  static Report getProvidedReport(BuildContext context) {
    final providedData = context.routeData.queryParams.optString('report');
    return Report.fromJson(jsonDecode(providedData!));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}
