import 'package:flutter/material.dart';
import 'package:visan_portal/components/recruiter_tile.dart';
import 'package:visan_portal/model/recruiter_model.dart';
import 'package:visan_portal/service/recruiter_service.dart';

class HomeRecruiter extends StatefulWidget {
  RecruiterService recruiterService;
  HomeRecruiter({super.key, required this.recruiterService});

  @override
  State<HomeRecruiter> createState() => HomeRecruiterState();
}

class HomeRecruiterState extends State<HomeRecruiter> {
  late List<RecruiterModel> recruiterDetails;
  bool isRecent = true;

  loadRecentItems() {
    isRecent = true;
    setState(() {
      return;
    });
  }

  loadMatched() {
    isRecent = false;
    setState(() {
      return;
    });
  }

  getButtonColor(bool isPrimary) {
    return isPrimary
        ? MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 191, 231, 255))
        : MaterialStateProperty.all<Color>(Colors.white);
  }

  @override
  void initState() {
    loadRecentItems();
    List<RecruiterModel> recruiterModel = widget.recruiterService.getDetails();
    super.initState();
    setState(() {
      recruiterDetails = recruiterModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              Expanded(flex: 1, child: Image.asset('assets/images/pic.png')),
              const Expanded(
                  flex: 4,
                  child: Text(
                    'Hi, Vijay',
                    style: TextStyle(
                        color: Color.fromARGB(255, 11, 88, 131),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Open Sans'),
                  )),
              const Expanded(
                  flex: 1, child: Icon(Icons.notifications_outlined)),
              const Expanded(
                  flex: 1, child: Icon(Icons.align_horizontal_right_rounded))
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: getButtonColor(isRecent),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 11, 88, 131)),
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(45))),
                  onPressed: () {
                    loadRecentItems();
                  },
                  child: const Text("Recent Jobs"),
                ),
              )),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 5),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: getButtonColor(!isRecent),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 11, 88, 131)),
                        minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(45))),
                    onPressed: () {
                      loadMatched();
                    },
                    child: const Text("Matched")),
              ))
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: this.recruiterDetails.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  padding: EdgeInsets.only(top:10),
                    height: 80,
                    child: RecruiterTile(
                        recruiterDetails: recruiterDetails[index]));
              })
        ]),
        
      ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            color: Colors.black),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save_alt,
            color: Colors.black),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.select_all_outlined,
            color: Colors.black),
            label: 'Selected',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline,
            color: Colors.black),
            label: 'Chat',
          ),
        ],
        ),
    );
    
  }
}
