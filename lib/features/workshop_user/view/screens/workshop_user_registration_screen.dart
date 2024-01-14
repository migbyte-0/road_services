import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constants/constants_exports.dart';
import '../../../../core/shared/shared_exports.dart';
import '../controller/workshop_user_controller.dart';
import '../../data/models/workshop_user_model.dart';
import '../validators/validation_util.dart';
import 'workshop_user_login_screen.dart';




class  WorkShopUserRegistrationScreen extends StatefulWidget {
  const  WorkShopUserRegistrationScreen({super.key});

  @override
  State< WorkShopUserRegistrationScreen> createState() => _WorkShopUserRegistrationScreenState();
}

class _WorkShopUserRegistrationScreenState extends State< WorkShopUserRegistrationScreen> {

  final  WorkShopUserController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

    final RxBool _obscurePassword = true.obs;
    final RxBool _obscureConfirmPassword = true.obs;


  void showSnackbar(String message) {
    Get.snackbar(
      AppTexts.error,
      message,
      backgroundColor: Colors.white,
      colorText: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }

  void registerUser() {
    if (_formKey.currentState!.validate()) {
      final userModel =  WorkShopUserModel(
        id: controller.getCurrentUserId(),
        email: emailController.text,
        password: passwordController.text,
      );

      Get.dialog(const Center(
        child: AppLoading()));
      controller.registerWorkShopUser(userModel).then((result) {
        Get.back();
        result.fold(
          (failure) => showSnackbar(AppTexts.registerationFailed),
          (_) => _showSuccessDialog(context),
        );
      }).catchError((error) {
        Get.back();
        showSnackbar(AppTexts.registerationFailed);
      });
    } else {
      showSnackbar(AppTexts.fieldsEmpty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.roadServicesSecondaryColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: AppColors.roadServicesPrimaryColor,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GradientIcon(
                            myChild: LottieBuilder.asset('lib/assets/jsons/road_services_user.json', repeat: false,), 
                          firstGradientColor: AppColors.workShopThirdColor, secondGradientColor: AppColors.workShopFourthColor,),
                         
                          CustomTextField(
                            controller: emailController,
                            hintText: AppTexts.emailHint,
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: ValidationUtil.validateEmail,
                           onClear: () => emailController.clear(),

                          ),
                          const SizedBox (height: 20),
                            Obx(() => CustomTextField(
      controller: passwordController,
      hintText: AppTexts.password,
      prefixIcon: Icons.lock,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscurePassword.value, // Use the value of RxBool
      validator: (value) => ValidationUtil.validatePassword(value),
      onToggleObscureText: () => _obscurePassword.value = !_obscurePassword.value,
    )),
                          const SizedBox(height: 20),
                        Obx(() => CustomTextField(
  controller: confirmPasswordController,
  hintText: AppTexts.confirmPasswordHint,
  prefixIcon: Icons.lock,
  obscureText: _obscureConfirmPassword.value,
  validator: (value) => ValidationUtil.validateConfirmPassword(value, passwordController.text),
  onToggleObscureText: () => _obscureConfirmPassword.value = !_obscureConfirmPassword.value,
)
,),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: registerUser,
                            child: const Text(AppTexts.registerButton),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ClipPath(
                clipper: DiagonalPathClipperTwo(),
                child: Container(height: 60, color: AppColors.roadServicesSecondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        title: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        
          children: [
            Text(AppTexts.accountCreated, textAlign: TextAlign.center,),
            SizedBox(width: 4,),
            AppDoneIcon()
          ],
        ),
        content: const Text(AppTexts.accountCreatedContent, textAlign: TextAlign.center,),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.to(() => const  WorkShopUserLoginScreen(),
               transition: Transition.fade,
                duration: const Duration(milliseconds: 500)
      );
  }          ,  child: const Text(AppTexts.continueButton, textAlign: TextAlign.center,style: TextStyle(fontSize: 22),),

  )
      ], 
            
          ),barrierDismissible: false
        
      
    );
  }
}
