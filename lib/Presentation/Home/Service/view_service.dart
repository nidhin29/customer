import 'package:customer/Application/Service/service_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:customer/Presentation/Home/Service/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// Example State and Cubit classes:
// class ServicesState { final bool isLoading; final List<Service> services; final String? error; }
// class ServicesCubit extends Cubit<ServicesState> { void fetchServices(); }

class ViewServicesPage extends StatelessWidget {
  const ViewServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ServiceCubit>(context).getService();
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'View Services',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          state.isFailureOrSuccessforGet.fold(
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
            }, (r) {}),
          );
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return state.isFailureOrSuccessforGet.fold(
            () => const Center(child: Text("No services available")),
            (either) => either.fold(
              (failure) {
                return const Center(child: Text("Error loading services"));
              },
              (services) {
                return services.services!.isEmpty
                    ? const Center(child: Text("No services available"))
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: services.services!.length,
                      itemBuilder: (context, index) {
                        final service = services.services![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        BookServicePage(serviceId: service.id!),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    service.imageUrl!,
                                    height: 180,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service.items!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Company: ${service.companyName}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Description: ${service.description}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Rate: ₹${service.rate}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
