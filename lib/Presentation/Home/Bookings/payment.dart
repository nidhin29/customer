import 'package:customer/Application/Feedback/feedback_cubit.dart';
import 'package:customer/Application/staffview/booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatelessWidget {
  final String bookingId; // Dummy booking ID
  const PaymentPage({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController(
      text: "1500",
    ); // dummy amount

    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          state.isFailureOrSuccessforAdd.fold(
            () {},
            (either) => either.fold((failure) {}, (r) {
              BlocProvider.of<BookingCubit>(context).getBookings();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment submitted successfully')),
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
                const Text("Amount to Pay", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixText: "₹ ",
                  ),
                ),
                const SizedBox(height: 24),
                const Text("Payee Name", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "John Doe",
                  ),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<FeedbackCubit>(
                        context,
                      ).makePayment(bookingId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text("Submit Payment"),
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
