import 'package:dockwalker/controllers/auth/registration_candidate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationCandidatePage extends StatefulWidget {
  const RegistrationCandidatePage({super.key});

  @override
  State<RegistrationCandidatePage> createState() => _RegistrationCandidatePageState();
}

class _RegistrationCandidatePageState extends State<RegistrationCandidatePage> {

  final RegistrationCandidateController _controller = Get.put(RegistrationCandidateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('Crew Registration', style: TextStyle(fontWeight: FontWeight.bold) ),
        titleSpacing: 0,
        actions: [
          IconButton(onPressed: () { }, icon: Icon(Icons.info_outline))
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset( 'assets/bg2.jpg', fit: BoxFit.cover ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.8),
                  Colors.black.withValues(alpha: .7),
                  Colors.black.withValues(alpha: .7),
                ],
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logo_auth.png', width: 196, color: Colors.white.withValues(alpha: 1.0), colorBlendMode: BlendMode.srcATop ),
                const SizedBox(height: 32),
                // const Text( "DockWalker", style: TextStyle( fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white ) ),
                // const SizedBox(height: 8),
                // const Text( "Premium Yacht Industry Jobs", style: TextStyle( fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white ) ),
                // const SizedBox(height: 16),
                const Text( "Crew Registration", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white ) ),
                const SizedBox(height: 32),

                // Candidate Section
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    //
                    child: Form(
                      key: _controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Email input
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _controller.emailController,
                              validator: _controller.emailValidation,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Mobile input
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _controller.mobileController,
                              validator: _controller.mobileValidation,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Mobile",
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password input
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _controller.passwordController,
                              validator: _controller.passwordValidation,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password input
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _controller.passwordCController,
                              validator: _controller.passwordValidation,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(color: Colors.red, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white, width: 1),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              onPressed: () { _controller.registerNewCandidate(); },
                              // icon: Icon(Icons.person_add, size: 18 ),
                              // label: const Text( "Register", style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold ), ),
                              icon: Obx(()=> _controller.homeService.urlloading.value == true ? Text("") : Icon(Icons.person_add, size: 18, color: Colors.white ) ),
                              label: Obx(()=> _controller.homeService.urlloading.value == true ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white) ) : Text( "Register", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white ) ))
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text( "Already have account?", style: TextStyle( color: Colors.white, fontSize: 14 ) ),
                              InkWell( onTap: () { Get.back(); }, child: Text( "Login", style: TextStyle( color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold ) )),
                            ],
                          ),
                        ],
                      ),
                    )
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
