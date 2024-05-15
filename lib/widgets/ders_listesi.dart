import 'package:dinamik_ortalama_hesapla/constants/app_constant.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class DersListesi extends StatelessWidget {
  final Function onElemanCikarildi;
  const DersListesi({required this.onElemanCikarildi, super.key});

  @override
  Widget build(BuildContext context) {
    List<Dersler> tumDersler = DataHelper.tumEklenenDersler;
    return tumDersler.length > 0
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                // Dismissible kaydırma ile verilerin silinmesini sağlar...
                key: UniqueKey(),
                // Birbirinden farklı keyler atar...
                direction: DismissDirection.startToEnd,
                // Sağa kaydırınca silmeyi sağlar...
                onDismissed: (a) {
                  //DataHelper.tumEklenenDersler.removeAt(index);
                  //setState(() {});
/********************************************************************************* */

                  onElemanCikarildi(index);
                }, // Silme fonksiyonu burada yazılır...
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                        backgroundColor: Sabitler.anaRenk,
                        child: Text((tumDersler[index].harfDegeri *
                                tumDersler[index].krediDegeri)
                            .toStringAsFixed(0)),
                      ),
                      subtitle: Text(
                          '${tumDersler[index].krediDegeri} Kredi, Not Değeri ${tumDersler[index].harfDegeri}'),
                    ),
                  ),
                ),
              );
            })
        : Container(
            child: Center(
              child: Text(
                'Lütfen ders ekleyiniz...',
                style: Sabitler.baslikStyle,
              ),
            ),
          );
  }
}
