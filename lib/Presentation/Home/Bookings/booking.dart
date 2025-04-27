import 'package:customer/Application/staffview/booking_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:customer/Presentation/Home/Bookings/Chat/chat.dart';
import 'package:customer/Presentation/Home/Bookings/give_feedback.dart';
import 'package:customer/Presentation/Home/Bookings/payment.dart';
import 'package:customer/Presentation/Home/Staff/view_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewBookingsPage extends StatefulWidget {
  const ViewBookingsPage({super.key});

  @override
  State<ViewBookingsPage> createState() => _ViewBookingsPageState();
}

class _ViewBookingsPageState extends State<ViewBookingsPage> {
  int? userType;
  int? staffType;

  @override
  void initState() {
    super.initState();
    _loadUserType();
    BlocProvider.of<BookingCubit>(context).getBookings();
  }

  Future<void> _loadUserType() async {
    userType = int.parse(TokenManager.instance.user!);
    if (userType == 2) {
      staffType = int.parse(TokenManager.instance.stafftype!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Bookings'),
        backgroundColor: Colors.blueAccent,
      ),
      body:
          userType == null
              ? const Center(child: CircularProgressIndicator())
              : BlocConsumer<BookingCubit, BookingState>(
                listener: (context, state) {
                  state.bookings.fold(
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  return state.bookings.fold(
                    () => const Center(child: Text("No bookings available")),
                    (either) => either.fold(
                      (failure) =>
                          const Center(child: Text("Error loading bookings")),
                      (bookings) {
                        return bookings.bookings!.isEmpty
                            ? const Center(child: Text("No bookings available"))
                            : ListView.builder(
                              itemCount: bookings.bookings!.length,
                              itemBuilder: (context, index) {
                                final booking = bookings.bookings![index];
                                return GestureDetector(
                                  onTap: () {
                                    if (userType == 2 && staffType != 1) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ChatPage(
                                              id: booking.id!,
                                              userType: userType!,
                                              name: 'Manager@',
                                            );
                                          },
                                        ),
                                      );
                                    } else if (userType == 3) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ChatPage(
                                              id: booking.id!,
                                              userType: userType!,
                                              name:
                                                  '${bookings.bookings![index].ownerName}@',
                                            );
                                          },
                                        ),
                                      );
                                    } else if (userType == 1) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ChatPage(
                                              id: booking.id!,
                                              userType: userType!,
                                              name:
                                                  '${bookings.bookings![index].customerEmail}',
                                              email:
                                                  bookings
                                                      .bookings![index]
                                                      .customerEmail,
                                            );
                                          },
                                        ),
                                      );
                                    } else if (staffType == 1) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return ViewTeamPage(
                                              teamId: booking.id!,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Service: ${userType == 3 ? booking.service : booking.items}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text("Rate: ₹${booking.rate}"),
                                            Text(
                                              "Date & Time: ${booking.datetime}",
                                            ),

                                            if (userType == 1) ...[
                                              Text(
                                                "Customer: ${booking.customerEmail}",
                                              ),
                                              Text(
                                                "Payment Status: ${booking.paymentStatus == 0 ? "Pending" : "Paid"}",
                                              ),
                                              booking.approvalStatus == 0
                                                ? DropdownButton<String>(
                                                  value: booking.assignedTeam,
                                                  hint: const Text("Select Team"),
                                                  items: [
                                                  "Team A",
                                                  "Team B",
                                                  "Team C",
                                                  "Team D"
                                                  ].map((team) {
                                                  return DropdownMenuItem<String>(
                                                    value: team,
                                                    child: Text(team),
                                                  );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                  setState(() {
                                                    booking.assignedTeam = value;
                                                  });
                                                  },
                                                )
                                                : Text(
                                                  "Assigned Team: ${booking.assignedTeam ?? "Not assigned"}",
                                                ),
                                            ] else if (userType == 0) ...[
                                              Text(
                                                "Assigned Team: ${booking.assignedTeam ?? "Not assigned"}",
                                              ),
                                            ],

                                            if (userType == 1 &&
                                                booking.approvalStatus ==
                                                    0) ...[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                                                                            print(
                                                        booking.assignedTeam
                                                            .toString(),
                                                      );
                                                      context
                                                          .read<BookingCubit>()
                                                          .approveBooking(
                                                            booking.id
                                                                .toString(),
                                                            booking.assignedTeam
                                                                .toString(),
                                                          );
                                                    },
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                    child: const Text(
                                                      "Approve",
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  ElevatedButton(
                                                    onPressed: () {

                                                      context
                                                          .read<BookingCubit>()
                                                          .rejectBooking(
                                                            booking.id
                                                                .toString(),
                                                            booking.assignedTeam
                                                                .toString(),
                                                          );
                                                    },
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                        ),
                                                    child: const Text("Reject"),
                                                  ),
                                                ],
                                              ),
                                            ] else if (userType == 1) ...[
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        booking.approvalStatus ==
                                                                1
                                                            ? Colors
                                                                .green
                                                                .shade100
                                                            : Colors
                                                                .red
                                                                .shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    booking.approvalStatus == 1
                                                        ? "Accepted"
                                                        : "Rejected",
                                                    style: TextStyle(
                                                      color:
                                                          booking.approvalStatus ==
                                                                  1
                                                              ? Colors
                                                                  .green
                                                                  .shade800
                                                              : Colors
                                                                  .red
                                                                  .shade800,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],

                                            if (userType == 3) ...[
                                              if (booking.approvalStatus == 1 &&
                                                  booking.paymentStatus != 1)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 12.0,
                                                      ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (
                                                                  context,
                                                                ) => PaymentPage(
                                                                  bookingId:
                                                                      booking.id
                                                                          .toString(),
                                                                ),
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.payment,
                                                      ),
                                                      label: const Text(
                                                        "Make Payment",
                                                      ),
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            foregroundColor:
                                                                Colors.white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              if (booking.workCompletedStatus ==
                                                  1)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 12.0,
                                                      ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ElevatedButton.icon(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (
                                                                  context,
                                                                ) => FeedbackPage1(
                                                                  id:
                                                                      booking.id
                                                                          .toString(),
                                                                ),
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.feedback_outlined,
                                                      ),
                                                      label: const Text(
                                                        "Give Feedback",
                                                      ),
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                Colors.orange,
                                                            foregroundColor:
                                                                Colors.white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                            ],

                                            if (userType == 2) ...[
                                              if (staffType == 1) ...[
                                                if (booking
                                                        .workCompletedStatus ==
                                                    0)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          top: 12.0,
                                                        ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                BookingCubit
                                                              >()
                                                              .markComplete(
                                                                booking.id
                                                                    .toString(),
                                                              );
                                                        },
                                                        style:
                                                            ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.green,
                                                            ),
                                                        child: const Text(
                                                          "Mark Completed",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (booking
                                                        .workCompletedStatus ==
                                                    1)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                          top: 12.0,
                                                        ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 6,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors
                                                                  .green
                                                                  .shade100,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                8,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          "Work Completed",
                                                          style: TextStyle(
                                                            color:
                                                                Colors
                                                                    .green
                                                                    .shade800,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ] else ...[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 12,
                                                      ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "Viewing access only",
                                                      style: TextStyle(
                                                        color:
                                                            Colors
                                                                .grey
                                                                .shade600,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
