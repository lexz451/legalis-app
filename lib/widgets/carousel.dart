import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class Carousel extends StatefulWidget {
  final List<Widget> items;

  const Carousel(this.items);

  @override
  State<StatefulWidget> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.items,
      options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          viewportFraction: 1),
    );
  }
}
