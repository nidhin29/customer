import 'dart:io';
import 'package:customer/Application/Service/service_cubit.dart';
import 'package:customer/Domain/Service/_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddServicePage extends StatelessWidget {
  AddServicePage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<File?> _licenseFile = ValueNotifier<File?>(null);
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final ValueNotifier<DateTime?> _selectedDate = ValueNotifier(null);

  void _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _selectedDate.value = picked;
    }
  }

  void _pickLicenseFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null && result.files.single.path != null) {
      _licenseFile.value = File(result.files.single.path!);
    }
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<ServiceCubit>(context).submitFeedback(
        Service(
          rate: _rateController.text,
          items: _itemController.text,
          description: _descController.text,
          dateTime: _selectedDate.value!,
          image: _licenseFile.value!,
        ),
      );
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Service")),
      body: BlocConsumer<ServiceCubit, ServiceState>(
        listener: (context, state) {
          state.isFailureOrSuccess.fold(
            () {},
            (either) => either.fold((failure) {}, (r) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Service submitted successfully')),
              );
            }),
          );
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _rateController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration("Rate"),
                            validator:
                                (val) => val!.isEmpty ? "Enter rate" : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _itemController,
                            decoration: _inputDecoration("Items"),
                            validator:
                                (val) => val!.isEmpty ? "Enter items" : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _descController,
                            maxLines: 3,
                            decoration: _inputDecoration("Description"),
                            validator:
                                (val) =>
                                    val!.isEmpty ? "Enter description" : null,
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 16),
                          ValueListenableBuilder<DateTime?>(
                            valueListenable: _selectedDate,
                            builder:
                                (_, date, __) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      date == null
                                          ? "No date selected"
                                          : "Selected: ${date.toLocal().toString().split(" ")[0]}",
                                    ),
                                    TextButton.icon(
                                      onPressed: () => _pickDate(context),
                                      icon: const Icon(Icons.calendar_today),
                                      label: const Text("Pick Date"),
                                    ),
                                  ],
                                ),
                          ),
                          const SizedBox(height: 16),
                          ValueListenableBuilder<File?>(
                            valueListenable: _licenseFile,
                            builder:
                                (_, file, __) => Column(
                                  children: [
                                    if (file != null)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(file, height: 120),
                                      ),
                                    const SizedBox(height: 8),
                                    OutlinedButton.icon(
                                      onPressed: () => _pickLicenseFile(),
                                      icon: const Icon(Icons.upload_file),
                                      label: const Text("Upload File"),
                                    ),
                                  ],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _submit(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
