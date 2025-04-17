import 'package:customer/Application/Feedback/feedback_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage1 extends StatelessWidget {
  final String id;
  FeedbackPage1({super.key, required this.id});

  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Give Feedback'),
        backgroundColor: Colors.orange,
      ),
      body: BlocConsumer<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          state.isFailureOrSuccessforAdd.fold(
            () {},
            (either) => either.fold((failure) {}, (r) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback submitted successfully'),
                ),
              );
            }),
          );
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Write your feedback",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _feedbackController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Type here...",
                    border: OutlineInputBorder(),
                  ),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_feedbackController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your feedback'),
                          ),
                        );
                        return;
                      }
                      BlocProvider.of<FeedbackCubit>(
                        context,
                      ).addFeedback(id, _feedbackController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Submit Feedback"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
