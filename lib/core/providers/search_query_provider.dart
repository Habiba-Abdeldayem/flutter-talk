import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchContext { chats, users } 
// family in Riverpod lets you create multiple independent instances of the same provider, 
// each distinguished by the parameter you pass in.
// something like generic function
final searchQueryProvider = StateProvider.autoDispose.family<String, SearchContext>(
  (ref, context) => '',
);
