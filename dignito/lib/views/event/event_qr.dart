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
class EventQr extends StatelessWidget {
  const EventQr({super.key});

  @override
  Widget build(BuildContext context) {
    final Eventcontroller eventctrl = Get.put(Eventcontroller());
    final AuthController authctrl = Get.put(AuthController());

    return WillPopScope(
      onWillPop: () async {
        authctrl.verifyLogout();
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: CustomColors.DigBlack,
        //   title: const Text('Event QR Scanner'), // Optional title
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.logout),
        //       onPressed: () {
        //         // Handle logout functionality
        //         // authctrl.verifyLogout();
        //       },
        //     ),
        //   ],
        //   elevation: 0, // Removes the shadow under the AppBar
        // ),
        backgroundColor: CustomColors.DigBlack,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Logo at the top center
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0), // Space between logo and scanner
                        child: Image.asset(
                          'assets/logo.png', // Path to your logo image
                          height: 150, // Adjust height as needed
                        ),
                      ),
                      Container(
                        height: 300.0, // Height for the scanner
                        width: 300.0, // Width for the scanner
                        decoration: BoxDecoration(
                          border: Border.all(color: CustomColors.regText, width: 3.0), // Border color and width
                          borderRadius: BorderRadius.circular(8.0), // Rounded corners
                          color: Colors.transparent, // Transparent background
                        ),
                        clipBehavior: Clip.antiAlias, // Ensure the child is clipped to the rounded corners
                        child: QRView(
                          key: eventctrl.qrKey,
                          onQRViewCreated: (QRViewController controller) {
                            eventctrl.qrViewController = controller;
                            controller.scannedDataStream.listen((scanData) {
                              eventctrl.onQRCodeScanned(scanData);
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 56), // Space between scanner and input field
                      // Participant ID Input Field
                        InputField(
                          labelText: 'Participant ID',
                          icon: Icons.person,
                          initialValue: '',
                          onPressedCallback: eventctrl.clearErrorMsg,
                          readOnly: false,
                          controller: eventctrl.gatewayIdctrl,
                        ),
                      SizedBox(
                          height: constraints.maxHeight *
                              Constants.sizedBoxHeight,
                        ),
                        // Continue Button
                        button(
                          'Continue',
                          eventctrl.eventDetailsPage,
                          CustomColors.regText,
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
