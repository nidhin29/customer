import 'package:customer/Application/edit_profile/editprofile_cubit.dart';
import 'package:customer/Application/profile/profile_cubit.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Profile/profile_service.dart';
import 'package:customer/Presentation/Common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _idProofController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return BlocConsumer<EditprofileCubit, EditprofileState>(
      listener: (context, state) {
        state.isFailureOrSuccessForUpdate.fold(
          () {},
          (either) => either.fold(
            (failure) {
              if (!state.isLoading) {
                if (failure == const MainFailure.serverFailure()) {
                  displaySnackBar(context: context, text: "Server is down");
                } else if (failure == const MainFailure.clientFailure()) {
                  displaySnackBar(context: context, text: "Network error");
                } else {
                  displaySnackBar(context: context, text: "Unexpected error");
                }
              }
            },
            (r) {
              BlocProvider.of<ProfileCubit>(context).getProfile();
              Navigator.of(context).pop();
            },
          ),
        );
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            state.isFailureOrSuccessForGet.fold(
              () {},
              (either) => either.fold(
                (failure) {
                  if (!state.isLoading) {
                    if (failure == const MainFailure.serverFailure()) {
                      displaySnackBar(context: context, text: "Server is down");
                    } else if (failure == const MainFailure.clientFailure()) {
                      displaySnackBar(context: context, text: "Network error");
                    } else {
                      displaySnackBar(
                        context: context,
                        text: "Unexpected error",
                      );
                    }
                  }
                },
                (r) {
                  _nameController.text = r.profile!.name ?? '';
                  _addressController.text = r.profile!.address ?? '';
                  _mobileController.text = r.profile!.mobNo ?? '';
                  _idProofController.text = r.profile!.idProof ?? '';
                },
              ),
            );
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  'Edit Profile',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: size * 0.02,
                      bottom: size * 0.01,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<EditprofileCubit>(
                          context,
                        ).updateProfile(
                          profileModel: ProfileModel(
                            name: _nameController.text,
                            address: _addressController.text,
                            mobileNumber: _mobileController.text,
                            idProof: _idProofController.text,
                          ),
                        );
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Color.fromARGB(255, 66, 159, 69),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      _TextFieldWithTitle(
                        title: "Name",
                        controller: _nameController,
                      ),
                      _TextFieldWithTitle(
                        title: "Address",
                        controller: _addressController,
                      ),
                      _TextFieldWithTitle(
                        title: "Mobile Number",
                        controller: _mobileController,
                      ),
                      _TextFieldWithTitle(
                        title: "ID Proof",
                        controller: _idProofController,
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _TextFieldWithTitle extends StatelessWidget {
  const _TextFieldWithTitle({required this.title, required this.controller});
  final String title;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 0.1,
          ),
        ),
        TextField(
          controller: controller,
          decoration: const InputDecoration(border: UnderlineInputBorder()),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
