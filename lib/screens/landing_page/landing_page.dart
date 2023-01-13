import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:midknight_helios/components/parallelogram.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                height: h*0.6,
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right:8.0,bottom: 8,top: 8),
                child: Text(
                  'Let us know you better...',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right:8.0,bottom: 8,top: 8),
                child: const Text(
                  'Lorem ipsum dolor, sit amet consectetur adipisicing elit.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Skip Now')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
