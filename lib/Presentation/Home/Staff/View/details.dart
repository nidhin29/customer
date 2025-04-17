import 'package:customer/Application/staffview/View/view_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:customer/Presentation/Home/Staff/View/staffdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffDetailsPage extends StatelessWidget {
  final String teamName;

  const StaffDetailsPage({super.key, required this.teamName});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ViewCubit>(context).getStaffs(teamName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("View in $teamName"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocConsumer<ViewCubit, ViewState>(
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

          return state.isFailureorSuccess.fold(
            () => const Center(child: Text("No staff found")),
            (either) => either.fold(
              (failure) => const Center(child: Text("Failed to load staff")),
              (staffs) =>
                  staffs.staffs!.isEmpty
                      ? Center(child: Text("No staff found"))
                      : ListView.builder(
                        itemCount: staffs.staffs!.length,
                        itemBuilder: (context, index) {
                          final staff = staffs.staffs![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          StaffDetailsPage1(id: staff.staffId!),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                title: Text(staff.staffName!),
                                subtitle: Text(
                                  StaffType.fromCode(staff.staffType!).label,
                                ),
                                trailing: Text(staff.staffId!),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          );
        },
      ),
    );
  }
}

enum StaffType {
  manager,
  chef,
  designer,
  deliveryAgent,
  cateringBoy,
  localWorker;

  String get label {
    switch (this) {
      case StaffType.manager:
        return 'Manager';
      case StaffType.chef:
        return 'Chef';
      case StaffType.designer:
        return 'Designer';
      case StaffType.deliveryAgent:
        return 'Delivery Agent';
      case StaffType.cateringBoy:
        return 'Catering Boy';
      case StaffType.localWorker:
        return 'Local Worker';
    }
  }

  static StaffType fromCode(String code) {
    switch (code) {
      case '1':
        return StaffType.manager;
      case '2':
        return StaffType.chef;
      case '3':
        return StaffType.designer;
      case '4':
        return StaffType.deliveryAgent;
      case '5':
        return StaffType.cateringBoy;
      case '6':
        return StaffType.localWorker;
      default:
        throw Exception('Invalid staff type code: $code');
    }
  }
}
