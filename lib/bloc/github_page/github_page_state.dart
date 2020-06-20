import 'package:dportfolio/data/model/built_github_repos.dart';
import 'package:dportfolio/data/model/built_github_user.dart';
import 'package:built_collection/built_collection.dart';

abstract class GithubPageState {
  const GithubPageState();
}

class GithubDataLoading extends GithubPageState {
  const GithubDataLoading();

  List<Object> get props => [];
}

class GithubUserLoaded extends GithubPageState {
  final BuiltGithubUser githubUser;

  GithubUserLoaded(this.githubUser);

  List<Object> get props => [githubUser];
}

class GithubLoadingError extends GithubPageState {
  final String error;

  GithubLoadingError(this.error);

  List<Object> get props => [error];
}

class GithubReposLoaded extends GithubPageState {
  final BuiltList<BuiltGithubRepo> githubRepos;

  GithubReposLoaded(this.githubRepos);

  List<Object> get props => [githubRepos];
}
