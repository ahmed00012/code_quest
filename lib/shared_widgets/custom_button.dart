import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatefulWidget {
  final String? title;
  final VoidCallback? onTap;
  final Color ?color;
  final Color ?textColor;
  final double  radius;
  final double fontSize;
  final double? width;
  final double ? height;
  final Color ? borderColor;
  final bool ? isLoad;
  final String ? img;
  final double ? borderWidth;
  final TextStyle ? textStyle;

  const DefaultButton(
      {Key? key,
        required this.fontSize,
        this.title,
        this.onTap,
        this.color,
        this.textColor,
        this.height,
        this.width,
        this.borderColor,
        this.isLoad = false,
        this.img,
        required this.radius, this.borderWidth,this.textStyle})
      : super(key: key);

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton>
    with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return ScaleTransition(
      scale: _tween.animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        ),
      ),
      child: SizedBox(
        height: widget.height
            ?? MediaQuery.of(context).size.height *.06,
        //height:  MediaQuery.of(context).size.height * 01,
        width:widget.width?? MediaQuery.of(context).size.width *.8,
        child: TextButton(
          onPressed: () {
            _controller.forward().then((_) {
              _controller.reverse();
            });
             widget.onTap?.call();
          },

          style: TextButton.styleFrom(
            // foregroundColor: widget.textColor,
            padding: EdgeInsets.zero,
            backgroundColor: widget.color,
            shape: RoundedRectangleBorder(
              side:  BorderSide(color: widget.borderColor ?? Colors.transparent,width: widget.borderWidth??1), //,
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
          child:
          widget.isLoad!?
              const CircularProgressIndicator(color: Colors.black,strokeWidth: 2,):
          widget.img==null? Center(
            child: Text(
              widget.title!,
              style: widget.textStyle?.copyWith(color:widget.textColor,fontSize: widget.fontSize, ) ?? Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: widget.fontSize,
                  color: widget.textColor),
            )

          ) :Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(widget.img!, height: 0.03.sh,color: widget.textColor,),
              SizedBox(width: 2.w,),
              Text(
                widget.title!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: widget.fontSize,
                    color: widget.textColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
