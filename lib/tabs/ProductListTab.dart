import 'package:flutter/cupertino.dart';
import 'package:flutter_lesson/components/product_raw_item.dart';
import 'package:flutter_lesson/model/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductListTab extends ConsumerWidget {
  const ProductListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productStateNotifier = ref.watch(productStateNotifierProvider.notifier);
    productStateNotifier.loadProduct();
    final products = productStateNotifier.getProducts();

    return CustomScrollView(
      semanticChildCount: products.length,
      slivers: <Widget>[
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Home Page'),
        ),
        SliverSafeArea(
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < products.length) {
                  return ProductRawItem(
                    product: products[index],
                    lastItem: false,
                  );
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
