import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
part 'built_github_repos.g.dart';

abstract class BuiltGithubRepo
    implements Built<BuiltGithubRepo, BuiltGithubRepoBuilder> {
  String get name;
  String get html_url;
  String get language;

  BuiltGithubRepo._();

  factory BuiltGithubRepo([updates(BuiltGithubRepoBuilder b)]) =
      _$BuiltGithubRepo;

  static Serializer<BuiltGithubRepo> get serializer =>
      _$builtGithubRepoSerializer;

  @override
  List<Object> get props => [name, html_url, language];
}
