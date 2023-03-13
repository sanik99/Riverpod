import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:riverpod_app/detailsPage.dart';
import 'package:riverpod_app/models/todo.dart';
import 'package:riverpod_app/providers/todoProvider.dart';
import 'package:riverpod_app/todoScreen.dart';
import 'package:riverpod_app/widgets/toas.dart';

void main() {
  runApp(ProviderScope(
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoApp',
      theme: ThemeData.dark(),
      home: TodoApp(),
    ),
  ));
}

class TodoApp extends StatelessWidget {
  final txtArea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Simple Todo App'),
        ),
        body: Consumer(builder: (context, ref, child) {
          final todoList = ref.watch(listOfTodoProvider);
          return Stack(
            children: [
              Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: txtArea,
                  //     onFieldSubmitted: (value) {
                  //       if (value.isEmpty) {
                  //         ToastShow.Message('Can\'t add empty fields');
                  //       } else {
                  //         final newTodo = TodoModels(
                  //             title: value,
                  //             dateTime: DateTime.now().toIso8601String());

                  //         ref.read(listOfTodoProvider.notifier).add(newTodo);

                  //         txtArea.clear();
                  //       }
                  //       // print(value);
                  //     },
                  //     decoration: const InputDecoration(
                  //         contentPadding: EdgeInsets.symmetric(
                  //             horizontal: 20, vertical: 20),
                  //         hintText: 'add todo here',
                  //         border: OutlineInputBorder(),
                  //         // prefixIcon: Icon(Icons.add),
                  //         suffixIcon: Icon(Icons.add)),
                  //     // maxLength: 1,
                  //   ),
                  // ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        final todos = todoList[index];
                        return ListTile(
                          onTap: () {
                            Get.to(() => TodoDetails(
                                title: todoList[index].title,
                                dateTime: todoList[index].dateTime));
                          },
                          // leading: Icon(Icons.add),
                          title: Text(
                            todos.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(todos.dateTime),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          final titleController =
                                              TextEditingController(
                                                  text: todos.title);
                                          return AlertDialog(
                                            title: const Text(
                                                'Update your todo here'),
                                            content: TextFormField(
                                              controller: titleController,
                                              // initialValue: todos.title,
                                              textInputAction:
                                                  TextInputAction.newline,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              minLines: 3,
                                              maxLines: null,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                              // onFieldSubmitted: (value) {
                                              //   newTitle = value;
                                              // },
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    final newTitle =
                                                        titleController.text;

                                                    if (newTitle.isEmpty) {
                                                      ToastShow.Message(
                                                          'Can\'t add empty value');
                                                    } else {
                                                      ref
                                                          .read(
                                                              listOfTodoProvider
                                                                  .notifier)
                                                          .update(TodoModels(
                                                              title: newTitle,
                                                              dateTime: todos
                                                                  .dateTime));
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  // },
                                                  child: const Text('Done'))
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.edit)),
                              const SizedBox(width: 20),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    ref
                                        .read(listOfTodoProvider.notifier)
                                        .delete(todos);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 290,
                right: 0,
                bottom: 20,
                child: FloatingActionButton(
                    backgroundColor: Colors.lime.shade700,
                    onPressed: () {
                      Get.to(() => TodoScreen());
                    },
                    child: const Icon(Icons.add)),
              )
            ],
          );
        }),
      ),
    );
  }
}
