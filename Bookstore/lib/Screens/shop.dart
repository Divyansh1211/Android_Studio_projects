import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookstore/books.dart';
import 'package:flutter/material.dart';
import 'book_data.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  List<Book> allBooks = [];
  List<Book> loadedBooks = [];
  int _currentPage = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchBooks();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchBooks();
    }
  }

  void _onSearch(BuildContext context) async {
    final Book? result = await showSearch<Book>(
      context: context,
      delegate: BookSearchDelegate(allBooks),
    );

    if (result != null) {
      _navigateToBookDetails(result);
    }
  }

  void _navigateToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(
          bookTitle: book.title,
          previewLink: book.previewLink,
        ),
      ),
    );
  }

  void fetchBooks({String? searchQuery}) async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=${searchQuery ?? 'books'}&startIndex=$_currentPage'), //if there is a searched book then it will return the preview of that book else it will show all the other books
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final items = jsonData['items'] as List<dynamic>;

      final List<Book> fetchedBooks = items.map((item) {
        final volumeInfo = item['volumeInfo'];
        final title = volumeInfo['title'];
        final authors = volumeInfo['authors']?.join(', ') ?? 'Unknown';
        final coverImageUrl = volumeInfo['imageLinks']['thumbnail'];
        final previewLink = item['volumeInfo']['previewLink'];

        return Book(
          title: title,
          author: authors,
          coverImageUrl: coverImageUrl,
          previewLink: previewLink,
        );
      }).toList();

      setState(() {
        allBooks.addAll(fetchedBooks);
        loadedBooks.addAll(fetchedBooks);
        _currentPage += 10; // Increment the page for the next fetch
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.list,
          color: Colors.black,
          size: 35,
        ),
        title: Text(
          "Shop",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () => _onSearch(context),
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: loadedBooks.length,
        itemBuilder: (context, index) {
          final book = loadedBooks[index];
          return GestureDetector(
            onTap: () {
              _navigateToBookDetails(book);
            },
            child: Card(
              child: ListTile(
                leading: Image.network(book.coverImageUrl),
                title: Text(book.title),
                subtitle: Text(book.author),
              ),
            ),
          );
        },
      ),
    );
  }
}

//SearchDelegate Class used for searching the books from the list
class BookSearchDelegate extends SearchDelegate<Book> {
  final List<Book> allBooks;

  BookSearchDelegate(this.allBooks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null!);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Book> suggestions = allBooks.where((book) {
      return book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.author.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final book = suggestions[index];
        return ListTile(
          title: Text(book.title),
          subtitle: Text(book.author),
          onTap: () {
            close(context, book);
          },
        );
      },
    );
  }
}
