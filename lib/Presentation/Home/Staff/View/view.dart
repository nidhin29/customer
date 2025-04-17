import 'package:customer/Presentation/Home/Staff/View/details.dart';
import 'package:flutter/material.dart';

class ViewStaffPage extends StatelessWidget {
  const ViewStaffPage({super.key});

  final List<String> teamNames = const [
    'Team A',
    'Team B',
    'Team C',
    'Team D',
    'Team E',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Staff Teams'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: teamNames.length,
        itemBuilder: (context, index) {
          final team = teamNames[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text(team),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StaffDetailsPage(teamName: team),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
