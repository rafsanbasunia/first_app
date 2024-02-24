import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});
  @override
  State<Todo> createState() {
    return _TodoState();
  }
}

class _TodoState extends State<Todo> {
  var startAl = Alignment.topLeft;
  TextEditingController controller = TextEditingController();

  var endAl = Alignment.bottomRight;
  List<String> mytask = [];

  @override
  Widget build(ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: const [
            Color.fromARGB(255, 42, 35, 75),
            Color.fromARGB(255, 54, 35, 75),
            Color.fromARGB(255, 35, 52, 75)
          ], begin: startAl, end: endAl),
        ),
        child: Column(
          children: [
            TextField(
                style: const TextStyle(color: Colors.amberAccent),
                controller: controller,
                decoration: const InputDecoration(
                    labelText: 'Enter Your Task',
                    labelStyle: TextStyle(
                      color: Colors.amberAccent,
                    )),
                onSubmitted: (txt) {
                  addTask(txt);
                }),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 720,
              height: 480,
              child: ListView.builder(
                  itemCount: mytask.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18.0),
                            ),
                            color: Color.fromARGB(255, 35, 4, 53),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 217, 0),
                                spreadRadius: 1,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 217, 0),
                                spreadRadius: -1,
                                blurRadius: 1,
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  mytask[index],
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 217, 0),
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: Color.fromARGB(255, 255, 208, 0),
                              onPressed: () {
                                setState(() {
                                  mytask.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ));
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask(controller.text);
        },
        child: const Icon(
          Icons.add,
          color: Colors.amberAccent,
        ),
      ),
    );
  }

  void addTask(String txt) {
    setState(
      () {
        if (txt != '') {
          mytask.add(txt);
          controller.clear();
        } else {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text(
                  "Please write something :'(",
                  style: TextStyle(fontSize: 20),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
