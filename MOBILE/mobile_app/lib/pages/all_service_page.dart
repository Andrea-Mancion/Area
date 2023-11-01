import 'package:flutter/material.dart';
// import 'package:mobile_app/pages/home_page.dart';
// import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/pages/service_page.dart';
// import 'package:mobile_app/pages/action_pages/spotify/spotify_action_page.dart';
// import 'package:mobile_app/spotify_oauth2.dart';
// import 'package:mobile_app/pages/create_task_page.dart';
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
              image1: AllVariables.imageSpotify,
              nextPage1: ServicePage(isAction: widget.isAction, service: spotify),
              image2: AllVariables.imageDiscord,
              nextPage2: ServicePage(isAction: widget.isAction, service: discord),
            ),
            const SizedBox(height: verticaleSpace),
            DoubleBouttonService(
              key: UniqueKey(),
              image1: AllVariables.imageDeezer,
              nextPage1: ServicePage(isAction: widget.isAction, service: deezer),
              image2: AllVariables.imageGithub,
              nextPage2: ServicePage(isAction: widget.isAction, service: github),
            ),
            const SizedBox(height: verticaleSpace),
            DoubleBouttonService(
              key: UniqueKey(),
              image1: AllVariables.imageYahoo,
              nextPage1: ServicePage(isAction: widget.isAction, service: yahoo),
              image2: AllVariables.imageTwitch,
              nextPage2: ServicePage(isAction: widget.isAction, service: twitch),
            ),
          ]
        ),
    );
  }
}

class DoubleBouttonService extends StatelessWidget {
  final Widget nextPage1;
  final Widget nextPage2;
  final String image1;
  final String image2;
  const DoubleBouttonService({
    required this.image1,
    required this.nextPage1,
    required this.image2,
    required this.nextPage2,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: horizontalSpace),
        LogoButton(
          key: UniqueKey(),
          image: image1,
          nextPage: nextPage1,
        ),
        const SizedBox(width: horizontalSpace),
        LogoButton(
          key: UniqueKey(),
          image: image2,
          nextPage: nextPage2,
        ),
      ],
    );
  }
}

class LogoButton extends StatefulWidget {
  final String image;
  final Widget nextPage;

  const LogoButton({required Key key, required this.image, required this.nextPage}) : super(key: key);

  @override
  State<LogoButton> createState() => _LogoButtonState();
}

class _LogoButtonState extends State<LogoButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.nextPage),
      ),
      child: Image.asset(
        widget.image,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
