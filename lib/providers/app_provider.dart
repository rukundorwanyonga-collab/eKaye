import "package:flutter/material.dart";
import "../models/umuntu.dart";
import "../models/inguzanyo.dart";
import "../models/amateka.dart";

class AppProvider extends ChangeNotifier {
  // Accounts (phone, password, role)
  final Map<String, Map<String, String>> _accounts = {
    "0788222333": {"password": "123456", "role": "Umwanditsi"},
    "0788444555": {"password": "123456", "role": "Perezida"},
    "0788666777": {"password": "123456", "role": "Umubitsi"},
  };
  
  String _currentPhone = "";
  String _userRole = "Umwanditsi";

  // Itsinda
  String _groupName = "Itsinda Ryacu";
  double _umusanzuFatizo = 2000;
  double _ingobokaFatizo = 200;
  double _amandeFatizo = 500;
  double _ijanisha = 5.0;
  String _umutango = "Buri Kwezi";

  // Lists
  final List<Umuntu> _abantu = [];
  final List<Inguzanyo> _inguzanyo = [];
  final List<Amateka> _amateka = [];

  // Getters
  String get currentPhone => _currentPhone;
  String get userRole => _userRole;
  String get groupName => _groupName;
  double get umusanzuFatizo => _umusanzuFatizo;
  double get ingobokaFatizo => _ingobokaFatizo;
  double get amandeFatizo => _amandeFatizo;
  double get ijanisha => _ijanisha;
  String get umutango => _umutango;
  List<Umuntu> get abantu => _abantu;
  List<Inguzanyo> get inguzanyo => _inguzanyo;
  List<Amateka> get amateka => _amateka;

  // Role check
  bool get canWrite => _userRole == "Umwanditsi";
  bool get canRead => _userRole == "Perezida" || _userRole == "Umubitsi" || _userRole == "Umwanditsi";

  // Financial getters
  double get cashInBox {
    double total = 0;
    for (var m in _abantu) total += m.umusanzu;
    return total;
  }
  double get imisanzuYose {
    double total = 0;
    for (var m in _abantu) total += m.umusanzu + m.ingoboka;
    return total;
  }
  double get igikorwamari => imisanzuYose + inyunguZagabanijwe - inguzanyoZisigaye;
  double get inguzanyoZisigaye {
    double total = 0;
    for (var i in _inguzanyo) {
      if (!i.yarishyuye) total += i.inguzanyoAmafaranga;
    }
    return total;
  }
  double get inyunguZagabanijwe {
    double total = 0;
    for (var i in _inguzanyo) {
      if (i.yarishyuye) total += i.inguzanyoAmafaranga * (_ijanisha / 100);
    }
    return total;
  }
  double get ibihano {
    double total = 0;
    for (var m in _abantu) {
      if (m.ideniKUmusanzuUtatanzwe > 0) total += _amandeFatizo;
    }
    return total;
  }
  int get inguzanyoZatanzwe => _inguzanyo.length;
  int get abarengeje {
    int count = 0;
    for (var i in _inguzanyo) {
      if (!i.yarishyuye) count++;
    }
    return count;
  }

  // LOGIN - with role
  String login(String phone, String password) {
    if (phone.isEmpty) return "Andika phone number";
    if (password.isEmpty) return "Andika ijambo banga";
    if (!_accounts.containsKey(phone)) return "Nta account ifunguye! Iyandikishe";
    if (_accounts[phone]!["password"] != password) return "Ijambo banga si ryo!";
    _currentPhone = phone;
    _userRole = _accounts[phone]!["role"]!;
    notifyListeners();
    return "Success";
  }

  // REGISTER - default role Umwanditsi
  String register(String phone, String password) {
    if (phone.isEmpty) return "Andika phone number";
    if (password.isEmpty) return "Andika ijambo banga";
    if (_accounts.containsKey(phone)) return "Account ifunguye! Injira";
    _accounts[phone] = {"password": password, "role": "Umwanditsi"};
    _currentPhone = phone;
    _userRole = "Umwanditsi";
    notifyListeners();
    return "Success";
  }

  // UPDATE SETTINGS (Umwanditsi only)
  void updateSettings({
    required String groupName,
    required double umusanzu,
    required double ingoboka,
    required double amande,
    required double ijanisha,
    required String umutango, required int memberCount,
  }) {
    if (!canWrite) return;
    _groupName = groupName;
    _umusanzuFatizo = umusanzu;
    _ingobokaFatizo = ingoboka;
    _amandeFatizo = amande;
    _ijanisha = ijanisha;
    _umutango = umutango;
    notifyListeners();
  }

  // ADD UMUNTU (Umwanditsi only)
  void addUmuntu(String izina, String phone) {
    if (!canWrite) return;
    _abantu.add(Umuntu(
      id: DateTime.now().toString(),
      izina: izina,
      phone: phone,
      umusanzu: 0,
      ingoboka: 0,
      amande: 0,
      ideniKUmusanzuUtatanzwe: 0,
      igiteranyo: 0,
      itariki: DateTime.now().toString().substring(0, 10),
    ));
    _addAmateka(izina, "Umusanzu", 0, "Yongeweho mu itsinda");
    notifyListeners();
  }

  // ADD UMUSANZU (Umwanditsi only)
  void addUmusanzu(String memberId, double amount) {
    if (!canWrite) return;
    final index = _abantu.indexWhere((m) => m.id == memberId);
    if (index != -1) {
      _abantu[index].umusanzu += amount;
      if (_abantu[index].ideniKUmusanzuUtatanzwe > 0) {
        _abantu[index].ideniKUmusanzuUtatanzwe -= amount;
        if (_abantu[index].ideniKUmusanzuUtatanzwe < 0) {
          _abantu[index].ideniKUmusanzuUtatanzwe = 0;
        }
      }
      _abantu[index].igiteranyo = _abantu[index].umusanzu + _abantu[index].ingoboka;
      _addAmateka(_abantu[index].izina, "Umusanzu", amount, "Yatanze umusanzu");
      notifyListeners();
    }
  }

  // SIBA UMUSANZU (Umwanditsi only)
  void sibaUmusanzu(String memberId) {
    if (!canWrite) return;
    final index = _abantu.indexWhere((m) => m.id == memberId);
    if (index != -1) {
      _abantu[index].ideniKUmusanzuUtatanzwe += _umusanzuFatizo;
      _abantu[index].amande += _amandeFatizo;
      _addAmateka(_abantu[index].izina, "Amande", _amandeFatizo, "Yasibye umusanzu");
      notifyListeners();
    }
  }

  // ADD INGUZANYO (Umwanditsi only)
  void addInguzanyo(String izina, double amafaranga, String impamvu) {
    if (!canWrite) return;
    _inguzanyo.add(Inguzanyo(
      id: DateTime.now().toString(),
      izina: izina,
      inguzanyoAmafaranga: amafaranga,
      impamvu: impamvu,
      umwishingizi: "",
      akagari: "",
      umudugudu: "",
      itariki: DateTime.now().toString().substring(0, 10),
      itarikiNtarengwa: DateTime.now().toString().substring(0, 10),
    ));
    _addAmateka(izina, "Inguzanyo", amafaranga, impamvu);
    notifyListeners();
  }

  // KWISHYURA (Umwanditsi only)
  void kwishyuraInguzanyo(String id, double amount) {
    if (!canWrite) return;
    final index = _inguzanyo.indexWhere((i) => i.id == id);
    if (index != -1) {
      _inguzanyo[index].inguzanyoAmafaranga -= amount;
      _addAmateka(_inguzanyo[index].izina, "Kwishyura", amount, "Yishyuye inguzanyo");
      if (_inguzanyo[index].inguzanyoAmafaranga <= 0) {
        _inguzanyo[index].yarishyuye = true;
        _gabanyaInyungu();
      }
      notifyListeners();
    }
  }

  void _gabanyaInyungu() {
    double totalInyungu = inyunguZagabanijwe;
    if (_abantu.isNotEmpty && totalInyungu > 0) {
      double umugabane = totalInyungu / _abantu.length;
      for (var m in _abantu) {
        m.igiteranyo += umugabane;
      }
      _addAmateka("Itsinda ryose", "Dividend", totalInyungu, "Inyungu zagabanijwe");
    }
  }

  void _addAmateka(String izina, String ubwoko, double amafaranga, String ibisobanuro) {
    _amateka.add(Amateka(
      id: DateTime.now().toString(),
      izina: izina,
      ubwoko: ubwoko,
      amafaranga: amafaranga,
      ibisobanuro: ibisobanuro,
      itariki: DateTime.now().toString(),
      icon: _getIconForUbwoko(ubwoko),
    ));
  }

  IconData _getIconForUbwoko(String ubwoko) {
    switch (ubwoko) {
      case "Umusanzu": return Icons.savings;
      case "Inguzanyo": return Icons.account_balance_wallet;
      case "Amande": return Icons.gavel;
      case "Kwishyura": return Icons.check_circle;
      case "Dividend": return Icons.card_giftcard;
      default: return Icons.info;
    }
  }
}
