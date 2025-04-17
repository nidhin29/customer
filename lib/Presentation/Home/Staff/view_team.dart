import 'package:customer/Application/staffview/View/view_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:customer/Presentation/Home/Bookings/Chat/chat.dart';
import 'package:customer/Presentation/Home/Staff/View/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewTeamPage extends StatelessWidget {
  final int teamId;
  final int userType = 1;
  const ViewTeamPage({super.key, required this.teamId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ViewCubit>(context).getTeam(teamId);
    });
    return BlocConsumer<ViewCubit, ViewState>(
      listener: (context, state) {
        state.isFailureorSuccessForTeam.fold(
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
        if (state.isLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Team - ${state.isFailureorSuccessForTeam.fold(() => '', (either) => either.fold((failure) => '', (teamModel) => teamModel.team))}',
            ),
            backgroundColor: Colors.blueAccent,
          ),
          body: state.isFailureorSuccessForTeam.fold(
            () => const Center(child: Text('No Team Found')),
            (either) => either.fold(
              (failure) => const Center(child: Text('No Team Found')),
              (teamModel) {
                return ListView.builder(
                  itemCount: teamModel.staff!.length,
                  itemBuilder: (context, index) {
                    final staff = teamModel.staff![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ChatPage(
                                  id: teamId,
                                  name: teamModel.staff![index].name!,
                                  userType: 2,
                                  email: teamModel.staff![index].email!,
                                ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              staff.name![0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(staff.name!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: ${staff.email}'),
                              Text('Mobile: ${staff.mobNo}'),
                              Text(
                                'Type: ${StaffType.fromCode(staff.staffType!).name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
