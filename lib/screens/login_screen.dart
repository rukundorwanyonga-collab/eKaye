import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/app_provider.dart";
import "wizard_screen.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectedRole = "Umwanditsi"; // Role from provider
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4FD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF64B5F6), Color(0xFF42A5F5)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      "iKayi+",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Itsinda ry'Imari",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: CustomPaint(painter: _LandscapePainter()),
                    ),
                  ],
                ),
              ),

              // Login Form
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF64B5F6).withValues(alpha: 0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Injira cyangwa Iyandikishe",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF42A5F5),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Role Selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildRoleButton("Umwanditsi", Icons.edit),
                          _buildRoleButton("Perezida", Icons.leaderboard),
                          _buildRoleButton("Umubitsi", Icons.account_balance),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Error Message
                      if (_errorMessage.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error, color: Colors.red, size: 16),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  _errorMessage,
                                  style: const TextStyle(color: Colors.red, fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_errorMessage.isNotEmpty) const SizedBox(height: 10),

                      // Phone
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon: const Icon(Icons.phone, color: Color(0xFF42A5F5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),

                      // Password
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Ijambo Banga",
                          prefixIcon: const Icon(Icons.lock, color: Color(0xFF42A5F5)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final result = Provider.of<AppProvider>(context, listen: false)
                                    .register(_phoneController.text, _passwordController.text);
                                if (result == "Success") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WizardScreen()),
                                  );
                                } else {
                                  setState(() {
                                    _errorMessage = result;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF42A5F5),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Color(0xFF42A5F5)),
                                ),
                              ),
                              child: const Text(
                                "Kwiyandikisha",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final result = Provider.of<AppProvider>(context, listen: false)
                                    .login(_phoneController.text, _passwordController.text);
                                if (result == "Success") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WizardScreen()),
                                  );
                                } else {
                                  setState(() {
                                    _errorMessage = result;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF42A5F5),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Kwinjira",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(String role, IconData icon) {
    bool selected = _selectedRole == role;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF42A5F5) : const Color(0xFFE8F4FD),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? Colors.white : const Color(0xFF42A5F5), size: 18),
            const SizedBox(height: 4),
            Text(
              role,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : const Color(0xFF42A5F5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()..color = Colors.yellow.withValues(alpha: 0.7);
    canvas.drawCircle(Offset(size.width - 30, 20), 14, sunPaint);

    final mountainPaint = Paint()..color = Colors.white.withValues(alpha: 0.25);
    final mountainPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.25, size.height * 0.35)
      ..lineTo(size.width * 0.45, size.height)
      ..lineTo(size.width * 0.65, size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(mountainPath, mountainPaint);

    final treePaint = Paint()..color = Colors.green.withValues(alpha: 0.4);
    canvas.drawCircle(Offset(size.width * 0.35, size.height - 12), 8, treePaint);
    canvas.drawCircle(Offset(size.width * 0.55, size.height - 10), 9, treePaint);
    canvas.drawCircle(Offset(size.width * 0.75, size.height - 8), 7, treePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
