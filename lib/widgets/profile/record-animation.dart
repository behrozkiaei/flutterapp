import 'dart:async';
import 'package:flutter/material.dart';

class RecordingIcon extends StatefulWidget {
  const RecordingIcon({super.key});

  @override
  _RecordingIconState createState() => _RecordingIconState();
}

class _RecordingIconState extends State<RecordingIcon> with TickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    
    // Start the animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      

        const Text(
          'Req',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
          const SizedBox(width: 5.0),
          CircleAvatar(
          backgroundColor: Colors.red,
          radius: 10.0,
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.3).animate(
              CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
            ),
            child: const Icon(
              Icons.fiber_manual_record,
              size: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
