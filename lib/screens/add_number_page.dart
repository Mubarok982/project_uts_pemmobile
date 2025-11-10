import 'package:flutter/material.dart';

class AddNumberPage extends StatefulWidget {
  const AddNumberPage({super.key});

  @override
  State<AddNumberPage> createState() => _AddNumberPageState();
}

class _AddNumberPageState extends State<AddNumberPage> {
  String input = '';

  void tambahAngka(String angka) {
    setState(() {
      input = angka;
    });
  }

  void hapus() {
    setState(() {
      input = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      'C', '0', '⌫',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        title: const Text('Tambah Angka'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Text(
                input.isEmpty ? '0' : input,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // Grid tombol angka
            Expanded(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final value = buttons[index];
                  Color bgColor = Colors.deepPurple.shade100;
                  Color textColor = Colors.deepPurple;

                  if (value == 'C') {
                    bgColor = Colors.red.shade100;
                    textColor = Colors.red;
                  } else if (value == '⌫') {
                    bgColor = Colors.orange.shade100;
                    textColor = Colors.orange.shade800;
                  }

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bgColor,
                      foregroundColor: textColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      if (value == 'C') {
                        hapus();
                      } else if (value == '⌫') {
                        setState(() {
                          if (input.isNotEmpty) {
                            input = input.substring(0, input.length - 1);
                          }
                        });
                      } else {
                        tambahAngka(value);
                      }
                    },
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
