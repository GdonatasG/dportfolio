import 'package:built_collection/src/list.dart';
import 'package:chopper/src/response.dart';
import 'package:dportfolio/data/model/built_github_repos.dart';
import 'package:dportfolio/data/model/built_github_user.dart';
import 'package:dportfolio/data/repository/github/github_repository.dart';
import 'package:dportfolio/data/service/github_service.dart';
import 'package:flutter/cupertino.dart';

class GithubRepositoryImpl implements GithubRepository {
  final GithubService githubService;

  GithubRepositoryImpl({@required this.githubService});

  @override
  Future<Response<BuiltGithubUser>> getUserByName(String name) async {
    return await githubService.getGithubUserByName(name);
  }

  @override
  Future<Response<BuiltList<BuiltGithubRepo>>> getUserReposByName(
      String name) async {
    return await githubService.getUserReposByName(name);
  }
}
