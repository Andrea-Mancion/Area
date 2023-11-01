import 'package:flutter/material.dart';
// import 'package:mobile_app/pages/home_page.dart';
import 'package:mobile_app/variable.dart';

class ServicePage extends StatefulWidget {
  final Service service;
  final bool isAction;

  const ServicePage({
    required this.isAction,
    required this.service,
    super.key,
  });

  @override
   State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return  ServicePageBannerAndButton(serviceImage: widget.service.image, serviceTrigger: widget.isAction ? widget.service.allActionDescription : widget.service.allReactionDescription, serviceTriggerBack: widget.isAction ? widget.service.allAction : widget.service.allReaction, key: UniqueKey());
  }
}

class ServicePageBannerAndButton extends StatelessWidget {
  final String serviceImage;
  final List<String> serviceTrigger;
  final List<String> serviceTriggerBack;
  const ServicePageBannerAndButton({
    required this.serviceImage,
    required this.serviceTrigger,
    required this.serviceTriggerBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ServicePageBanner(image: serviceImage, key: UniqueKey()),
            const SizedBox(height: 50),
            ServicePageButton(trigger: serviceTrigger, nbTrigger: serviceTrigger.length, triggerBack: serviceTriggerBack, key: UniqueKey())
          ],
        ),
      )
    );
  }
}

class ServicePageBanner extends StatelessWidget {
  final String image;
  const ServicePageBanner({
    required this.image,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 350,
        height: 250,
        color: const Color.fromRGBO(217, 217, 217, 1),
        child: Center(
          child: Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ServicePageButton extends StatelessWidget {
  final List<String> trigger;
  final List<String> triggerBack;
  final int nbTrigger;
  const ServicePageButton({
    required this.trigger,
    required this.nbTrigger,
    required this.triggerBack,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (
        CustomScrollView(
          slivers: <Widget>[
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(117, 189, 255, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )
                      ),
                    ),
                    onPressed: () {
                      print(triggerBack[index]);
                      // Navigator.push(context,
                      // MaterialPageRoute(builder: (context) => const HomePage()),
                      // );
                    },
                    child: Text(trigger[index])
                  );
                },
                childCount: nbTrigger,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 4,
              ),
            ),
          ],
        )
      ),
    );
  }
}
