import 'package:dinamik_ortalama_hesapla/constants/app_constant.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesapla/model/ders.dart';
import 'package:dinamik_ortalama_hesapla/widgets/ders_listesi.dart';
import 'package:dinamik_ortalama_hesapla/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  var formKey = GlobalKey<FormState>();
  double secilenHarfDeger = 4;
  double secilenKrediDeger = 1;
  String girilenDersAdi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Yatay ekranda klavye hatası almamak için yapılır...
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // Rengi daha sonra belirleyeceğimiz için renksiz olması adına transparent yaptık başta...
        elevation: 0,
        //Elevation değer olduğu için gri gözüküyor bu yüzden 0 yaptık...
        title: Center(
          child: Text(
            Sabitler.baslikText,
            style: Sabitler.baslikStyle,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // Yatayda boş alanları kaplamak için kullanılır...
        children: [
          // Birinci eleman form olacak...

          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                    dersSayisi: DataHelper.tumEklenenDersler.length,
                    ortalama: DataHelper.ortalamaHesapla()),
              ),
            ],
          ),

          /********************************************************************* */
          // Öncelikle taslak olması açısından container oluşturuldu...
          /*Container(
            child: Text('Form burada tutulacak...'),
            color: Colors.red,
          ), // Burada gelecek form için yer tutulmaktadır. Taslak da denilebilir...*/

          /********************************************************************* */

          // İkinci eleman bir liste olacak...
          Expanded(
            child: DersListesi(
              onElemanCikarildi: (index) {
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {});
              },
            ),
          ), // Burada gelecek liste için yer tutulmaktadır. Taslak da denilebilir...
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFormField(),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildHarfler(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildKrediler(),
                ),
              ),
              IconButton(
                onPressed: () {
                  _dersEkleveOrtalamaHesapla();
                },
                icon: Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Bir ders giriniz...';
        } else
          return null;
      },
      decoration: InputDecoration(
        hintText: 'Matematik',
        border: OutlineInputBorder(
            borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double>(
          value: secilenHarfDeger,
          elevation: 16,
          iconEnabledColor: Sabitler.anaRenk.shade200,
          onChanged: (deger) {
            setState(() {
              secilenHarfDeger = deger!;
            });
          },
          underline: Container(),
          items: DataHelper.tumDerslerinHarfleri()),
    );
  }

  _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropDownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.borderRadius,
      ),
      child: DropdownButton<double>(
          value: secilenKrediDeger,
          elevation: 16,
          iconEnabledColor: Sabitler.anaRenk.shade200,
          onChanged: (deger) {
            setState(() {
              secilenKrediDeger = deger!;
            });
          },
          underline: Container(),
          items: DataHelper.tumDerslerinKredileri()),
    );
  }

  _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var eklenecekDers = Dersler(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDeger,
          krediDegeri: secilenKrediDeger);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
