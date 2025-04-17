import 'package:customer/Application/loggedin/loggedin_cubit.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/Presentation/Auth/signin.dart';
import 'package:customer/Presentation/Earnings/earning.dart';
import 'package:customer/Presentation/Feedback/feedback.dart';
import 'package:customer/Presentation/Home/Bookings/booking.dart';
import 'package:customer/Presentation/Home/Service/service.dart';
import 'package:customer/Presentation/Home/Service/view_service.dart';
import 'package:customer/Presentation/Home/Staff/View/details.dart';
import 'package:customer/Presentation/Home/Staff/View/view.dart';
import 'package:customer/Presentation/Home/Staff/staff.dart';
import 'package:customer/Presentation/Profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final UserType userType;
  const HomePage({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final staff = TokenManager.instance.stafftype;
    List<_Feature> features;

    if (userType == UserType.owner) {
      features = [
        _Feature("Add Services", Icons.add_business, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddServicePage()),
          );
        }),
        _Feature("View Bookings", Icons.event_note, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewBookingsPage()),
          );
        }),
        _Feature("Feedback", Icons.feedback_outlined, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeedbackPage()),
          );
        }),
        _Feature("Add Staff", Icons.person_add_alt_1, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStaffPage()),
          );
        }),
        _Feature("View Staff", Icons.people_outline, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewStaffPage()),
          );
        }),
      ];
    } else if (userType == UserType.customer) {
      features = [
        _Feature("View Profile", Icons.person, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        }),
        _Feature("View Services", Icons.miscellaneous_services_outlined, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewServicesPage()),
          );
        }),
        _Feature("My Bookings", Icons.calendar_today_outlined, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewBookingsPage()),
          );
        }),
      ];
    } else {
      if (staff == '1') {
        features = [
          _Feature("View Bookings", Icons.event_note, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewBookingsPage()),
            );
          }),

          _Feature("Earinings", Icons.group, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EarningsPage()),
            );
          }),
        ];
      } else {
        features = [
          _Feature("View Bookings", Icons.event_note, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewBookingsPage()),
            );
          }),
        ];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          userType == UserType.owner
              ? "Owner"
              : userType == UserType.customer
              ? "Customer"
              : StaffType.fromCode(staff!).name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE3F2FD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
            children:
                features
                    .map((feature) => _buildCard(context, feature))
                    .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, _Feature feature) {
    return InkWell(
      onTap: feature.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFBBDEFB), Color(0xFF90CAF9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(feature.icon, size: 40, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                feature.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Feature {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  _Feature(this.label, this.icon, this.onTap);
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<LoggedinCubit>(context).deleteEmail();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
  );
}
