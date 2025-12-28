import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmd/components/extensions/local_context_x.dart';
import 'package:pmd/components/utils/debounce.dart';
import 'package:pmd/models/card_data.dart';
import 'package:pmd/presentation/bloc/bloc.dart';
import 'package:pmd/presentation/bloc/events.dart';
import 'package:pmd/presentation/bloc/state.dart';
import 'package:pmd/presentation/common/svg_objects.dart';
import 'package:pmd/presentation/details_page/details_page.dart';
import 'package:pmd/presentation/home_page/like_bloc/like_bloc.dart';
import 'package:pmd/presentation/home_page/like_bloc/like_event.dart';
import 'package:pmd/presentation/home_page/like_bloc/like_state.dart';
import 'package:pmd/presentation/home_page/locale_bloc/locale_bloc.dart';
import 'package:pmd/presentation/home_page/locale_bloc/locale_events.dart';
import 'package:pmd/presentation/home_page/locale_bloc/locale_state.dart';

part 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const HomeLoadDataEvent());
      context.read<LikeBloc>().add(const LoadLikesEvent());
    });

    _scrollController.addListener(_onNextPageListener);
    SvgObjects.init();

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onNextPageListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
      final bloc = context.read<HomeBloc>();
      if (!bloc.state.isPaginationLoading) {
        bloc.add(
            HomeLoadDataEvent(search: _searchController.text, nextPage: bloc.state.data?.nextPage));
      }
    }
  }

  Future<void> _onRefresh() {
    context.read<HomeBloc>().add(HomeLoadDataEvent(search: _searchController.text));
    return Future.value(null);
  }

  void _onSearchInputChange(search) {
    Debounce.run(action: () => context.read<HomeBloc>().add(HomeLoadDataEvent(search: search)));
  }

  void _onLike(String? id, String text, bool isLiked) {
    if (id != null) {
      context.read<LikeBloc>().add(ChangeLikeEvent(id));
      _showSnackBar(context, id, text, isLiked);
    }
  }

  void _showSnackBar(BuildContext context, String? id, String text, bool isLiked) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black54,
      ));
    });
  }

  void _navigateToDetailsPage(BuildContext context, CardData data) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data: data)),
    );
  }

  void _handleLocaleButtonTap() {
    context.read<LocaleBloc>().add(const ChangeLocaleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30, left: 30, top: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: CupertinoSearchTextField(
                      controller: _searchController,
                      placeholder: context.locale.searchInputPlaceholder,
                      onChanged: _onSearchInputChange,
                    )),
                GestureDetector(
                  onTap: _handleLocaleButtonTap,
                  child: SizedBox.square(
                    dimension: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: BlocBuilder<LocaleBloc, LocaleState>(
                        builder: (context, state) {
                          return state.currentLocale.languageCode == "ru"
                              ? const SvgRu()
                              : const SvgUk();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.error != null
                ? Text(
                    state.error ?? "",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.red),
                  )
                : state.isLoading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                      )
                    : BlocBuilder<LikeBloc, LikeState>(
                        builder: (context, likeState) {
                          return Expanded(
                            child: RefreshIndicator(
                              onRefresh: _onRefresh,
                              child: ListView.separated(
                                controller: _scrollController,
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                separatorBuilder: (context, index) => const SizedBox(height: 20),
                                itemCount: state.data?.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final data = state.data?.data?[index];

                                  return data == null
                                      ? const SizedBox.shrink()
                                      : Card.fromData(
                                          data,
                                          isLiked: likeState.likedIds?.contains(data.id) == true,
                                          onLike: (String? id, String text, bool isLiked) =>
                                              _onLike(id, text, isLiked),
                                          onTap: () => _navigateToDetailsPage(context, data),
                                        );
                                },
                              ),
                            ),
                          );
                        },
                      ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.isPaginationLoading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
