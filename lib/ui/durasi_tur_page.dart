import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/durasi_tur_bloc.dart';
import '/model/durasi_tur.dart';
import 'durasi_tur_detail.dart';
import 'durasi_tur_form.dart';
import 'login_page.dart';

class DurasiTurPage extends StatefulWidget {
  const DurasiTurPage({Key? key}) : super(key: key);

  @override
  _DurasiTurPage createState() => _DurasiTurPage();
}

class _DurasiTurPage extends State<DurasiTurPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Durasi Tur'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>DurasiTurForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: DurasiTurBloc.getDurasiTur(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListProduk(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List? list;

  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemProduk(
            produk: list![i],
          );
        });
  }
}

class ItemProduk extends StatelessWidget {
  final DurasiTur produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DurasiTurDetail(
                      durasi_tur: produk,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(produk.days.toString()),
          subtitle: Text(produk.cost.toString()),
          trailing: Text(produk.tour!),
        ),
      ),
    );
  }
}
