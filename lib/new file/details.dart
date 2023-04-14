import 'package:flutter/material.dart';

class DetailsScreendemo extends StatefulWidget {
  const DetailsScreendemo({Key? key}) : super(key: key);

  @override
  State<DetailsScreendemo> createState() => _DetailsScreendemoState();
}

class _DetailsScreendemoState extends State<DetailsScreendemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.71),
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(5),
                color: Color(0xfff5f5f5),
                elevation: 10,
                child: InkWell(
                  child: Column(
                    children: [
                      Container(
                        height: 125,
                        width: 125,
                        margin: EdgeInsets.only(top: 10, bottom: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(""), fit: BoxFit.fill)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
