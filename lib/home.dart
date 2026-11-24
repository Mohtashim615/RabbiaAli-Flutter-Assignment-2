
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final String studentId;

  const Home({
    super.key,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Hello, $studentId'),

        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),

            onPressed: () {
              showDialog(
                context: context,

                builder: (dialogContext) {
                  return AlertDialog(

                    title: const Text('Sign Out'),

                    content: const Text(
                      'Do you want to sign out of UniLibrary?',
                    ),

                    actions: [

                      // Cancel Button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },

                        child: const Text('Cancel'),
                      ),

                      // Sign Out Button
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);

                          Navigator.pop(
                            context,
                            'Signed out of UniLibrary',
                          );
                        },

                        child: const Text('Sign Out'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: Center(
        child: Text(
          'You are signed in to UniLibrary',

          style: TextStyle(
            fontSize: 18,
            color: Colors.teal.shade800,
          ),
        ),
      ),
    );
  }
}
