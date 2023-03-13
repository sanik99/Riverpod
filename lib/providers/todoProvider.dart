import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/todo.dart';

final listOfTodoProvider =
    StateNotifierProvider<TodoProvider, List<TodoModels>>(
  (ref) => TodoProvider([
    TodoModels(
        title: 'My first todo', dateTime: DateTime.now().toIso8601String())
  ]),
);

class TodoProvider extends StateNotifier<List<TodoModels>> {
  TodoProvider(super.state);

  add(TodoModels todoModels) {
    state = [...state, todoModels];
    // state.add(todoModels);
  }

  delete(TodoModels todoModels) {
    state.remove(todoModels);
    state = [...state];
  }

  update(TodoModels newTodoModels) {
    final previousTodo = state
        .firstWhere((element) => element.dateTime == newTodoModels.dateTime);

    state = [
      for (final m in state)
        if (m == previousTodo) newTodoModels else m
    ];
  }
}
