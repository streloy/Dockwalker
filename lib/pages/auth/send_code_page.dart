import 'package:dockwalker/controllers/auth/send_code_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendCodePage extends StatefulWidget {
  const SendCodePage({super.key});

  @override
  State<SendCodePage> createState() => _SendCodePageState();
}

class _SendCodePageState extends State<SendCodePage> {

  final SendCodeController _controller = Get.put(SendCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 0, 0, 250),
        foregroundColor: Colors.white,
        title: Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold)),
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
                const Text( "Reset Password", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white ) ),
                const SizedBox(height: 32),

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
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

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
                              onPressed: () { _controller.sendResetCode(); },
                              icon: Icon(Icons.login, size: 18 ),
                              label: const Text( "Send Code", style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold ), ),
                            ),
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
