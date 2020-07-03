import 'package:dportfolio/data/repository/github/github_repository_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:supercharged/supercharged.dart';

import 'github_page_bloc_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GithubPageBloc extends Bloc<GithubPageEvent, GithubPageState> {
  final GithubRepositoryImpl githubRepositoryImpl;

  GithubPageBloc({@required this.githubRepositoryImpl});

  @override
  GithubPageState get initialState => GithubDataLoading();

  @override
  Stream<GithubPageState> mapEventToState(GithubPageEvent event) async* {
    if (event is GetGithubUserByName) {
      yield GithubDataLoading();
      try {
        final githubUser = await githubRepositoryImpl.getUserByName(event.name);
        if (githubUser.body != null)
          yield GithubUserLoaded(githubUser.body);
        else
          throw Error();
      } catch (_) {
        yield GithubLoadingError("Can't get user!");
      }
    } else if (event is GetGithubUserRepos) {
      yield GithubDataLoading();
      try {
        final githubRepos =
            await githubRepositoryImpl.getUserReposByName(event.name);
        if (githubRepos.body != null)
          yield GithubReposLoaded(githubRepos.body);
        else
          throw Error();
      } catch (_) {
        yield GithubLoadingError("Can't get repos!");
      }
    }
  }
}
