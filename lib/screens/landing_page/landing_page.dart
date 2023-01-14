import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:midknight_helios/components/custom_blobs.dart';

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
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: h*0.6,
                    child: loginBlob(),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: h*0.6,
                    child: loginBlob1(),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right:8.0,bottom: 8,),
                child: const Text(
                  'Forget swiping,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right:8.0),
                child:  const Text(
                  'Let fate decide.',
                  style: TextStyle(
                    color: Color.fromRGBO(60, 174, 64, 1),
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    const InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Skip Now',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                      
                    },
                    color: Color.fromARGB(255, 66, 14, 179),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    )
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
