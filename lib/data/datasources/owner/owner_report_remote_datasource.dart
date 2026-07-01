import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:sewain/core/constants/variables.dart';
import 'package:sewain/data/datasources/auth_local_datasource.dart';
import 'package:sewain/data/models/response/owner/owner_report_response_model.dart';

class OwnerReportRemoteDatasource {
  Future<Either<String, OwnerReportResponseModel>> getReport() async {
    final url = Uri.parse('${Variables.baseUrl}/api/owner/reports');

    final authData = await AuthLocalDatasource().getAuthData();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return Right(OwnerReportResponseModel.fromJson(response.body));
    } else {
      return Left(
        'owner report failed (${response.statusCode}): ${response.body}',
      );
    }
  }
}
