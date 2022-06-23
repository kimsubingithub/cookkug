import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        child: const ClipOval(
                          child: Image(
                            image: AssetImage('assets/images/loopie.jpg'),
                            width: 70.0,
                            height: 70.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                  ),
                  Text('이름',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                    ),
                  ),
                    Text('안녕하세요.\n이름의 쿡꾹입니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                    ),
                ],
              )),
          Positioned(
            right: 5,
            top: 5,
            child: Icon(
              Icons.close,
              size: 15,
              color: Color.fromARGB(255, 255, 138, 0),
            ),
          ),
        ],
      ),
    );
  }
}
