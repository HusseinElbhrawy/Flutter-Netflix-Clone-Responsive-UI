import 'package:flutter/material.dart';

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
