import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../controllers/EventController.dart';
import '../../components/input_field.dart';
import '../../components/button.dart';
import '../../constants.dart';
import '../../controllers/authController.dart';
import '../../components/input_field.dart';
import '../../custom_colors.dart';
import '../../models/ParticipantDetails.dart';
import '../../components/eventTextField.dart'; 

class EventDetails extends StatelessWidget {
  final Participantdetails participantdetails;
  const EventDetails({super.key, required this.participantdetails});

  @override
  Widget build(BuildContext context) {
    final Eventcontroller eventctrl = Get.put(Eventcontroller());
    final AuthController authctrl = Get.put(AuthController());

    // TextEditingController for each text field
    final TextEditingController eventNameController = TextEditingController();
    final TextEditingController institutionNameController = TextEditingController();
    final TextEditingController participantNameController = TextEditingController();
    final TextEditingController allocatedNumberController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        authctrl.verifyLogout();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.backgroundColor,
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Dignito 2K24',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
          TextButton.icon(
            onPressed: () {
              // Handle logout functionality
            },
            icon: const Icon(Icons.logout, color: Colors.black), // Change icon color as needed
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              backgroundColor: CustomColors.DigPink.withOpacity(0.5), // Optional background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
          ),
        ],

        ),
        backgroundColor: CustomColors.backgroundColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.1), // Space between AppBar and Card
                      Card(
                        color: CustomColors.basicBlack,
                        elevation: 8, // Card shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Use EventText for Event Name
                              const EventText(
                                labelText: 'Event Name',
                                icon: Icons.event,
                                initialValue: "afadfadf",
                              ),
                              SizedBox(height: constraints.maxHeight * 0.03),

                              // Use EventText for Institution Name
                              EventText(
                                labelText: 'Institution Name',
                                icon: Icons.account_balance,
                                initialValue: participantdetails.iname,
                              ),
                              SizedBox(height: constraints.maxHeight * 0.03),

                              // Use EventText for Participant Name
                              EventText(
                                labelText: 'Participant Name',
                                icon: Icons.person,
                                initialValue: participantdetails.cname,
                              ),
                              SizedBox(height: constraints.maxHeight * 0.03),

                              // Use EventText for Allocated Number
                              EventText(
                                labelText: 'Allocated Number',
                                icon: Icons.confirmation_number,
                                initialValue: '',
                                keyboardType: TextInputType.number,
                                readOnly: false,
                                controller: allocatedNumberController,
                                 // Numeric keyboard
                              ),
                              SizedBox(height: constraints.maxHeight * 0.03),

                              // Verify Button
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    eventctrl.allocateNumber();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.backgroundColor, // Button color
                                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), // Rounded button
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold, // Bold button text
                                    ),
                                  ),
                                  child: const Text(
                                    'Verify',
                                    style: TextStyle(color: Colors.black), // White text color
                                  ),
                                ),
                              ),


                              SizedBox(height: constraints.maxHeight * 0.03), // Space below the button
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
