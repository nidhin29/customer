import 'dart:developer';

import 'package:customer/Application/profile/profile_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:customer/Presentation/Profile/edit_profile.dart';
import 'package:customer/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<ProfileCubit>().state;
      state.isFailureOrSuccessForGet.fold(
        () {
          context.read<ProfileCubit>().getProfile();
        },
        (either) => either.fold((l) {
          context.read<ProfileCubit>().getProfile();
        }, (r) {}),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          state.isFailureOrSuccessForGet.fold(() {}, (either) {
            either.fold((failure) {
              if (!state.isLoading) {
                String message =
                    failure == const MainFailure.serverFailure()
                        ? "Server is down"
                        : failure == const MainFailure.clientFailure()
                        ? "Network issue"
                        : "Unexpected error";
                displaySnackBar(context: context, text: message);
              }
            }, (_) {});
          });
        },
        builder: (context, state) {
          if (state.isLoading) {
            return _buildShimmer(size.width);
          }

          final profile = state.profileModel;
          log(profile.toString());

          if (profile == null ||
              profile.profile!.name == null ||
              profile.profile!.name!.isEmpty) {
            return Center(
              child: Text(
                'No profile data available',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.18,
                        backgroundColor: const Color(0xFF4285F4),
                        child: Text(
                          profile.profile!.name![0].toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: size.width * 0.15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildProfileField('Name', profile.profile!.name!),
                      _buildProfileField(
                        'Address',
                        profile.profile!.address ?? 'N/A',
                      ),
                      _buildProfileField(
                        'Mobile Number',
                        profile.profile!.mobNo ?? 'N/A',
                      ),
                      _buildProfileField(
                        'ID Proof',
                        profile.profile!.idProof ?? 'N/A',
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: const Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color(0xFF34A853),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer(double width) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: CircleAvatar(
              radius: width * 0.18,
              backgroundColor: Colors.grey,
            ),
          ),
          kheight20,
          _shimmerLine(width * 0.6),
          _shimmerLine(width * 0.8),
          _shimmerLine(width * 0.5),
          _shimmerLine(width * 0.7),
        ],
      ),
    );
  }

  Widget _shimmerLine(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 20,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
