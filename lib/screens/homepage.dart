import 'package:flutter/material.dart';
import 'package:gijutsu_sol/widget/Button_widget.dart';
import 'package:gijutsu_sol/screens/datalist.dart';
import 'package:gijutsu_sol/widget/textfield.dart';
import 'package:hive/hive.dart';

//shagirul
// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  final PageController pageController = PageController(
    initialPage: 0,
  );
  final firsttextcontroller = TextEditingController();
  final secondtextcontroller = TextEditingController();
  final thirdtextcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isKeyboard)
                  Row(
                    children: [
                      const Expanded(
                        child: Center(
                            child: Text(
                          "What Three Good Things Happen Today",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Datalist())));
                        },
                        child: Icon(Icons.airplay_rounded),
                      )
                    ],
                  ),
                const Expanded(child: SizedBox()),
                const Text("1. Enter The First Good Thing"),
                TextFieldWidget(
                  textcontroller: firsttextcontroller,
                  hint: "I Felt..",
                  borderradius: 12,
                  maxline: 1,
                ),
                const Text("2. Enter The Second Good Thing"),
                TextFieldWidget(
                  textcontroller: secondtextcontroller,
                  hint: "I Felt..",
                  borderradius: 12,
                  maxline: 1,
                ),
                const Text("3. Enter The Third Good Thing"),
                TextFieldWidget(
                  textcontroller: thirdtextcontroller,
                  hint: "I Felt..",
                  borderradius: 12,
                  maxline: 1,
                ),
                const Expanded(flex: 1, child: SizedBox()),
                InkWell(
                  onTap: () {
                    var box = Hive.box("data");
                    final first = firsttextcontroller.text;
                    final second = secondtextcontroller.text;
                    final third = thirdtextcontroller.text;
                    box.add([first, second, third]);
                    // box.deleteFromDisk();
                    FocusScope.of(context).unfocus();

                    const snackBar = SnackBar(
                      content: Text('Added successfully !!!'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    setState(() {
                      firsttextcontroller.text = "";
                      secondtextcontroller.text = "";
                      thirdtextcontroller.text = "";
                    });
                  },
                  child: const ButtonWidget(
                      backgroundcolor: Colors.black,
                      text: "ADD",
                      textcolor: Colors.white),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
