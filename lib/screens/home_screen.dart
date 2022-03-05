import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/content_model.dart';
import '../widgets/custom_appbar.dart';

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
                title: 'Previews',
                contentList: previews,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                title: 'My List',
                contentList: myList,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                  title: 'Netflix Originals',
                  contentList: originals,
                  isOriginals: true),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
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

class ContentList extends StatelessWidget {
  const ContentList(
      {Key? key,
      required this.contentList,
      required this.title,
      this.isOriginals = false})
      : super(key: key);
  final String title;
  final bool isOriginals;
  final List<Content> contentList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        SizedBox(
          height: isOriginals ? 500 : 220,
          child: ListView.builder(
            itemCount: contentList.length,
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => print(contentList[index].titleImageUrl),
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  height: isOriginals ? 400 : 200,
                  width: isOriginals ? 200 : 130,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(contentList[index].imageUrl),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Previews extends StatelessWidget {
  const Previews({
    Key? key,
    required this.title,
    required this.contentList,
  }) : super(key: key);
  final String title;
  final List<Content> contentList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              contentList.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(contentList[index].imageUrl),
                        ),
                        border: Border.all(
                          width: 3.5,
                          color: contentList[index].color as Color,
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Colors.black87,
                            Colors.black54,
                            Colors.transparent,
                          ],
                          stops: [
                            0,
                            0.25,
                            1,
                          ],
                          begin: AlignmentDirectional.bottomCenter,
                          end: AlignmentDirectional.topCenter,
                        ),
                        border: Border.all(
                          width: 3.5,
                          color: contentList[index].color as Color,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 0.0,
                      end: 0.0,
                      bottom: 0.0,
                      child: SizedBox(
                        height: 60.0,
                        child: Image.asset(
                            contentList[index].titleImageUrl.toString()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContentHeader extends StatelessWidget {
  const ContentHeader({
    Key? key,
    required this.sintelContent,
  }) : super(key: key);
  final Content sintelContent;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                sintelContent.imageUrl,
              ),
            ),
          ),
        ),
        Container(
          height: 500,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              begin: AlignmentDirectional.bottomEnd,
              end: AlignmentDirectional.topEnd,
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(
              sintelContent.titleImageUrl.toString(),
            ),
          ),
        ),
        PositionedDirectional(
          end: 0.0,
          start: 0.0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(title: 'List', icon: Icons.add, onTap: () {}),
              const PlayButton(),
              VerticalIconButton(title: 'Info', icon: Icons.info, onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class VerticalIconButton extends StatelessWidget {
  const VerticalIconButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            // size: 50,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
      onPressed: () {},
      label: const Text('Play'),
      icon: const Icon(Icons.play_arrow),
    );
  }
}
