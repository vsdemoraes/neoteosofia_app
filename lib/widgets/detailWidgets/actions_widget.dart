import 'package:books_app/models/book.dart';
import 'package:books_app/services/utils.dart';
import 'package:flutter/material.dart';

class ActionsWidget extends StatelessWidget {
  final Book book;
  ActionsWidget(this.book);

  @override
  Widget build(BuildContext context) {
    String availability;
    IconData icon;
    if (book.accessViewStatus == 'EXEMPLO') {
      availability = 'EXEMPLO';
      icon = Icons.description;
    } else if (book.accessViewStatus == 'PLENO DOMÍNIO PÚBLICO') {
      availability = 'LEIA';
      icon = Icons.book;
    } else {
      availability = 'PAGO';
      icon = Icons.attach_money;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ActionButton(
          icon: Icons.chrome_reader_mode,
          label: 'PRÉVIA',
          onPressed: () async {
            await Utils.launchURL(book.previewLink);
          },
        ),
        SizedBox(width: 5.0),
        ActionButton(
          label: book.saleability != 'À VENDA'
              ? 'N/A'
              : '${book.amount} ${book.currencyCode}',
          onPressed: () => book.saleability != 'À VENDA'
              ? null
              : () async {
                  await Utils.launchURL(book.webReaderLink);
                },
          icon: Icons.shop,
        ),
        SizedBox(width: 5.0),
        ActionButton(
          label: availability,
          icon: icon,
          onPressed: () => book.accessViewStatus != 'PLENO DOMÍNIO PÚBLICO' &&
                  book.accessViewStatus != 'EXEMPLO'
              ? null
              : () async {
                  await Utils.launchURL(book.webReaderLink);
                },
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  ActionButton(
      {required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      label: Text(
        label,
        style: TextStyle(fontSize: 10.0),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 16.0,
      ),
    );
  }
}
