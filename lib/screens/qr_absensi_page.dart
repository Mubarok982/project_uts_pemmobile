import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

class QrAbsensiPage extends StatefulWidget {
  const QrAbsensiPage({super.key});

  @override
  State<QrAbsensiPage> createState() => _QrAbsensiPageState();
}

class _QrAbsensiPageState extends State<QrAbsensiPage> {
  List<String> qrDataList = [];
  int antrian = 0;

  // Fungsi generate QR baru
  void generateQr() {
    setState(() {
      antrian++;
      String newQrData = "ABSENSI-2025-ID-${Random().nextInt(100000)}";
      qrDataList.insert(0, newQrData); // terbaru di atas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text("QR Absensi"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bagian jumlah antrian
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.deepPurple,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Jumlah Antrian",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$antrian",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol generate QR
            // Ganti bagian tombol ElevatedButton.icon dengan ini
            ElevatedButton(
              onPressed: generateQr,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.transparent, // biar gradient terlihat
                elevation: 0,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.orangeAccent, Colors.deepOrange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.qr_code, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Generate QR Baru",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // List QR Codes
            Expanded(
              child: ListView.builder(
                itemCount: qrDataList.length,
                itemBuilder: (context, index) {
                  String qrData = qrDataList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          QrImageView(
                            data: qrData,
                            size: 200,
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Scan untuk Absensi #${antrian - index}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
