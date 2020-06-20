import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'built_github_user.g.dart';

abstract class BuiltGithubUser
    implements Built<BuiltGithubUser, BuiltGithubUserBuilder> {
  String get login;
  String get avatar_url;
  String get html_url;
  int get public_repos;

  BuiltGithubUser._();

  factory BuiltGithubUser([updates(BuiltGithubUserBuilder b)]) =
      _$BuiltGithubUser;

  static Serializer<BuiltGithubUser> get serializer =>
      _$builtGithubUserSerializer;

  @override
  List<Object> get props => [login, avatar_url, html_url, public_repos];
}
