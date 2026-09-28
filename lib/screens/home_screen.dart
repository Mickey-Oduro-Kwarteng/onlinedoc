import 'package:flutter/material.dart';
 
// ─────────────────────────────────────────────
// MODEL CLASS: a plain Dart object that holds
// the data describing one doctor.
// ─────────────────────────────────────────────
class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final bool isOnline;
 
  const Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.isOnline,
  });
}
 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  // Our "database" — a hard-coded list for this lab.
  // In ENCE 216 Part 2 we will replace this with a real API call.
  static const List<Doctor> doctors = [
    Doctor(
        name: 'Dr. Ama Mensah',
        specialty: 'General Practitioner',
        rating: 4.9,
        isOnline: true),
    Doctor(
        name: 'Dr. Kofi Asante',
        specialty: 'Cardiologist',
        rating: 4.8,
        isOnline: true),
    Doctor(
        name: 'Dr. Efua Boateng',
        specialty: 'Pediatrician',
        rating: 4.7,
        isOnline: false),
    Doctor(
        name: 'Dr. Yaw Owusu',
        specialty: 'Dermatologist',
        rating: 4.6,
        isOnline: true),
    Doctor(
        name: 'Dr. Akosua Darko',
        specialty: 'Psychiatrist',
        rating: 4.9,
        isOnline: false),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Doctors'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // hides the back arrow —
        // remember, we CLEARED the stack after login, so there is
        // nothing to go back to anyway.
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Logging out = wipe the stack and return to login.
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Tap a doctor to start a consultation',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Expanded(
            // ListView.builder only builds the items currently
            // visible on screen — efficient even for 10,000 items.
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.teal.shade100,
                      child: const Icon(Icons.person,
                          color: Colors.teal, size: 30),
                    ),
                    title: Text(
                      doctor.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor.specialty),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                            Text(' ${doctor.rating}'),
                            const SizedBox(width: 12),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: doctor.isOnline
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                            Text(
                              doctor.isOnline ? ' Online' : ' Offline',
                              style: TextStyle(
                                fontSize: 12,
                                color: doctor.isOnline
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.chat_bubble_outline,
                        color: Colors.teal),
                    onTap: () {
                      // ─────────────────────────────────────
                      // PASSING DATA TO THE NEXT SCREEN:
                      // the 'arguments' parameter can carry
                      // ANY Dart object — here, a Doctor.
                      // ─────────────────────────────────────
                      Navigator.pushNamed(
                        context,
                        '/chat',
                        arguments: doctor,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
