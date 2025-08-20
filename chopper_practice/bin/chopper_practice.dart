import 'package:chopper/chopper.dart';
import 'package:chopper_practice/api/practice_api.dart';

void main(List<String> arguments) async {
  final chopper = ChopperClient(
    baseUrl: Uri.parse("https://api.restful-api.dev"),
    services: [RestApiService.create()],
  );

  /// Get a reference to the client-bound service instance...
  final restService = chopper.getService<RestApiService>();

  /// ... or create a new instance by explicitly binding it to a client.
  /// This is functionally equivalent, but it’s useful if you:
  // Didn’t include the service in the services list of the client.
  // Want to create multiple instances with different configurations.
  final anotherTodosService = RestApiService.create(chopper);

  /// Making a request is as easy as calling a function of the service.
  // final response1 = await restService.getAllObjects();
  final (response1, response2, response3) = await Future.wait([
    restService.getAllObjects(),
    restService.getAllObjectsById([3, 5, 7, 9]),
    restService.getSingleObject(),
  ]).then((list) => (list[0], list[1], list[2]));

  if (response1.isSuccessful) {
    // Successful request
    final body = response1.body;
    print(body);
  } else {
    // Error code received from server
    final code = response1.statusCode;
    final error = response1.error;

    print('Status code: $code \nError: $error');
  }

  // final response2 = await restService.getAllObjectsById([3, 5, 10]);

  if (response2.isSuccessful) {
    // Successful request
    final body = response2.body;
    print(body);
  } else {
    // Error code received from server
    final code = response2.statusCode;
    final error = response2.error;

    print('Status code: $code \nError: $error');
  }

  // final response3 = await restService.getSingleObject();

  if (response3.isSuccessful) {
    // Successful request
    final body = response3.body;
    print(body);
  } else {
    // Error code received from server
    final code = response3.statusCode;
    final error = response3.error;

    print('Status code: $code \nError: $error');
  }
}
