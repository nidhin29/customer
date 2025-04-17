import 'package:customer/Application/Feedback/feedback_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EarningsPage extends StatelessWidget {
  const EarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch earnings data here
      BlocProvider.of<FeedbackCubit>(context).earn();
    });
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    return Scaffold(
      appBar: AppBar(title: const Text('Earnings Summary'), centerTitle: true),
      body: BlocConsumer<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
           state.isFailureOrSuccessforEarn.fold(
                    () {},
                    (either) => either.fold((failure) {
                      if (!state.isLoading) {
                        final text =
                            failure == const MainFailure.serverFailure()
                                ? "Server is down"
                                : failure == const MainFailure.clientFailure()
                                ? "Something wrong with your network"
                                : "Something Unexpected Happened";
                        displaySnackBar(context: context, text: text);
                      }
                    }, (r) {}),
                  );
        },
        builder: (context, state) {
 if(state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

        return  state.isFailureOrSuccessforEarn.fold(
            () => const Center(child: Text('No Data Found')),
            (either) => either.fold(
              (failure) => const Center(child: Text('No Data Found')),
              (earnModel) {
                return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoTile('Name', earnModel.staffName!),
                _infoTile('Team', earnModel.team!),
                _infoTile(
                  'Wage per Work',
                  currencyFormat.format(earnModel.wagePerWork),
                ),
                _infoTile(
                  'Total Completed Works',
                  earnModel.totalCompletedWorks.toString(),
                ),
                _infoTile(
                  'Total Earnings',
                  currencyFormat.format(earnModel.totalEarnings),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Work Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: earnModel.details!.length,
                    itemBuilder: (context, index) {
                      final item = earnModel.details![index];
                      final date = DateFormat(
                        'dd MMM yyyy, hh:mm a',
                      ).format(DateTime.parse(item.date!));
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text('Booking ID: ${item.bookingId}'),
                          subtitle: Text('Item: ${item.item}\nDate:$date'),
                          trailing: Text(
                            currencyFormat.format(item.rate),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
