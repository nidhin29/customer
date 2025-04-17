import 'package:customer/Application/Staff/staff_cubit.dart';
import 'package:customer/Domain/Staff/staff_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStaffPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController idProofController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController wageController = TextEditingController();

  final List<String> teams = ['Team A', 'Team B', 'Team C', 'Team D', 'Team E'];
  final List<Map<String, String>> staffTypes = [
    {'value': '1', 'label': 'Manager'},
    {'value': '2', 'label': 'Chef'},
    {'value': '3', 'label': 'Designer'},
    {'value': '4', 'label': 'Delivery Agent'},
    {'value': '5', 'label': 'Catering Boy'},
    {'value': '6', 'label': 'Local Worker'},
  ];

  AddStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedTeam = teams[0];
    String selectedStaffType = staffTypes[1]['value']!; // default 'Chef'

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Staff"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocConsumer<StaffCubit, StaffState>(
        listener: (context, state) {
          state.isFailureOrSuccess.fold(
            () {},
            (either) => either.fold((failure) {}, (r) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Staff submitted successfully')),
              );
            }),
          );
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildInput(nameController, "Full Name", Icons.person),
                    _buildInput(addressController, "Address", Icons.home),
                    _buildInput(mobileController, "Mobile Number", Icons.phone),
                    _buildInput(idProofController, "ID Proof", Icons.badge),
                    _buildInput(emailController, "Email", Icons.email),
                    _buildInput(
                      passwordController,
                      "Password",
                      Icons.lock,
                      obscure: true,
                    ),
                    _buildInput(upiController, "UPI ID", Icons.payment),
                    _buildInput(wageController, "Wage (₹)", Icons.money),

                    const SizedBox(height: 12),
                    _buildDropdown<String>(
                      title: "Assign to Team",
                      icon: Icons.group,
                      items: teams,
                      value: selectedTeam,
                      onChanged: (val) => selectedTeam = val!,
                    ),
                    const SizedBox(height: 12),
                    _buildDropdown<String>(
                      title: "Staff Type",
                      icon: Icons.work_outline,
                      items: staffTypes.map((e) => e['label']!).toList(),
                      value:
                          staffTypes.firstWhere(
                            (e) => e['value'] == selectedStaffType,
                          )['label']!,
                      onChanged:
                          (val) =>
                              selectedStaffType =
                                  staffTypes.firstWhere(
                                    (e) => e['label'] == val,
                                  )['value']!,
                    ),

                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<StaffCubit>().submitFeedback(
                            Staff(
                              name: nameController.text,
                              address: addressController.text,
                              mobNo: mobileController.text,
                              idProof: idProofController.text,
                              emailIdStaff: emailController.text,
                              password: passwordController.text,
                              upi: upiController.text,
                              wage: double.parse(wageController.text),
                              assignedTo: selectedTeam,
                              staffType: selectedStaffType,
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Add Staff",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: (val) => val == null || val.isEmpty ? "Enter $label" : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String title,
    required IconData icon,
    required List<T> items,
    required T value,
    required void Function(T?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: title,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          onChanged: onChanged,
          items:
              items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(item.toString()),
                );
              }).toList(),
        ),
      ),
    );
  }
}
