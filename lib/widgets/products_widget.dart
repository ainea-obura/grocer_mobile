import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocerygo/models/cart_item.dart';

import '../constants.dart';
import '../modules/cart/cart_cubit.dart';
import '../modules/products/products_cubit.dart';
import '../modules/products/products_state.dart';
import '../pages/product_details.dart';


class ProductsWidget extends StatelessWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is InitProductsState || state is LoadingProductsState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessProductsState) {
          final products = state.products;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Products",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle "See All" button tap
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: products.product.length,
                  itemBuilder: (context, index) {
                    final product = products.product[index];
                    return GestureDetector(
                      onTap: () {
                        // Redirect to product details page when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(product: product),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  'http://192.168.8.199:8000${product.thumbnail}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                product.title,
                                style: Theme.of(context).textTheme.bodyLarge,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'KES ${product.price}',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            //const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<CartCubit>(context).addItem(product);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Add to Cart'),
                                ),
                                // child: ElevatedButton(
                                //   onPressed: () {
                                //     context.read<CartCubit>().addToCart(CartItem(
                                //       id: product.id,
                                //       title: product.title,
                                //       price: product.price,
                                //       thumbnail: product.thumbnail,
                                //       quantity: 1,
                                //     ));
                                //   },
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: primaryColor,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //   ),
                                //   child: const Text('Add to Cart'),
                                // ),
                                // child: ElevatedButton(
                                //   onPressed: () {
                                //     //add to cart
                                //
                                //     // Show snackbar to confirm product added to cart
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(
                                //         content: Text('${product.title} added to cart'),
                                //         duration: const Duration(seconds: 2),
                                //         behavior: SnackBarBehavior.floating,
                                //       ),
                                //     );
                                //   },
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: primaryColor,
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(10),
                                //     ),
                                //   ),
                                //   child: const Text('Add to Cart'),
                                // ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is ErrorProductsState) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('Unknown error'));
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../constants.dart';
// import '../modules/cart/cart_cubit.dart';
// import '../modules/products/products_cubit.dart';
// import '../modules/products/products_state.dart';
// import '../pages/product_details.dart';
//
//
// class ProductsWidget extends StatelessWidget {
//   const ProductsWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductsCubit, ProductsState>(
//       builder: (context, state) {
//         if (state is InitProductsState || state is LoadingProductsState) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is SuccessProductsState) {
//           final products = state.products;
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Products",
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Handle "See All" button tap
//                       },
//                       child: const Text(
//                         "See All",
//                         style: TextStyle(color: primaryColor),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: GridView.builder(
//                   padding: const EdgeInsets.all(8),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.7,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemCount: products.product.length,
//                   itemBuilder: (context, index) {
//                     final product = products.product[index];
//                     return GestureDetector(
//                       onTap: () {
//                         // Redirect to product details page when tapped
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ProductDetailsPage(product: product),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                 ),
//                                 child: Image.network(
//                                   'http://192.168.8.199:8000${product.thumbnail}',
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8),
//                               child: Text(
//                                 product.title,
//                                 style: Theme.of(context).textTheme.bodyLarge,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8),
//                               child: Text(
//                                 'KES ${product.price}',
//                                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: primaryColor,
//                                 ),
//                               ),
//                             ),
//                             //const Spacer(),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8),
//                               child: SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     // Add product to cart
//                                     context.read<CartCubit>().addProduct(product);
//
//                                     // Show snackbar to confirm product added to cart
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text('${product.title} added to cart'),
//                                         duration: const Duration(seconds: 2),
//                                         behavior: SnackBarBehavior.floating,
//                                       ),
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: primaryColor,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   child: const Text('Add to Cart'),
//                                 ),
//                                 // child: ElevatedButton(
//                                 //   onPressed: () {
//                                 //     // Handle add to cart
//                                 //   },
//                                 //   style: ElevatedButton.styleFrom(
//                                 //     backgroundColor: primaryColor,
//                                 //     shape: RoundedRectangleBorder(
//                                 //       borderRadius: BorderRadius.circular(10),
//                                 //     ),
//                                 //   ),
//                                 //   child: const Text('Add to Cart'),
//                                 // ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         } else if (state is ErrorProductsState) {
//           return Center(child: Text(state.message));
//         }
//         return const Center(child: Text('Unknown error'));
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../modules/products/products_cubit.dart';
// import '../modules/products/products_state.dart';
//
// class ProductsWidget extends StatelessWidget {
//   const ProductsWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductsCubit, ProductsState>(
//       builder: (context, state) {
//         if (state is InitProductsState || state is LoadingProductsState) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is SuccessProductsState) {
//           final products = state.products;
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   'Products',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: GridView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   gridDelegate:
//                   const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 16),
//                   itemCount: products.product.length,
//                   itemBuilder: (context, index) {
//                     final product = products.product[index];
//
//                     return GestureDetector(
//                       onTap: () {
//                         // Navigate to product details screen
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset:
//                               const Offset(0, 3), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             AspectRatio(
//                               aspectRatio: 1,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   product.thumbnail,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8.0),
//                               child: Text(
//                                 product.title,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8.0),
//                               child: Text(
//                                 '\$${product.price}',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge!
//                                     .copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         } else if (state is ErrorProductsState) {
//           return Center(
//             child: Text(state.message),
//           );
//         }
//
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
