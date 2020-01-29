import 'package:flutter/material.dart';

Widget textFormWithIcon(
    {@required TextEditingController controller,
    int maxLength,
    bool showCounter,
    FocusNode focusNode,
    String hintText,
    String title,
    bool isObscure,
    Widget leftIcon,
    Widget rightIcon,
    String textValidator,
    Color enabledBorderColor,
    Color disabledBorderColor,
    Color focusedBorderColor,
    Color labelTextColor,
    Color styleColor,
    Color fillColor = Colors.white,
    double cornerRadius = 30.0,
    double letterSpacing,
    double height,
    EdgeInsets padding,
    TextInputType keyboardType,
    EdgeInsets margin,
    Function(String) onSaved,
    TextStyle style,
    TextStyle hintStyle,
    double textScaleFactor,
    double width,
    bool enabled = true}) {
  final bool _isObscure = isObscure ?? false;
  final bool _showCounter = showCounter ?? false;
  // FocusNode _focusNode = FocusNode();
  final BorderRadius _border = BorderRadius.all(
    Radius.circular(cornerRadius),
  );

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      title != null
          ? Container(
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 10),
              child: Text(title ?? '',
                  textScaleFactor: textScaleFactor ?? 0.9,
                  textAlign: TextAlign.start,
                  style: style),
            )
          : Container(),
      Container(
        height: height ?? 50,
        width: width ?? double.infinity,
        margin: margin ?? const EdgeInsets.symmetric(vertical: 5.0),
        child: TextFormField(
          enabled: enabled,
          focusNode: focusNode,
          decoration: InputDecoration(
            // labelText: hintText,
            contentPadding: padding ?? EdgeInsets.all(10.0),
            filled: true,
            hintText: hintText,
            prefixIcon: leftIcon,
            counterText: _showCounter ? maxLength.toString() : '',
            labelStyle: TextStyle(
              color: labelTextColor ?? Colors.black,
            ),
            hintStyle: hintStyle ??
                TextStyle(
                  letterSpacing: 0,
                ),
            fillColor: fillColor,
            // errorText: textValidator,
            suffixIcon: rightIcon,
            border: OutlineInputBorder(
              borderRadius: _border,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: _border,
              borderSide: BorderSide(
                color: focusedBorderColor ?? Colors.red,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: _border,
              borderSide: BorderSide(
                color: enabledBorderColor ?? Colors.black,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: _border,
              borderSide: BorderSide(
                color: focusedBorderColor ?? Colors.blue,
                width: 1.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: _border,
              borderSide: BorderSide(
                color: disabledBorderColor ?? Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          style: TextStyle(
            color: styleColor ?? Colors.black,
            // fontFamily: 'Source Sans Pro',
            letterSpacing: letterSpacing ?? 1,
          ),
          controller: controller,
          obscureText: _isObscure,
          cursorColor: styleColor ?? Colors.black,
          autovalidate: true,
          autocorrect: false,
          keyboardType: keyboardType ?? TextInputType.text,
          validator: (_) => textValidator,
          maxLength: maxLength ?? null,
          onSaved: onSaved,
        ),
      ),
    ],
  );
}
