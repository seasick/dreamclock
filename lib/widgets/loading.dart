import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({
    super.key,
    required this.futures,
    required this.child,
  });

  // The futures we will wait for
  final List<Future> futures;

  // The child widget we will display if the futures have completed
  final Widget child;

  @override
  State<LoadingWidget> createState() => LoadingWidgetState();
}

class LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    debugPrint("LoadigWidgetState.build");

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<dynamic>(
        future: Future.wait(widget.futures),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            children = [widget.child];
          } else if (snapshot.hasError) {
            debugPrint("LoadingWidgetState.build.error: ${snapshot.error}");
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading...'),
              ),
            ];
          }

          return Center(
            child: children[0],
          );
        },
      ),
    );
  }
}
