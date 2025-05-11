import 'package:code_quest/core/theme/color_manager.dart';
import 'package:code_quest/core/theme/text_styles_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
        this.width = 0.17,
        this.label,
        this.number,
        this.maxLines,
        this.description = false,
        this.requiredField = false,
        this.dropDown = false,
        this.enabled = true,
        this.disabledColor,
        this.controller,
        this.validator,
        this.height,
        this.email = false,
        this.password = false,
        this.suffixIcon,
        this.hint, this.prefixIcon})
      : super(key: key);

  final String? label;
  final String? hint;
  final double width;
  final bool? number;
  final bool? email;
  final bool? password;
  final bool? description;
  final bool enabled;
  final Color? disabledColor;
  final bool dropDown;
  final bool requiredField;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double? height;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: widget.height?? 0.11.sh,

      width: widget.width.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                children: [
                  Text(
                   widget.label ?? '',
                    style: getRegularStyle(),),
                  if (widget.requiredField)
                    Text(
                      ' *',
                      style: getRegularStyle(),),
                ],
              ),
            ),
          SizedBox(
            height: 7.h,
          ),
          Container(
            //  height: widget.height?? 0.065.sh,
            child: Center(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: widget.controller,
                cursorColor: ColorManager.primary,
                enabled: widget.enabled,
                style: getBoldStyle(),
                obscureText: widget.password == true,
                keyboardType: widget.number != null
                    ? TextInputType.number
                    : widget.email == true
                    ? TextInputType.emailAddress
                    : TextInputType.text,
                maxLines: widget.description == true ? 6 : 1,
                onChanged: (val) {},
                decoration: InputDecoration(
                    hintText: widget.hint,
                    //    contentPadding: EdgeInsets.zero,
                    //contentPadding: EdgeInsets.only(bottom: widget.height??0.075.sh / 3, left: 4.w,right: 4.w),
                    hintStyle: getHintStyle(),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10),
                    fillColor: ColorManager.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      borderSide:
                      BorderSide(width: 1, color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      borderSide:
                      BorderSide(width: 1, color: ColorManager.divider),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      borderSide: BorderSide(width: 1, color: ColorManager.gray80),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      borderSide: BorderSide(
                          width: 1,
                          color:
                          widget.disabledColor ?? ColorManager.divider),
                    ),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.dropDown
                        ?const Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorManager.lightGrey,
                    )
                        : widget.suffixIcon),

                validator: widget.validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
