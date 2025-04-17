import 'package:customer/constants/const.dart';
import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({super.key, required this.message, required this.time});
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: const Color.fromARGB(255, 53, 239, 236),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 50,
                  top: 5,
                  bottom: 20,
                ),
                child: Text(message, style: const TextStyle(fontSize: 16)),
              ),
              Positioned(
                bottom: 4,
                right: 5,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(fontSize: 11.9, color: Colors.grey[600]),
                    ),
                    kwidth5,
                    const Icon(Icons.done_all, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
