import 'package:dockwalker/controllers/auth/login_condidate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginCandidatePage extends StatefulWidget {
  const LoginCandidatePage({super.key});

  @override
  State<LoginCandidatePage> createState() => _LoginCandidatePageState();
}

class _LoginCandidatePageState extends State<LoginCandidatePage> {

  final LoginCandidateController _controller = Get.put(LoginCandidateController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white, // default color for Text
          displayColor: Colors.white, // default color for headings
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text('Crew Login', style: TextStyle(fontWeight: FontWeight.bold) ),
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
            // Container(color: Color.fromARGB(200, 0, 0, 0)),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/logo_auth.png', width: 196, color: Colors.white.withValues(alpha: 1.0), colorBlendMode: BlendMode.srcATop ),
                  const SizedBox(height: 64),

                  // Candidate Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 32),
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
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: const TextStyle( color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 2, color: Colors.white),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(width: 1, color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide(width: 2.0, color: Colors.red),
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
                              obscureText: true,
                              validator: _controller.passwordValidation,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 2, color: Colors.white),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text( "Forget your password?", style: TextStyle(fontSize: 14 ) ),
                              InkWell(onTap: () { _controller.gotoResetPassword(); }, child: Text( "Reset Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold ) )),
                            ],
                          ),

                          SizedBox(height: 32),
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith( visualDensity: VisualDensity(horizontal: -4, vertical: -4) ),
                                child: Checkbox(
                                  value: _controller.rememberMe.value,
                                  activeColor: Colors.white,
                                  checkColor: Colors.black,
                                  onChanged: (value) {
                                    setState(() { _controller.rememberMe.value = value ?? false; });
                                  },
                                  side: const BorderSide(color: Colors.white, width: 1.5),
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // ✅ tighter touch area
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(child: Text( "Remember my email and password in future.", style: TextStyle(color: Colors.white, fontSize: 14), ),)
                            ],
                          ),
                          const SizedBox(height: 32),

                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(width: 1, color: Colors.white),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                onPressed: () { _controller.gotoHomepage(); },
                                icon: Obx(()=> _controller.homeService.urlloading.value == true ? Text("") : Icon(Icons.login, size: 18, color: Colors.white ) ),
                                label: Obx(()=> _controller.homeService.urlloading.value == true ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white) ) : Text( "Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white ) ))
                            ),
                          ),

                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text( "Don't have account?", style: TextStyle(fontSize: 14 ) ),
                              InkWell( onTap: () { _controller.gotoCandidateRegistration(); }, child: Text( "Create an account", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold ) )),
                            ],
                          ),
                        ],
                      )
                    )
                  ),

                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
