import 'package:flutter/material.dart';
// import 'package:mobile_app/pages/home_page.dart';
// import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/service_page.dart';
// import 'package:mobile_app/pages/action_pages/spotify/spotify_action_page.dart';
// import 'package:mobile_app/spotify_oauth2.dart';
import 'package:mobile_app/all_oauth2.dart';
import 'package:mobile_app/variable.dart';

const double verticaleSpace = 50;
const double horizontalSpace = 30;

class AllServicePage extends StatefulWidget {
  const AllServicePage({
    super.key,
    required this.isAction,
  });
  final bool isAction;
  @override
  State<AllServicePage> createState() => AllServicePageState();
}

class AllServicePageState extends State<AllServicePage> {

  final caseColor = const Color.fromRGBO(217, 217, 217, 1);
  @override
  Widget build(BuildContext context) {
    print("isAction: ${widget.isAction}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("If This Page"),
      ),
      body:  Column(
          children: [
            const SizedBox(height: verticaleSpace),
            DoubleBouttonService(
              key: UniqueKey(),
              service1: spotify,
              service2: discord,
              isAction: widget.isAction,
            ),
            const SizedBox(height: verticaleSpace),
            DoubleBouttonService(
              key: UniqueKey(),
              service1: github,
              service2: dropbox,
              isAction: widget.isAction,
            ),
            const SizedBox(height: verticaleSpace),
            DoubleBouttonService(
              key: UniqueKey(),
              service1: yahoo,
              service2: twitch,
              isAction: widget.isAction,
            ),
          ]
        ),
    );
  }
}

class DoubleBouttonService extends StatelessWidget {
  final Service service1;
  final Service service2;
  final bool isAction;
  const DoubleBouttonService({
    required this.service1,
    required this.service2,
    required this.isAction,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: horizontalSpace),
        LogoButton(
          key: UniqueKey(),
          service: service1,
          isAction: isAction,
        ),
        const SizedBox(width: horizontalSpace),
        LogoButton(
          key: UniqueKey(),
          service: service2,
          isAction: isAction,
        ),
      ],
    );
  }
}

class LogoButton extends StatefulWidget {
  final Service service;
  final bool isAction;
  const LogoButton({required Key key, required this.isAction, required this.service}) : super(key: key);

  @override
  State<LogoButton> createState() => _LogoButtonState();
}

class _LogoButtonState extends State<LogoButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        performOAuth2(widget.service, widget.isAction);
        Navigator.push(context,MaterialPageRoute(builder: (context) => ServicePage(service: widget.service, isAction: widget.isAction)));
      },
      child: Image.asset(
        widget.service.image,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
