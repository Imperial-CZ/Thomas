import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  String text;
  Color buttonColor;
  Function()? onClickFunction;
  BorderRadius? borderRadius;

  NavButton({
    super.key,
    required this.text,
    required this.buttonColor,
    required this.onClickFunction,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Ink(
        color: Color(0xff583f2d),
        padding: EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: borderRadius,
          ),
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.transparent;
                },
              ),
              padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (Set<MaterialState> states) {
                  return EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 1 / 100,
                    bottom: MediaQuery.of(context).size.height * 1 / 100,
                  );
                },
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return Colors.transparent;
                },
              ),
              side: MaterialStateProperty.resolveWith<BorderSide>(
                (Set<MaterialState> states) {
                  return BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  );
                },
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onClickFunction,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
