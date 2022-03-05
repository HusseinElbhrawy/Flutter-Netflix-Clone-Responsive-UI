import 'package:flutter/material.dart';
import 'package:netflix_clone_responsive_ui/widgets/play_button.dart';
import 'package:netflix_clone_responsive_ui/widgets/vertical_icon_button.dart';

import '../models/content_model.dart';

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
