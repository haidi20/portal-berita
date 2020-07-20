import 'package:flutter/material.dart';

class HeaderScreen extends StatelessWidget {
  final Function(String) handleSearch;

  HeaderScreen({this.handleSearch});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "Search Holiday Package",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFE5E8EC),
              boxShadow: [
                BoxShadow(color: Color(0xFFF6F9FD), spreadRadius: 3),
              ],
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              onChanged: (e) => this.handleSearch(e),
            ),
          ),
        ],
      ),
    );
  }
}
