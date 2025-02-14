import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sabitler {
  static const MaterialColor anaRenk = Colors.indigo;
  //Nesne üretmeden çağırabilmek için için static tanımladık...
  static const String baslikText = 'Ortalama Hesapla';
  static final TextStyle baslikStyle = GoogleFonts.quicksand(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color:
        anaRenk, // Aynı sınıfta olduğu için 'Sabitler.anaRenk' diye kullanmaya gerek yok...
  );

  static BorderRadius borderRadius = BorderRadius.circular(24);

  static final TextStyle ortalamaGosterBodyStyle = GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: anaRenk,
  );

  static final TextStyle ortalamaStyle = GoogleFonts.quicksand(
    fontSize: 55,
    fontWeight: FontWeight.w800,
    color: anaRenk,
  );

  static final dropDownPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  static final yatayPadding8 = EdgeInsets.symmetric(horizontal: 8);
}
