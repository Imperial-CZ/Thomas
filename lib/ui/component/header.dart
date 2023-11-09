import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 3 / 100,
            left: MediaQuery.of(context).size.width * 10 / 100,
          ),
          child: Text(
            "THOMAS",
            style: TextStyle(
              color: Color(0xff1d4b4d),
              fontWeight: FontWeight.bold,
              fontSize: 48,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 18 / 100,
          ),
          child: Text(
            "The history of minorities in America",
            style: TextStyle(
              color: Color(0xff1d4b4d),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 4 / 100,
            left: MediaQuery.of(context).size.width * 2 / 100,
            right: MediaQuery.of(context).size.width * 2 / 100,
          ),
          child: Row(
            children: [
              Image.asset(
                'lib/ui/component/images/logo_without_title.png',
                scale: 2,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 4 / 100,
                  ),
                  child: Text(
                    "Je suis là pour t'accompagner tout au long de ta visite et te fournir des fun-fact, des détails ... bref des informations supplémentaires pour mieux comprendre les oeuvres que tu regardes !",
                    style: TextStyle(
                      color: Color(0xff1d4b4d),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
