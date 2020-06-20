// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'built_github_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltGithubUser> _$builtGithubUserSerializer =
    new _$BuiltGithubUserSerializer();

class _$BuiltGithubUserSerializer
    implements StructuredSerializer<BuiltGithubUser> {
  @override
  final Iterable<Type> types = const [BuiltGithubUser, _$BuiltGithubUser];
  @override
  final String wireName = 'BuiltGithubUser';

  @override
  Iterable<Object> serialize(Serializers serializers, BuiltGithubUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'login',
      serializers.serialize(object.login,
          specifiedType: const FullType(String)),
      'avatar_url',
      serializers.serialize(object.avatar_url,
          specifiedType: const FullType(String)),
      'html_url',
      serializers.serialize(object.html_url,
          specifiedType: const FullType(String)),
      'public_repos',
      serializers.serialize(object.public_repos,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  BuiltGithubUser deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltGithubUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'login':
          result.login = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'avatar_url':
          result.avatar_url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'html_url':
          result.html_url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'public_repos':
          result.public_repos = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltGithubUser extends BuiltGithubUser {
  @override
  final String login;
  @override
  final String avatar_url;
  @override
  final String html_url;
  @override
  final int public_repos;

  factory _$BuiltGithubUser([void Function(BuiltGithubUserBuilder) updates]) =>
      (new BuiltGithubUserBuilder()..update(updates)).build();

  _$BuiltGithubUser._(
      {this.login, this.avatar_url, this.html_url, this.public_repos})
      : super._() {
    if (login == null) {
      throw new BuiltValueNullFieldError('BuiltGithubUser', 'login');
    }
    if (avatar_url == null) {
      throw new BuiltValueNullFieldError('BuiltGithubUser', 'avatar_url');
    }
    if (html_url == null) {
      throw new BuiltValueNullFieldError('BuiltGithubUser', 'html_url');
    }
    if (public_repos == null) {
      throw new BuiltValueNullFieldError('BuiltGithubUser', 'public_repos');
    }
  }

  @override
  BuiltGithubUser rebuild(void Function(BuiltGithubUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltGithubUserBuilder toBuilder() =>
      new BuiltGithubUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltGithubUser &&
        login == other.login &&
        avatar_url == other.avatar_url &&
        html_url == other.html_url &&
        public_repos == other.public_repos;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, login.hashCode), avatar_url.hashCode),
            html_url.hashCode),
        public_repos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltGithubUser')
          ..add('login', login)
          ..add('avatar_url', avatar_url)
          ..add('html_url', html_url)
          ..add('public_repos', public_repos))
        .toString();
  }
}

class BuiltGithubUserBuilder
    implements Builder<BuiltGithubUser, BuiltGithubUserBuilder> {
  _$BuiltGithubUser _$v;

  String _login;
  String get login => _$this._login;
  set login(String login) => _$this._login = login;

  String _avatar_url;
  String get avatar_url => _$this._avatar_url;
  set avatar_url(String avatar_url) => _$this._avatar_url = avatar_url;

  String _html_url;
  String get html_url => _$this._html_url;
  set html_url(String html_url) => _$this._html_url = html_url;

  int _public_repos;
  int get public_repos => _$this._public_repos;
  set public_repos(int public_repos) => _$this._public_repos = public_repos;

  BuiltGithubUserBuilder();

  BuiltGithubUserBuilder get _$this {
    if (_$v != null) {
      _login = _$v.login;
      _avatar_url = _$v.avatar_url;
      _html_url = _$v.html_url;
      _public_repos = _$v.public_repos;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltGithubUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltGithubUser;
  }

  @override
  void update(void Function(BuiltGithubUserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltGithubUser build() {
    final _$result = _$v ??
        new _$BuiltGithubUser._(
            login: login,
            avatar_url: avatar_url,
            html_url: html_url,
            public_repos: public_repos);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
