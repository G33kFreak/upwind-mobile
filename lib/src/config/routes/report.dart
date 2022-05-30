import 'dart:convert';

import 'package:upwind/src/config/routes/routes.dart';
import 'package:upwind/src/modules/report_view/view/report_view.dart';
import 'package:upwind/src/repositories/relapses_repository/src/models/report.dart';
export 'package:upwind/src/modules/report_view/view/report_view.dart';

class ReportRouteHelper extends RouteHelper<ReportRouteParams> {
  static const path = '/report';
  static const widget = ReportView;

  const ReportRouteHelper() : super(path: path);

  @override
  String generatePath(ReportRouteParams params) {
    final queryParams = <String, String>{};

    queryParams['report'] = jsonEncode(params.report.toJson());

    return Uri(
      path: absolutePath,
      queryParameters: queryParams,
    ).toString();
  }
}

class ReportRouteParams {
  final Report report;

  const ReportRouteParams({required this.report});
}
