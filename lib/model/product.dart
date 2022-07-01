import 'package:flutter_lesson/repository/productRepository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ProductCategory {
  all,
  accessories,
  clothing,
  home,
}

class ProductState {
  final int id;
  final String name;
  final int price;
  final ProductCategory category;
  final bool isFeatured;

  ProductState({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.isFeatured,
  });

  String get assetName => '$id-0.jpg';
  String get assetPackage => 'shrine_images';

  @override
  String toString() => '$name (id=$id)';
}

int _shippingCostPerItem = 300;
double _taxRate = 0.1;

class ProductStateNotifier extends StateNotifier<ProductState> {
  ProductStateNotifier({
    int id = 0,
    String name = 'dummy',
    int price = 0,
    ProductCategory category = ProductCategory.clothing,
    bool isFeatured = true,
  }) : super(ProductState(
          id: id,
          name: name,
          price: price,
          category: category,
          isFeatured: isFeatured,
        ));

  List<ProductState> _availableProducts = [];
  ProductCategory _selectedCateogory = ProductCategory.all;

  final _productsInCart = <int, int>{};

  Map<int, int> get productsInCart {
    return Map.from(_productsInCart);
  }

  int get totalCartQuantity {
    return _productsInCart.values.fold(0, (stack, current) {
      return stack + current;
    });
  }

  ProductCategory get selectedCategory {
    return _selectedCateogory;
  }

  int get subTotalCost {
    return _productsInCart.keys.map((id) {
      return getProductById(id).price * _productsInCart[id]!;
    }).fold(0, (stack, current) {
      return stack + current;
    });
  }

  int get shippingCost {
    return _shippingCostPerItem *
        _productsInCart.values.fold(0, (stack, current) {
          return stack + current;
        });
  }

  double get tax => (subTotalCost + shippingCost) * _taxRate;

  int get totalPrice => (tax + subTotalCost + shippingCost).toInt();

  List<ProductState> getProducts() {
    return selectedCategory == ProductCategory.all ? _availableProducts : _availableProducts.where((product) => product.category == _selectedCateogory).toList();
  }

  List<ProductState> search(String text) {
    List<ProductState> products = getProducts();
    return products.where((product) {
      return product.name.toLowerCase().contains(text.toLowerCase());
    }).toList();
  }

  void addProductToCart(int productId) {
    _productsInCart[productId] = (_productsInCart[productId] ?? 0) + 1;
  }

  void removeProductToCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId] = _productsInCart[productId]! - 1;
      }
    }
  }

  ProductState getProductById(int id) {
    return _availableProducts.firstWhere((product) => product.id == id);
  }

  void loadProduct() {
    _availableProducts = ProductRepository.loadProducts(ProductCategory.all);
  }

  void clearCart() {
    _productsInCart.clear();
  }

  void setCategory(ProductCategory category) {
    _selectedCateogory = category;
  }
}

final productStateNotifierProvider = StateNotifierProvider<ProductStateNotifier, ProductState>((ref) => ProductStateNotifier());
