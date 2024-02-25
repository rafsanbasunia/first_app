import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

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
  List<Map<String, dynamic>> mytask = [];

  bool showFloatingWindow = false;

  @override
  Widget build(ctx) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      appBar: AppBar(
        title: const Text(
          'Task Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 244, 226, 255),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: const [
            Color.fromARGB(255, 48, 48, 48),
            Color.fromARGB(255, 48, 48, 48)
          ], begin: startAl, end: endAl),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'All Tasks',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 720,
              height: 480,
              child: mytask.isEmpty
                  ? const Center(
                      child: Text(
                        'Click the `➕` icon to add a task!',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 244, 226, 255),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: mytask.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 1.0, 16.0, 1.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18.0),
                            ),
                            color: Color.fromARGB(255, 244, 226, 255),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 232, 225),
                                spreadRadius: 1,
                                blurRadius: 10,
                              ),
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: -1,
                                blurRadius: 1,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GlowCheckbox(
                                value: mytask[index]['isChecked'],
                                enable: true,
                                color: Colors.black,
                                onChange: (bool value) {
                                  setState(() {
                                    mytask[index]['isChecked'] =
                                        !mytask[index]['isChecked'];
                                  });
                                },
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    mytask[index]['task'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    mytask.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: showFloatingWindow
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  showFloatingWindow = !showFloatingWindow;
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
      persistentFooterButtons: showFloatingWindow
          ? [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 244, 226, 255),
                ),
                child: Column(
                  children: [
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: 'Enter Your Task',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onSubmitted: (txt) {
                        addTask(txt);
                        setState(() {
                          showFloatingWindow = false;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 244, 226, 255)),
                      onPressed: () {
                        setState(() {
                          showFloatingWindow = false;
                        });
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          : null,
    );
  }

  void addTask(String txt) {
    setState(() {
      if (txt != '') {
        mytask.add({'task': txt, 'isChecked': false});
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
                  style: TextButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 244, 226, 255)),
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
    });
  }
}
