import 'package:customer/Application/Service/service_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BookServicePage extends StatefulWidget {
  final int serviceId;

  const BookServicePage({super.key, required this.serviceId});

  @override
  State<BookServicePage> createState() => _BookServicePageState();
}

class _BookServicePageState extends State<BookServicePage> {
  DateTime? _selectedDateTime;

  void _selectDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay(hour: 17, minute: 30),
      );

      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _bookService() {
    if (_selectedDateTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    BlocProvider.of<ServiceCubit>(
      context,
    ).bookService(widget.serviceId.toString(), _selectedDateTime!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Service booked successfully")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Service",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          state.isFailureOrSuccess.fold(
            () {},
            (either) => either.fold((failure) {
              if (!state.isLoading) {
                if (failure == const MainFailure.serverFailure()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Server is down")),
                  );
                } else if (failure == const MainFailure.clientFailure()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Something wrong with your network"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Something Unexpected Happened"),
                    ),
                  );
                }
              }
            }, (r) {}),
          );
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ListTile(
                  onTap: _selectDateTime,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Colors.white,
                  title: Text(
                    _selectedDateTime == null
                        ? "Select Date & Time"
                        : DateFormat(
                          'MMM d, yyyy - h:mm a',
                        ).format(_selectedDateTime!),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: const Icon(Icons.calendar_today),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _bookService,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color(0xFF34A853),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Book Now",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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
