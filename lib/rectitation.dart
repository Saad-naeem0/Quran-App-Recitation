import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recitation extends StatelessWidget {
  final List<String> _ayah = <String>[
    'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
    'ٱلْحَمْدُ لِلَّٰهِ',
    'الله أكبر',
    'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ'
  ];
  final List<String> _translation = <String>['abc', 'def', 'abc', 'def'];
  final List<String> _urduTrans = <String>['آسان', 'مشکل', "اچھا", 'برا'];

  @override
  Widget build(BuildContext context) {
    final List<int> colorCodes = <int>[50, 100, 50, 100];
    // [for (int i=0; i<=_ayah.length; i++){
    //   if(i%2==0){
    //     50
    //   }
    //   else{
    //     100
    //   }
    // }.length];
    var height = MediaQuery.of(context).size.height * .3;
    var width = MediaQuery.of(context).size.width * .1;
    // var sno = for(int i=1; i<=_translation.length; i++);
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _ayah.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: height,
                  color: Colors.green[colorCodes[index]],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_ayah[index]}        ۝ ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.black87,
                              fontFamily: 'Quranic'),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${_translation[index]}',
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                            )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${_urduTrans[index]}',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 330),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.play_arrow),
                          ),
                        ),
                      ],
                    ),
                  )
                  // Center(child: Text('1 ${entries[index]}')),
                  );
            }),
      ),
    );
  }
}
