import 'package:flutter/material.dart';

class MovieOverview extends StatefulWidget {
  final String text;
  final int minLength;

  const MovieOverview({super.key, required this.text, required this.minLength});

  @override
  MovieOverviewState createState() => MovieOverviewState();
}

class MovieOverviewState extends State<MovieOverview> {
  String firstHalf = "";
  String secondHalf = "";

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > widget.minLength) {
      firstHalf = widget.text.substring(0, widget.minLength);
      secondHalf = widget.text.substring(widget.minLength, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              maxLines: 2,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  flag ? ("$firstHalf...") : (firstHalf + secondHalf),
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          flag = !flag;
                        });
                      },
                      child: Text(
                        flag ? "show more" : "show less",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
