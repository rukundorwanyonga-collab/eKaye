class Umuntu {
  Umuntu({
    required this.id,
    required this.izina,
    this.phone = "",
    required this.umusanzu,
    this.ingoboka = 0.0,
    this.amande = 0.0,
    this.ideniKUmusanzuUtatanzwe = 0.0,
    required this.igiteranyo,
    required this.itariki,
  });

  final String id;
  String izina;
  String phone;
  double umusanzu;
  double ingoboka;
  double amande;
  double ideniKUmusanzuUtatanzwe;
  double igiteranyo;
  String itariki;
}
