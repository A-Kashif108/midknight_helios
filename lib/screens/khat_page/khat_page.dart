import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class KhatPage extends StatelessWidget {
  const KhatPage({super.key});

  // final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/khat_paper.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h * 0.03,
                  width: w * 0.9,
                  // color: Colors.grey,
                ),
                Container(
                  child: TextField(
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Pour your feelings here.....',
                        hintStyle: const TextStyle(
                          fontSize: 22,
                        ),
                        contentPadding: const EdgeInsets.all(18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        // filled: true,
                        // fillColor: Colors.grey.withOpacity(0.2),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 24),
                ),
                Padding(
                  padding: const EdgeInsets.all(23.0),
                  child: SizedBox(
                    height: 50,
                    width: w * 0.9,
                    child: MaterialButton(
                      onPressed: () {
                        // setState(() {
                        //   // progress++;
                        // });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                          
                      child: const Text(
                        'SEND',
                        style: TextStyle(color: Color.fromARGB(219, 131, 85, 1), fontSize: 35,fontWeight: FontWeight.w500),
                        
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
