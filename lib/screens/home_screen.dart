import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  Map<String, dynamic>? player;
  bool loading = false;

  void search() async {
    setState(() => loading = true);
    try {
      final data = await ApiService.fetchPlayer(controller.text);
      setState(() => player = data);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Player not found")),
      );
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFF0f0f14)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "BF6 Tracker",
                    style: GoogleFonts.orbitron(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Enter Player Name",
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: search,
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text("Track Player"),
                  ),
                  const SizedBox(height: 30),
                  if (player != null) _glassCard(player!)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _glassCard(Map data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(data["username"],
                  style: const TextStyle(fontSize: 22)),
              Text("KD: ${data["kd"]}"),
              Text("Win Rate: ${data["winRate"]}%"),
              Text("Kills: ${data["kills"]}"),
              Text("Accuracy: ${data["accuracy"]}%"),
            ],
          ),
        ),
      ),
    );
  }
}
