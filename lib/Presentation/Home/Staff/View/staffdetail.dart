import 'package:customer/Application/staffview/View/view_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:customer/Presentation/Home/Staff/View/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffDetailsPage1 extends StatelessWidget {
  final String id;

  const StaffDetailsPage1({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ViewCubit>(context).getDetail(id);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ViewCubit, ViewState>(
          listener: (context, state) {
            state.isFailureorSuccess.fold(
              () {},
              (either) => either.fold((failure) {
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
              }, (_) {}),
            );
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return state.isFailureorSuccessForDetail.fold(
              () => const Center(child: Text("No Details found")),
              (either) => either.fold(
                (failure) =>
                    const Center(child: Text("Failed to load details")),
                (detail) {
                  final staff = detail.staffDetails!;
                  return ListView(
                    children: [
                      buildDetailCard("👤 Name", staff.name!),
                      buildDetailCard("📧 Email", staff.emailIdStaff!),
                      buildDetailCard("🏠 Address", staff.address!),
                      buildDetailCard("📱 Mobile No", staff.mobNo!),
                      buildDetailCard("🆔 ID Proof", staff.idProof!),
                      buildDetailCard("💳 UPI", staff.upi!),
                      buildDetailCard("💰 Wage", "₹${staff.wage}"),
                      buildDetailCard("🧑‍💼 Assigned To", staff.assignedTo!),
                      buildDetailCard(
                        "🛠️ Staff Type",
                        StaffType.fromCode(staff.staffType!).name,
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildDetailCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
