import 'package:flutter/material.dart';
import 'package:gijutsu_sol/screens/homepage.dart';
import 'package:hive/hive.dart';

class Datalist extends StatefulWidget {
  Datalist({Key? key}) : super(key: key);

  @override
  State<Datalist> createState() => _DatalistState();
}

class _DatalistState extends State<Datalist> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => HomePage())));
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
          elevation: 0,
          title: const Expanded(
            child: Center(
                child: Text(
              "Your records",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
          )),
      body: Container(
        padding:
            const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        color: Colors.white,
        child: const List(),
      ),
    ));
  }
}

class List extends StatefulWidget {
  const List({Key? key}) : super(key: key);

  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
  // final _box = Hive.box("data");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox("data"),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return Tile();
            } else {
              return const Center(child: Text("Nothing Here"));
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          }
        }));
  }
}

class Tile extends StatefulWidget {
  Tile({Key? key}) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  final box = Hive.box("data");
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: box.length,
      itemBuilder: (context, index) {
        final doc = box.get(index);
        return ListTile(
          title: Container(
            decoration: BoxDecoration(
                border: const Border(
                    bottom: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black)),
                borderRadius: BorderRadius.circular(20),
                color: Colors.white),
            padding: const EdgeInsets.all(20),
            // color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  index.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc[0],
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      doc[1],
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      doc[2],
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
                const Spacer(),
                // InkWell(
                //   onTap: () {
                //     box.deleteAt(index);
                //   },
                //   child: const Icon(
                //     Icons.delete,
                //     color: Colors.black,
                //   ),
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
