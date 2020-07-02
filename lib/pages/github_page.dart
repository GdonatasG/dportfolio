import 'dart:async';

import 'package:dportfolio/bloc/github_page/github_page_bloc_export.dart';
import 'package:dportfolio/data/model/built_github_repos.dart';
import 'package:dportfolio/data/model/built_github_user.dart';
import 'package:dportfolio/data/repository/github/github_repository_impl.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/sabt.dart';
import 'package:dportfolio/utils/themes/app_custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:dportfolio/appData/app_data_export.dart';
import 'package:dportfolio/utils/extensions.dart';

class GithubPage extends StatefulWidget {
  GithubPage({Key key}) : super(key: key);

  @override
  _GithubPageState createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GithubPageBloc _githubPageBloc;
  BuiltGithubUser _githubUser;
  BuiltList<BuiltGithubRepo> _githubRepos;
  Completer<void> _refreshCompleter;
  bool isRefreshing = false;
  bool isInitialized = false;

  @override
  void initState() {
    _githubPageBloc = GithubPageBloc(
        githubRepositoryImpl:
            RepositoryProvider.of<GithubRepositoryImpl>(context));
    _githubPageBloc.add(GetGithubUserByName(Constants.GITHUB_NAME));
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: BlocListener<GithubPageBloc, GithubPageState>(
        bloc: _githubPageBloc,
        listener: (_, state) {
          if (state is GithubLoadingError) {
            if (isRefreshing) showErrorSnackbar(_scaffoldKey);
            _reInitRefresher();
          }
        },
        child: BlocBuilder<GithubPageBloc, GithubPageState>(
          bloc: _githubPageBloc,
          builder: (_, state) {
            if (state is GithubDataLoading) {
              if (isRefreshing || isInitialized) {
                return _buildPageLayout(context);
              } else
                return _showLoadingLayout(context);
            } else if (state is GithubLoadingError) {
              if (isRefreshing || isInitialized) {
                isRefreshing = false;
                return _buildPageLayout(context);
              } else
                return _showLoadingErrorLayout(context, state.error);
            } else if (state is GithubUserLoaded) {
              this._githubUser = state.githubUser;
              _githubPageBloc.add(GetGithubUserRepos(_githubUser.login));
              return isRefreshing
                  ? _buildPageLayout(context)
                  : _showLoadingLayout(context);
            }

            /// this state appears if Github User is loaded and his repos is loaded
            else if (state is GithubReposLoaded) {
              // data initialize completed
              // can show user and repos data
              isInitialized = true;
              _reInitRefresher();
              isRefreshing = false;
              this._githubRepos = state.githubRepos;
              return _buildPageLayout(context);
            }
            return Center();
          },
        ),
      ),
    );
  }

  _reInitRefresher() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  Future<void> _onPageRefresh() {
    isRefreshing = true;
    _githubPageBloc.add(GetGithubUserByName(Constants.GITHUB_NAME));

    return _refreshCompleter.future;
  }

  _buildPageLayout(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onPageRefresh,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: false,
                  pinned: true,
                  centerTitle: true,
                  stretch: true,
                  stretchTriggerOffset: 150.0,
                  forceElevated: true,
                  // SABT - the class to show title only if FlexibleSpaceBar is already scrolled
                  title: SABT(
                    child: Text(
                      Constants.TITLE_GITHUB,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CircleAvatar(
                            radius: 60,
                            backgroundColor: Theme.of(context).unselectedWidgetColor,
                            child: CircleAvatar(
                              radius: 58.5,
                              backgroundImage: NetworkImage(_githubUser.avatar_url),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _githubUser.login,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          onPressed: () =>
                              visitPage(_scaffoldKey, _githubUser.html_url),
                          child: Text(
                            context.getString(LocaleKeys.VISIT_PROFILE),
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                _buildGithubReposLayout(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildGithubReposLayout(BuildContext context) => SliverStickyHeader(
        header: AppCustomWidgets.stickyHeaderLayout(
            title: context.getString(LocaleKeys.PUBLIC_REPOS,
                {'repos': _githubUser.public_repos.toString()}),
            context: context),
        sliver: _githubRepos.length > 0
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, i) => Column(
                          children: [
                            _buildRepoItem(_githubRepos[i]),
                            i < _githubRepos.length - 1
                                ? Divider()
                                : Container()
                          ],
                        ),
                    childCount: _githubRepos.length),
              )
            : _buildEmptyReposListMessage(),
      );

  _buildRepoItem(BuiltGithubRepo repo) => ListTile(
        // adding leading into container with height parameter to center vertically
        leading: Container(
          height: double.infinity,
          child: IconTheme(
              data: Theme.of(context).iconTheme,
              child: Icon(FontAwesome.file_zip_o)),
        ),
        title: Text(
          repo.name,
          style: Theme.of(context).textTheme.headline2,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          repo.language,
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Theme.of(context).accentColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(Icons.arrow_forward)),
        onTap: () => visitPage(_scaffoldKey, repo.html_url),
      );

  _buildEmptyReposListMessage() => SliverFillRemaining(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconTheme(
                data: Theme.of(context).iconTheme.copyWith(size: 50),
                child: Icon(FontAwesome.folder_open)),
            Text(
              context.getString(LocaleKeys.EMPTY_LIST),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      );

  _showLoadingLayout(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Constants.TITLE_GITHUB,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: AppCustomWidgets.circularProgressIndicator(
                    Theme.of(context).indicatorColor),
              ),
            ),
          ),
        ),
      );

  _showLoadingErrorLayout(BuildContext context, String error) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Constants.TITLE_GITHUB,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: SafeArea(
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(context.getString(LocaleKeys.DATA_LOADING_ERROR),
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(
                      height: 10,
                    ),
                    // data reload button
                    FlatButton(
                      onPressed: () {
                        _githubPageBloc
                            .add(GetGithubUserByName(Constants.GITHUB_NAME));
                      },
                      child: Text(
                        context.getString(LocaleKeys.TRY_AGAIN_TEXT),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _githubPageBloc.close();
    super.dispose();
  }
}
