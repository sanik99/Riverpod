import 'package:flutter/material.dart';

class TodoDetails extends StatelessWidget {
  TodoDetails({required this.title, required this.dateTime});

  String title;
  String dateTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Created at:  $dateTime',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.teal.shade400),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Return',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
