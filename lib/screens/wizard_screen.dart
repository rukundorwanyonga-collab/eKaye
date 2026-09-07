import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/app_provider.dart";
import "dashboard_screen.dart";

class WizardScreen extends StatefulWidget {
  const WizardScreen({super.key});

  @override
  _WizardScreenState createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  int _currentStep = 0;

  // Controllers
  final _izinaItsindaController = TextEditingController();
  final _umubareController = TextEditingController();
  final _umusanzuController = TextEditingController();
  final _ingobokaController = TextEditingController();
  final _amandeController = TextEditingController();

  // Selected values
  double _ijanisha = 5.0;
  String _umutango = "Buri Kwezi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F4FD),
      body: SafeArea(
        child: Column(
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
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Igenabihe ry'Itsinda",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Intambwe ${_currentStep + 1}/5",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentStep + 1) / 5,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    color: Colors.white,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildStepContent(),
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF42A5F5),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Ishize"),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentStep < 4) {
                        setState(() {
                          _currentStep++;
                        });
                      } else {
                        // BIKS DATA MURI PROVIDER
                        final provider = Provider.of<AppProvider>(context, listen: false);
                        provider.updateSettings(
                          groupName: _izinaItsindaController.text,
                          memberCount: int.tryParse(_umubareController.text) ?? 0,
                          ijanisha: _ijanisha,
                          umutango: _umutango,
                          umusanzu: double.tryParse(_umusanzuController.text) ?? 2000,
                          ingoboka: double.tryParse(_ingobokaController.text) ?? 200,
                          amande: double.tryParse(_amandeController.text) ?? 500,
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const DashboardScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF42A5F5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(_currentStep < 4 ? "Ibikurikira" : "Kubika"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1();
      case 1:
        return _buildStep2();
      case 2:
        return _buildStep3();
      case 3:
        return _buildStep4();
      case 4:
        return _buildStep5();
      default:
        return _buildStep1();
    }
  }

  // STEP 1: Group name + Members count
  Widget _buildStep1() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64B5F6).withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Izina ry'Itsinda",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF42A5F5)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _izinaItsindaController,
            decoration: InputDecoration(
              labelText: "Andika izina ry'itsinda",
              prefixIcon: const Icon(Icons.group, color: Color(0xFF42A5F5)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Umubare w'Abanyamuryango",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF42A5F5)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _umubareController,
            decoration: InputDecoration(
              labelText: "Umubare",
              prefixIcon: const Icon(Icons.people, color: Color(0xFF42A5F5)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  // STEP 2: Umusanzu + Ingoboka + Amande
  Widget _buildStep2() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64B5F6).withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Imisanzu n'Ingoboka",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF42A5F5)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _umusanzuController,
            decoration: InputDecoration(
              labelText: "Umusanzu (RWF)",
              prefixIcon: const Icon(Icons.savings, color: Colors.teal),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _ingobokaController,
            decoration: InputDecoration(
              labelText: "Ingoboka (RWF)",
              prefixIcon: const Icon(Icons.volunteer_activism, color: Colors.blue),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _amandeController,
            decoration: InputDecoration(
              labelText: "Amande (RWF)",
              prefixIcon: const Icon(Icons.gavel, color: Colors.orange),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  // STEP 3: Ijanisha
  Widget _buildStep3() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64B5F6).withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ijanisha ku Nyungu",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF42A5F5)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPercentageOption(2.5),
              _buildPercentageOption(5.0),
              _buildPercentageOption(10.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageOption(double value) {
    bool selected = _ijanisha == value;
    return InkWell(
      onTap: () {
        setState(() {
          _ijanisha = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF42A5F5) : const Color(0xFFE8F4FD),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "$value%",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.white : const Color(0xFF42A5F5),
          ),
        ),
      ),
    );
  }

  // STEP 4: Umutango
  Widget _buildStep4() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64B5F6).withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Umutango",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF42A5F5)),
          ),
          const SizedBox(height: 12),
          _buildFrequencyOption("Buri Kwezi", Icons.calendar_month),
          _buildFrequencyOption("Buri Cyumweru", Icons.calendar_view_week),
        ],
      ),
    );
  }

  Widget _buildFrequencyOption(String label, IconData icon) {
    bool selected = _umutango == label;
    return InkWell(
      onTap: () {
        setState(() {
          _umutango = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF42A5F5) : const Color(0xFFE8F4FD),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.white : const Color(0xFF42A5F5), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : const Color(0xFF42A5F5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // STEP 5: Summary
  Widget _buildStep5() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64B5F6).withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Incamake y'Igenabihe",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF42A5F5)),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(Icons.group, "Izina ry'Itsinda", _izinaItsindaController.text),
          _buildSummaryRow(Icons.people, "Umubare w'Abanyamuryango", _umubareController.text),
          _buildSummaryRow(Icons.savings, "Umusanzu", "${_umusanzuController.text} RWF"),
          _buildSummaryRow(Icons.volunteer_activism, "Ingoboka", "${_ingobokaController.text} RWF"),
          _buildSummaryRow(Icons.gavel, "Amande", "${_amandeController.text} RWF"),
          _buildSummaryRow(Icons.percent, "Ijanisha", "$_ijanisha%"),
          _buildSummaryRow(Icons.calendar_month, "Umutango", _umutango),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4FD),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF42A5F5), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 12, color: Colors.black87)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF42A5F5)),
          ),
        ],
      ),
    );
  }
}
