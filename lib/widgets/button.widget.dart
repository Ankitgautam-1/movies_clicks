import 'package:flutter/material.dart';
import 'package:movies_clicks/common_export.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.index, required this.onPressed});
  final int index;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ColorConstants().primaryDarkColor,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            Icons.arrow_circle_right_rounded,
            size: index == 2 ? 20 : 0,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Get Started",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          )
        ]),
      ),
    );
  }
}
