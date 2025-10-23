import 'package:dockwalker/controllers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final AuthController _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset( 'assets/bg2.jpg', fit: BoxFit.cover ),
          // Container(color: Color.fromARGB(200, 0, 0, 0)),
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
                // const SizedBox(height: 2),
                // const Text( "Dock Walker", style: TextStyle( fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white ) ),
                // const SizedBox(height: 2),
                const SizedBox(height: 48),
                // const Text( "Premium Yacht Industry Jobs", style: TextStyle( fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white ) ),
                // const SizedBox(height: 32),

                // Employer Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( "I want to find...", style: TextStyle( color: Colors.white ) ),
                      const SizedBox(height: 8),
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
                          onPressed: () { _controller.gotEmployerLogin(); },
                          icon: Icon(Icons.people, size: 18 ),
                          label: const Text( "Crew", style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold ), ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text( "Post job and hire qualified yacht crew.", style: TextStyle( color: Colors.white ) ),
                      const SizedBox(height: 32),
                    ],
                  )
                ),

                // Employer Section
                // Candidate Section
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( "I want to find...", style: TextStyle( color: Colors.white ) ),
                        const SizedBox(height: 8),
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
                            onPressed: () { _controller.gotoCandidateLogin(); },
                            icon: Icon(Icons.people, size: 18 ),
                            label: const Text( "Jobs", style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold ), ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text( "Brows and apply for yacht positions.", style: TextStyle( color: Colors.white ) ),
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
