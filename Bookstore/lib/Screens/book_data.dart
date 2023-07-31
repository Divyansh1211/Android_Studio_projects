import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsScreen extends StatefulWidget {
  final String bookTitle;
  final String? previewLink;

  BookDetailsScreen({required this.bookTitle, this.previewLink});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.bookTitle,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchPreviewLink,
          style: ElevatedButton.styleFrom(primary: Colors.white),
          child: Text(
            'Open Book Preview',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchPreviewLink() async {
    if (widget.previewLink != null) {
      try {
        await launch(widget.previewLink!);            //you can't directly view the contents of the books that is why added the preview link.
      } catch (e) {
        throw 'Could not launch ${widget.previewLink}';
      }
    }
  }
}
