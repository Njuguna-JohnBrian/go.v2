import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

class FederatedLoginButton extends StatelessWidget {
  final VoidCallback pressAction;
  final String buttonText;
  final Color primaryColor;
  final String imageLink;
  final Color? textColor;
  const FederatedLoginButton({
    Key? key,
    required this.pressAction,
    required this.buttonText,
    required this.primaryColor,
    this.textColor,
    required this.imageLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextButton(
          onPressed: pressAction,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            minimumSize: const Size.fromHeight(60),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: AssetImage(
                  imageLink,
                ),
                height: 20.0,
              ),
              const SizedBox(
                width: 3.0,
              ),
              Text(
                buttonText,
                style: GoTheme.darkTextTheme.headline3?.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
