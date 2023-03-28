import 'package:flutter/material.dart';

class CustomCollapsible extends StatefulWidget {
  const CustomCollapsible({Key? key}) : super(key: key);

  @override
  State<CustomCollapsible> createState() => _CustomCollapsibleState();
}

class _CustomCollapsibleState extends State<CustomCollapsible> {
  late bool flag = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFDD3D3D3),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            color: Colors.black),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello, Alexander!',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      'Shop Location',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 10),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                    child: Row(
                      children: [
                        // flag ? const SizedBox(height: 20) : const SizedBox(),
                        SizedBox(
                          height: flag ? 15 : 25,
                          child: Text(
                            flag
                                ? 'Cluj-Napoca, Iulius...'
                                : 'Cluj-Napoca, Iulius Mall, nr 33B',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 20, bottom: flag ? 0 : 5),
                          child: Icon(flag ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                              color: Colors.white, size: 20),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, bottom: 30),
                    child: Image.asset('assets/avatar.png',
                      width: 33,
                      height: 33,
                    ),
                  )],
              )
            ],
          ),
        ),
      ),
    );
  }
}
