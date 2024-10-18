import 'package:flutter/material.dart';
import '../bloc/durasi_tur_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/durasi_tur.dart';
import 'durasi_tur_form.dart';
import 'durasi_tur_page.dart';

// ignore: must_be_immutable
class DurasiTurDetail extends StatefulWidget {
  DurasiTur? durasi_tur;

  DurasiTurDetail({Key? key, this.durasi_tur}) : super(key: key);

  @override
  _DurasiTurState createState() => _DurasiTurState();
}

class _DurasiTurState extends State<DurasiTurDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.durasi_tur!.tour}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.durasi_tur!.days}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.durasi_tur!.cost}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DurasiTurForm(
                  durasi_tur: widget.durasi_tur!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            DurasiTurBloc.deleteProduk(id: widget.durasi_tur!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DurasiTurPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
