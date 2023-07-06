import 'package:flutter/material.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class tipsPage extends StatefulWidget {
  const tipsPage({super.key});

  @override
  _tipsPageState createState() => _tipsPageState();
}

class _tipsPageState extends State<tipsPage> {
  List<CardItem> cardItems = getCardItem();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo.shade200,
        appBar: AppBar(
          title: const Text('Some useful tips!'),
          backgroundColor: Color.fromARGB(255, 142, 36, 236),
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_circle_left_outlined)),
        ),
        body: StackedCardCarousel(
          items: cardItems.map((item) {
            return StackedCardItem(
              title: item.title,
              subtitle: item.subtitle,
              color: item.color,
              imagePath: item.imagePath,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class StackedCardItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final String imagePath;

  StackedCardItem({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.44,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30,),
            Center(
              child: Image.asset(
                imagePath,
                width: 300,
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem {
  final String title;
  final String subtitle;
  final Color color;
  final String imagePath;

  CardItem(
      {required this.title,
      required this.subtitle,
      required this.color,
      required this.imagePath});
}

List<CardItem> getCardItem() {
  List<CardItem> cardItems = [];

  cardItems.add(CardItem(
    title: 'DIET',
    subtitle: 'Boost your diet with fruits, vegetables and whole grain!',
    color: Color.fromARGB(255, 45, 160, 19),
    imagePath: 'images/tips_img/tips1.jpg',
  ));

  cardItems.add(CardItem(
    title: 'RELAXATION',
    subtitle: 'Calm your mind with deep breathing and meditation!',
    color: Color.fromARGB(255, 31, 80, 132),
    imagePath: 'images/tips_img/tips2.png',
  ));

  cardItems.add(CardItem(
    title: 'MATTRESS',
    subtitle: 'Use a supportive and comfortable mattress!',
    color: Color.fromARGB(255, 101, 85, 197),
    imagePath: 'images/tips_img/tips3.jpg',
  ));

  cardItems.add(CardItem(
    title: 'SMOKING',
    subtitle: 'Reduce nicotine intake before bed!',
    color: Color.fromARGB(255, 189, 33, 33),
    imagePath: 'images/tips_img/tips4.jpg',
  ));

  cardItems.add(CardItem(
    title: 'PILLOW',
    subtitle: 'Choose a good pillow!',
    color: Color.fromARGB(255, 29, 40, 64),
    imagePath: 'images/tips_img/tips5.png',
  ));

  cardItems.add(CardItem(
    title: 'BEDROOM',
    subtitle: 'Keep the bedroom dark!',
    color: Color.fromARGB(255, 17, 179, 206),
    imagePath: 'images/tips_img/tips6.png',
  ));

  return cardItems;
}
