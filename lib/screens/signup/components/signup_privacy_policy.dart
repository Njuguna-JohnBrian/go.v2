import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

import 'package:go/screens/signup/signup_barrel.dart' show SignUpStrings;

class SignUpPrivacyPolicy extends StatelessWidget {
  const SignUpPrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(SignUpStrings.tAndC),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(SignUpStrings.privacyResult),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                builder: (context) {
                  return Container(
                    height: size.height * 0.5,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                color: GoTheme.mainColor,
                              ),
                              Text("Lorem ipsum........."),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                color: GoTheme.mainColor,
                              ),
                              Text("Lorem ipsum........."),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                color: GoTheme.mainColor,
                              ),
                              Text("Lorem ipsum........."),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                color: GoTheme.mainColor,
                              ),
                              Text("Lorem ipsum........."),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                color: GoTheme.mainColor,
                              ),
                              Text("Lorem ipsum........."),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                color: GoTheme.mainColor,
                              ),
                              Text("Lorem ipsum........."),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                color: GoTheme.mainColor,
                              ),
                              Text("Lorem ipsum........."),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              child: Text(
                SignUpStrings.privacy,
                style: GoTheme.lightTextTheme.headline3?.copyWith(
                  color: Colors.blueAccent,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
