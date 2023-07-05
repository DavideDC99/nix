import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class Medal extends StatelessWidget {
  //The image of the medal unlocked
  final String imageUnlock;

  //The image of the medal locked
  final String imageLock;

  //When the medal occured
  final bool change;

  //Description when the medal is tapped
  final String description;

  //Constructor
  const Medal(
      {super.key,
      required this.imageUnlock,
      required this.imageLock,
      required this.change,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return change
        ? GestureDetector(
            onTap: () {
              final materialBanner = MaterialBanner(
                elevation: 1000,
                backgroundColor: Colors.transparent,
                forceActionsBelow: true,
                content: AwesomeSnackbarContent(
                  title: 'GOOD JOB!!',
                  message: description,
                  messageFontSize: 20,
                  contentType: ContentType.success,
                  inMaterialBanner: true,
                  color: Colors.green,
                ),
                actions: const [SizedBox.shrink()],
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(materialBanner);
            },
            child: CircleAvatar(
                radius: 50,
                child: Image.asset(imageUnlock, fit: BoxFit.contain)))
        : GestureDetector(
            onTap: () {
              final materialBanner = MaterialBanner(
                elevation: 1000,
                backgroundColor: Colors.transparent,
                forceActionsBelow: true,
                content: AwesomeSnackbarContent(
                  title: "It's a shame",
                  message: description,
                  messageFontSize: 20,
                  contentType: ContentType.failure,
                  inMaterialBanner: true,
                  color: Colors.red,
                ),
                actions: const [SizedBox.shrink()],
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(materialBanner);
            },
            child: CircleAvatar(
                radius: 50,
                child: Image.asset(imageLock, fit: BoxFit.contain)));
  }
}
