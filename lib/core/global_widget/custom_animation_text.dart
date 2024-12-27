import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimationText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  const CustomAnimationText(
      {super.key, required this.text, required this.textStyle});

  @override
  State<CustomAnimationText> createState() => _CustomAnimationTextState();
}

class _CustomAnimationTextState extends State<CustomAnimationText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _translationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _translationAnimation = Tween<double>(
      begin: 1.0,
      end: -1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Colors.transparent,
                Colors.white,
                Colors.white,
                Colors.transparent,
              ],
              stops: [0.0, 0.1, 0.9, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: ClipRect(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionalTranslation(
                  translation: Offset(_translationAnimation.value, 0),
                  child: SizedBox(
                    width: 32.w,
                    child: Text(
                      widget.text,
                      style: widget.textStyle,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}
