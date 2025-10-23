import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationEmployerPage extends StatefulWidget {
  const RegistrationEmployerPage({super.key});

  @override
  State<RegistrationEmployerPage> createState() => _RegistrationEmployerPageState();
}

class _RegistrationEmployerPageState extends State<RegistrationEmployerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('Employer Registration', style: TextStyle(fontWeight: FontWeight.bold) ),
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
                // const SizedBox(height: 16),
                // const Text( "DockWalker", style: TextStyle( fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white ) ),
                const SizedBox(height: 32),
                // const Text( "Premium Yacht Industry Jobs", style: TextStyle( fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white ) ),
                const SizedBox(height: 32),
                const Text( "Employer Registration", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white ) ),
                const SizedBox(height: 16),

                // Employer Section
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Email input
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Company Email",
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(32),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password input
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password input
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
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
                            onPressed: () { },
                            icon: Icon(Icons.person_add, size: 18 ),
                            label: const Text( "Register", style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold ), ),
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
