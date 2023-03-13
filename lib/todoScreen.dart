import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/todo.dart';
import 'package:riverpod_app/providers/todoProvider.dart';
import 'package:riverpod_app/widgets/toas.dart';

class TodoScreen extends StatelessWidget {
  final txtArea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Add Todo here...'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: txtArea,
                      // onFieldSubmitted: (value) {
                      //   // print(value);
                      // },
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        hintText: 'add todo here',
                        border: OutlineInputBorder(),
                        // prefixIcon: Icon(Icons.add),
                        suffixIcon: Icon(Icons.add),
                      ),
                      // maxLength: 1,
                      minLines: 5,
                      maxLines: null,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.tealAccent.shade700),
                        onPressed: () {
                          final value = txtArea.text;
                          if (value.isEmpty) {
                            ToastShow.Message('Can\'t add empty fields');
                          } else {
                            final newTodo = TodoModels(
                                title: value,
                                dateTime: DateTime.now().toIso8601String());

                            ref.read(listOfTodoProvider.notifier).add(newTodo);

                            txtArea.clear();

                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(fontSize: 18),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
