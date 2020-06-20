import 'package:chopper/chopper.dart';
import 'package:dportfolio/data/model/built_github_repos.dart';
import 'package:dportfolio/data/model/built_github_user.dart';
import 'package:built_collection/built_collection.dart';

abstract class GithubRepository {
  Future<Response<BuiltGithubUser>> getUserByName(String name);
  Future<Response<BuiltList<BuiltGithubRepo>>> getUserReposByName(String name);
}
