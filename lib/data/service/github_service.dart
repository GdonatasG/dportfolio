import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:dportfolio/data/converters/built_value_converter.dart';
import 'package:dportfolio/data/model/built_github_repos.dart';
import 'package:dportfolio/data/model/built_github_user.dart';
import 'package:built_collection/built_collection.dart';
import 'package:http/io_client.dart' as http;
part 'github_service.chopper.dart';

@ChopperApi(baseUrl: "/users")
abstract class GithubService extends ChopperService {
  @Get(path: "/{name}?client_id=2683db51e60b2522b6f7")
  Future<Response<BuiltGithubUser>> getGithubUserByName(
      @Path("name") String name);

  @Get(path: "/{name}/repos?client_id=2683db51e60b2522b6f7")
  Future<Response<BuiltList<BuiltGithubRepo>>> getUserReposByName(
      @Path("name") String name);

  static GithubService create() {
    final client = ChopperClient(
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 15),
      ),
      baseUrl: 'https://api.github.com',
      services: [
        _$GithubService(),
      ],
      converter: BuiltValueConverter(),
      interceptors: [],
    );
    return _$GithubService(client);
  }
}
