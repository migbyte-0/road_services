import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:road_servoces/core/constants/constants_exports.dart';
import 'package:road_servoces/core/shared/shared_exports.dart';
import '../controller/workshop_user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WorkShopUserController controller = Get.find();

    return Scaffold(
      body: Stack(
        children: [
         const GradientContainer(myHeight: 640,
          firstGradientColor: AppColors.workShopPrimaryColor,
          secondGradientColor: AppColors.workShopSecondaryColor,
          myContainerBorderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),  
            bottomRight: Radius.circular(20)

          ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [                              
                  CircleAvatar(
                    backgroundColor: Colors.white,maxRadius: 50,
                    child: GradientIcon(
                      firstGradientColor: AppColors.workShopPrimaryColor,
                      secondGradientColor: AppColors.workShopSecondaryColor,
                      myChild: LottieBuilder.asset('lib/assets/jsons/user.json',
                       height: 80,
                       width: 80,
                       repeat: false,)),
                  ),
                  const SizedBox(height: 30),

                  // Observe changes in userDetails
                  Obx(() {
                    final user = controller.userDetails.value;
                    return Card(
                      child: ListTile(
                        subtitle: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400)
                        ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [ 
                              Text(" ${AppTexts.userName} : ${user.name}", style: Styles.style16,),
                              Text("${AppTexts.phoneNumber} : ${user.phoneNumber}",style: Styles.style16,),
                              Text("${AppTexts.email} : ${user.email}",style: Styles.style16,),
                              Text("${AppTexts.workshopNameHint} : ${user.workshopName}",style: Styles.style16,),
                              Text("${AppTexts.locationHint} : ${user.location}",style: Styles.style16,),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 80,),
                  ElevatedButton(
                    onPressed: () {
                      controller.logout();
                      // Navigate to login screen or perform other actions on logout
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppTexts.logout), SizedBox(width: 10),
                        Icon(Icons.logout)]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
