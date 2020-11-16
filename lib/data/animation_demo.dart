import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimationState();
  }
}

class AnimationState extends State<AnimationDemo>
    with TickerProviderStateMixin {
  Animation _containerRadiusAnimation, _containerSizeAnimation;
  AnimationController _containerAnimationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _containerAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));

    _containerRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(100.0),
            end: BorderRadius.circular(0.0))
        .animate(CurvedAnimation(
            curve: Curves.ease, parent: _containerAnimationController));

    _containerSizeAnimation = Tween(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(
            curve: Curves.ease, parent: _containerAnimationController));
  }

  @override
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Screen'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _containerAnimationController,
          builder: (context, index) {
            return GestureDetector(
              onTap: () {
                _containerAnimationController.forward();
              },
              child: Container(
                // transform: Matrix4.translationValues(
                //     _containerSizeAnimation.value * width - 200.0, 0.0, 0.0),
                width: 120,
                height: 120,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
