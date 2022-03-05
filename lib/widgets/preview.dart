import 'package:flutter/material.dart';

import '../models/content_model.dart';

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
