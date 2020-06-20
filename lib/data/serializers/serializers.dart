import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dportfolio/data/model/built_github_repos.dart';
import 'package:dportfolio/data/model/built_github_user.dart';
part 'serializers.g.dart';

@SerializersFor(const [BuiltGithubUser, BuiltGithubRepo])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
