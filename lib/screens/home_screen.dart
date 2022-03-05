import 'package:flutter/material.dart';

import '../data/data.dart';
import '../widgets/content_header.dart';
import '../widgets/content_list.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/preview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController scrollController;
  double _scrollOffset = 0.0;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(
        () {
          setState(
            () {
              _scrollOffset = scrollController.offset;
            },
          );
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50),
        child: CustomAppBar(scrollOffset: _scrollOffset),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800,
        onPressed: () => print('Cast'),
        child: const Icon(Icons.cast),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        slivers: [
          const SliverToBoxAdapter(
            child: ContentHeader(
              sintelContent: sintelContent,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: const PageStorageKey('previews'),
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: const PageStorageKey('myList'),
                title: 'My List',
                contentList: myList,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                  key: const PageStorageKey('originals'),
                  title: 'Netflix Originals',
                  contentList: originals,
                  isOriginals: true),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: const PageStorageKey('trending'),
                title: 'Trending',
                contentList: trending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
