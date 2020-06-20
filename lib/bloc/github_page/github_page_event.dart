abstract class GithubPageEvent {
  const GithubPageEvent();
}

class GetGithubUserByName extends GithubPageEvent {
  final String name;

  GetGithubUserByName(this.name);

  List<Object> get props => [name];
}

class GetGithubUserRepos extends GithubPageEvent {
  final String name;

  GetGithubUserRepos(this.name);

  List<Object> get props => [name];
}
