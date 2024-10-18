import 'package:flutter/material.dart';
import '../bloc/durasi_tur_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/durasi_tur.dart';
import 'durasi_tur_page.dart';

// ignore: must_be_immutable
class DurasiTurForm extends StatefulWidget {
  DurasiTur? durasi_tur;
  DurasiTurForm({Key? key, this.durasi_tur}) : super(key: key);
  @override
  _DurariTurFormState createState() => _DurariTurFormState();
}

class _DurariTurFormState extends State<DurasiTurForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH DURASI TUR";
  String tombolSubmit = "SIMPAN";
  final _tourTextboxController = TextEditingController();
  final _daysTextboxController = TextEditingController();
  final _costTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.durasi_tur != null) {
      setState(() {
        judul = "UBAH DURASI";
        tombolSubmit = "UBAH";
        _tourTextboxController.text = widget.durasi_tur!.tour!;
        _daysTextboxController.text = widget.durasi_tur!.days.toString();
        _costTextboxController.text = widget.durasi_tur!.cost.toString();
      });
    } else {
      judul = "TAMBAH DURASI";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _tourTextField(),
                _daysTextField(),
                _costTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Kode Produk
  Widget _tourTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tour"),
      keyboardType: TextInputType.text,
      controller: _tourTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Nama Produk
  Widget _daysTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Days"),
      keyboardType: TextInputType.number,
      controller: _daysTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Harga Produk
  Widget _costTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Cost"),
      keyboardType: TextInputType.number,
      controller: _costTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.durasi_tur != null) {
                //kondisi update durasi
                ubah();
              } else {
                //kondisi tambah durasi
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    DurasiTur createDurasiTur = DurasiTur(id: null);
    createDurasiTur.tour = _tourTextboxController.text;
    createDurasiTur.days = int.parse(_daysTextboxController.text);
    createDurasiTur.cost = int.parse(_costTextboxController.text);
    DurasiTurBloc.addDurasiTur(durasi: createDurasiTur).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const DurasiTurPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    DurasiTur updateDurasiTur = DurasiTur(id: widget.durasi_tur!.id!);
    updateDurasiTur.tour = _tourTextboxController.text;
    updateDurasiTur.days = int.parse(_daysTextboxController.text);
    updateDurasiTur.cost = int.parse(_costTextboxController.text);
    DurasiTurBloc.updateDurasiTur(durasi: updateDurasiTur).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const DurasiTurPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
