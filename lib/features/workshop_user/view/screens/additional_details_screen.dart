import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_servoces/core/constants/app_text.dart';
import 'package:road_servoces/core/shared/shared_exports.dart';
import 'package:road_servoces/features/workshop_user/view/screens/workshop_main_screen.dart';
import '../../../../core/constants/constants_exports.dart';
import '../controller/workshop_user_controller.dart';
import '../validators/validation_util.dart';


class WorkShopUserAdditionalDetailsScreen extends StatelessWidget {
  const WorkShopUserAdditionalDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final WorkShopUserController controller = Get.find();

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController workshopNameController =
        TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

void updateDetails() async {
  if (_formKey.currentState!.validate()) {
    // Form is valid
    String currentUserId = controller.getCurrentUserId();

    await controller.updateWorkShopUserDetails(
      currentUserId,
      usernameController.text,
      phoneNumberController.text,
      workshopNameController.text,
      locationController.text,
    );

    // Show success message
    Get.snackbar(
      AppTexts.done, // Title
      
     AppTexts.accountDetailsUpdated, // Message
      snackPosition: SnackPosition.TOP, // Position of the snack bar
      backgroundColor: Colors.white, // Background color
      colorText: Colors.green, // Text color
      titleText: const AppDoneIcon());
    

    // Navigate to the next screen
    Get.to(() => const WorkshopMainScreen());

  } else {
    // Form is not valid
    // Show error message
    Get.snackbar(
      AppTexts.error, // Title
       AppTexts.fieldsEmpty, // Message
      snackPosition: SnackPosition.TOP, // Position of the snack bar
      backgroundColor: Colors.white, // Background color
      colorText: Colors.red, // Text color
    );
  }
}



    return Scaffold(
      body: Stack(
        children: [
          const LoginBackground(
            firstColor:  AppColors.workShopThirdColor, 
          secondColor: AppColors.workShopPrimaryColor,
           thirdColor: AppColors.workShopSecondaryColor,
           firstHeight: 770, 
           secondHeight:720, 
           thirdHeight: 750),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                key: _formKey, // Assign the GlobalKey to the Form
                  child: SingleChildScrollView(
                    child: Column(mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppTexts.bothUserDetails, style: Styles.style20White,),
                         const SizedBox(height: 30),
                         CustomTextField(
                        controller:phoneNumberController, 
                        hintText: AppTexts.phoneNumber,
                        prefixIcon: Icons.phone,
                        maxLength: 9,
                        keyboardType: TextInputType.phone,
                        onClear: () => phoneNumberController.clear(),
                         validator: (value) => ValidationUtil.validatePhoneNumber(value),

                          ),                   
                           const SizedBox(height: 20),
                        CustomTextField(
                        controller:usernameController, 
                        hintText: AppTexts.userName,
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.text,
                        onClear: () => usernameController.clear(),
                        validator: (value) => ValidationUtil.validateUsername(value),

                          ),                   
                           const SizedBox(height: 20),
                    
                     
                    
                             CustomTextField(
                        controller:workshopNameController, 
                        hintText: AppTexts.workshopNameHint,
                        prefixIcon: Icons.build,
                        keyboardType: TextInputType.text,
                        onClear: () => workshopNameController.clear(),
                         validator: (value) => ValidationUtil.validateWorkshopName(value),

                          ),                 
                             const SizedBox(height: 20),
                    
                               CustomTextField(
                        controller:locationController, 
                        hintText: AppTexts.locationHint,
                        prefixIcon: Icons.location_pin,
                        keyboardType: TextInputType.streetAddress,
                        onClear: () => locationController.clear(),
                        validator: (value) => ValidationUtil.validateLocation(value),

                          ),
                     const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: updateDetails,
                          child: const Text(AppTexts.enter, style: Styles.style22,), 
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
