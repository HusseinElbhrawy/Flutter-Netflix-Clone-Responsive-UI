import 'package:flutter/material.dart';

import '../models/content_model.dart';

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
            physics: const BouncingScrollPhysics(),
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
