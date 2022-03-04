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
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          const SliverToBoxAdapter(
            child: const ContentHeader(
              sintelContent: sintelContent,
            ),
          )
        ],
      ),
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
