import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(
      // wrap the entire app with the providerScope so that widgets
      // will able to read providers
      const ProviderScope(
    child: MaterialApp(
      title: 'Riverpod App',
      home: MyApp(),
    ),
  ));
}

// provider that returns a string value
// Provider is made up of three things
// 1. The declaration: "final helloWorld" is the global variable that will be used to read the state of the provider
// 2. The Provider: "Provider<String>" tells us what kind of provider are we using and the type of state it holds
// 3. A function that creates the state. This gives us a "ref" parameter
// that we use to read the providers, performs some custom dispose logic, and more.
// final helloWorld = Provider<String>((ref) => 'Hello World');

final nameProvider =
    Provider<String>((ref) => 'My name is Sanik Kumar Shrestha');

final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

// 1. widget class now extends "ConsumerWidget"
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // 2. build method has now extra "WidgetRef" argument
  Widget build(BuildContext context) {
    print('build running');
    // final name = ref.watch(nameProvider);
    return SafeArea(
      child: Scaffold(body: Consumer(builder: (context, ref, child) {
        final counter = ref.watch(counterStateProvider);

        return Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Center(
              child: Text(
                '$counter',
                style: const TextStyle(fontSize: 50),
              ),
            ),
            const SizedBox(height: 300),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // chamge the state on the button callback
                      ref.watch(counterStateProvider.notifier).state++;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      fixedSize: const Size(70, 70),
                      shape: const CircleBorder(),
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (counter > 0) {
                        // chamge the state on the button callback
                        ref.watch(counterStateProvider.notifier).state--;
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Can\'t decrease from 0',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.amber,
                            textColor: Colors.white);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      fixedSize: const Size(70, 70),
                      shape: const CircleBorder(),
                    ),
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      })),
    );
  }
}
