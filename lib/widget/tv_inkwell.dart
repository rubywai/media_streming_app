import 'package:flutter/material.dart';

class TvInkwell extends StatefulWidget {
  const TvInkwell({super.key, required this.child, required this.onPressed});
  final Widget child;
  final Function() onPressed;

  @override
  State<TvInkwell> createState() => _TvInkwellState();
}

class _TvInkwellState extends State<TvInkwell> {
  late FocusNode _focusNode;
  bool _isFocus = false;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: _isFocus
              ? Border.all(
                  color: Colors.indigo,
                  width: 3,
                )
              : null,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: InkWell(
          onTap: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}
