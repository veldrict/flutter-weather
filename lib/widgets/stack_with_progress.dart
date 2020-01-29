import 'package:flutter/material.dart';
import 'package:wheater_app/widgets/widgets.dart';

class StackWithProgress extends StatelessWidget {
  const StackWithProgress(
      {Key key, @required List<Widget> children, bool isLoading, bool isError})
      : assert(children != null),
        _children = children,
        _isLoading = isLoading ?? false,
        _isError = isError ?? false,
        super(key: key);

  final List<Widget> _children;
  final bool _isLoading;
  final bool _isError;

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      _children.add(progressBar());
    }
    if (_isError) {
      // _children.add(WidgetError(
      //   visible: _isError,
      // ));
    }
    return Stack(
      children: _children,
    );
  }
}
