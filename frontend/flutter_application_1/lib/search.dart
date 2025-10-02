import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details.dart';
import 'food.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  Future<List<Food>>? _future;

  Future<List<Food>> _fetchFoods(String q) async {
    final resp = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/search").replace(
        queryParameters: {"q": q.trim(), "page": "1", "page_size": "20"},
      ),
    );
    if (resp.statusCode != 200) throw Exception("Failed to fetch foods");
    final map = json.decode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
    final list = (map['items'] as List?) ?? [];
    return list.map((e) => Food.fromJson(e as Map<String, dynamic>)).toList();
  }

  void _doSearch() {
    final q = _controller.text.trim();
    if (q.isEmpty) return;

    setState(() {
      _future = _fetchFoods(q);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Foods")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type a food name and press Enter to search",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _doSearch(),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _future == null
                  ? const Center(child: Text("Type something to search"))
                  : FutureBuilder<List<Food>>(
                      future: _future,
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const LinearProgressIndicator();
                        }
                        if (snap.hasError) {
                          return Text("Error: ${snap.error}");
                        }
                        final data = snap.data ?? const <Food>[];
                        if (data.isEmpty) {
                          return const Center(child: Text("No Food Found!"));
                        }
                        return ListView.separated(
                          itemCount: data.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, i) => ListTile(
                            title: Text(data[i].name ?? "(no name)"),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DetailsPage(name: data[i].name ?? "(no name)"),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
