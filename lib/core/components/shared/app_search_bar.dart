import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_talk/core/providers/search_query_provider.dart';
import 'package:flutter_talk/core/themes/sizes/app_sizes.dart';

class AppSearchBar extends ConsumerWidget {
  final String hintText;
  final SearchContext searchContext;

  const AppSearchBar({
    super.key,
    required this.hintText,
    required this.searchContext,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(AppSizes.medium),
      margin: EdgeInsets.symmetric(horizontal: AppSizes.large),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      child: TextField(
        onChanged: (value) {
          ref.read(searchQueryProvider(searchContext).notifier).state = value;
        },
        decoration: InputDecoration(
          hint: Text(hintText),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
