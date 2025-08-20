import 'package:chopper/chopper.dart';

part 'practice_api.chopper.dart';

@ChopperApi(baseUrl: "/todos") // this base url will be the endpoint of the url
abstract class TodosListService extends ChopperService {
  static TodosListService create([ChopperClient? client]) =>
      _$TodosListService(client);

  @GET()
  Future<Response> getTodos();
}

@ChopperApi(baseUrl: "/objects")
abstract class RestApiService extends ChopperService {
  static RestApiService create([ChopperClient? client]) =>
      _$RestApiService(client);

  @GET()
  Future<Response> getAllObjects();

  // This will call the following url
  // https://api.restful-api.dev/objects?id=ids[0]&id=ids[1]&id=ids[2]
  @GET()
  Future<Response> getAllObjectsById(@Query('id') List<int> ids);

  @GET(path: '/7')
  Future<Response> getSingleObject();
}
