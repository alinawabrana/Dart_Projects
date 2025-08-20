// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$TodosListService extends TodosListService {
  _$TodosListService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = TodosListService;

  @override
  Future<Response<dynamic>> getTodos() {
    final Uri $url = Uri.parse('/todos');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$RestApiService extends RestApiService {
  _$RestApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = RestApiService;

  @override
  Future<Response<dynamic>> getAllObjects() {
    final Uri $url = Uri.parse('/objects');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllObjectsById(List<int> ids) {
    final Uri $url = Uri.parse('/objects');
    final Map<String, dynamic> $params = <String, dynamic>{'id': ids};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSingleObject() {
    final Uri $url = Uri.parse('/objects/7');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
