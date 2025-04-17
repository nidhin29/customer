import 'package:customer/Application/Feedback/feedback_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  String formatDateTime(String rawDate) {
    try {
      final dateTime = DateTime.parse(rawDate);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return "Invalid Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FeedbackCubit>(context).getFeedback();
    });
    return BlocConsumer<FeedbackCubit, FeedbackState>(
      listener: (context, state) {
        state.isFailureOrSuccess.fold(
          () {},
          (either) => either.fold((failure) {
            if (!state.isLoading) {
              if (failure == const MainFailure.serverFailure()) {
                displaySnackBar(context: context, text: "Server is down");
              } else if (failure == const MainFailure.clientFailure()) {
                displaySnackBar(
                  context: context,
                  text: "Something wrong with your network",
                );
              } else {
                displaySnackBar(
                  context: context,
                  text: "Something Unexpected Happened",
                );
              }
            }
          }, (_) {}),
        );
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final feedbacks = state.isFailureOrSuccess.fold(
          () => [],
          (either) => either.fold((_) => [], (data) => data.feedbacks ?? []),
        );

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Feedback'),
          ),
          body:
              feedbacks.isEmpty
                  ? const Center(child: Text("No feedbacks available"))
                  : ListView.builder(
                    itemCount: feedbacks.length,
                    itemBuilder: (context, index) {
                      final feedback = feedbacks[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customer Email: ${feedback.customerEmail ?? 'N/A'}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Booking ID: ${feedback.bookingId ?? 'N/A'}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Feedback: ${feedback.feedback ?? 'No feedback'}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Date & Time: ${formatDateTime(feedback.datetime ?? '')}",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        );
      },
    );
  }
}
