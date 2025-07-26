import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:viettelgameapp/models/purchase_model.dart';
// import 'package:viettelgameapp/providers/purchase_provider.dart'; // Comment lại vì đang fake data

final Set<String> _productIds = {'subs.CLOUDGAME_THANG'};

String _normalizeProductId(String productId) {
  if (Platform.isAndroid) {
    return productId.toLowerCase();
  }
  return productId;
}

const String _subscriptionId = 'subs.CLOUDGAME_THANG';
final inAppPurchaseAvailabilityProvider = FutureProvider<bool>((ref) async {
  final isAvailable = await InAppPurchase.instance.isAvailable();
  return isAvailable;
});

final productDetailsProvider = FutureProvider<List<ProductDetails>>((ref) async {
  final isAvailable = await ref.watch(inAppPurchaseAvailabilityProvider.future);
  if (!isAvailable) {
    return [];
  }

  final Set<String> productIdsToQuery = Platform.isAndroid ? _productIds.map((id) => id.toLowerCase()).toSet() : _productIds;

  final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(productIdsToQuery);

  if (response.error != null) {
    debugPrint('StoreKit Error: ${response.error!.message}');
    return [];
  }

  return response.productDetails;
});

final singleProductDetailsProvider = FutureProvider.family<ProductDetails?, String>((ref, productId) async {
  try {
    final normalizedProductId = Platform.isAndroid ? _normalizeProductId(productId) : productId;

    final productList = await ref.watch(productDetailsProvider.future);
    if (productList.isEmpty) return null;

    return productList.firstWhere((product) => Platform.isAndroid ? _normalizeProductId(product.id) == normalizedProductId : product.id == normalizedProductId);
  } catch (e) {
    debugPrint('Error finding product: $e');
    return null;
  }
});

final productExistsProvider = FutureProvider.family<bool, String>((ref, productId) async {
  final product = await ref.watch(singleProductDetailsProvider(productId).future);
  return product != null;
});

class PurchasesNotifier extends StateNotifier<List<PurchaseDetails>> {
  final Ref ref;
  PurchasesNotifier(this.ref) : super([]);
  DateTime? _subscriptionExpiryDate;

  late StreamSubscription<List<PurchaseDetails>> _purchaseSubscription;

  void initializePurchases() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _purchaseSubscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        debugPrint('Purchase updated: ${purchaseDetailsList.length} items');
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _purchaseSubscription.cancel();
      },
      onError: (error) {
        debugPrint("Error in purchase stream: $error");
        // Xử lý lỗi stream
      },
    );
  }

  void disposeSubscription() {
    _purchaseSubscription.cancel();
  }

  DateTime? get subscriptionExpiryDate => _subscriptionExpiryDate;

  bool get isSubscriptionExpired {
    return _subscriptionExpiryDate != null && DateTime.now().isAfter(_subscriptionExpiryDate!);
  }

  bool get isSubscriptionValid {
    return _subscriptionExpiryDate != null && DateTime.now().isBefore(_subscriptionExpiryDate!);
  }

  bool get canPurchaseSubscription {
    // Nếu có subscription và vẫn còn hạn thì không cho mua
    if (_subscriptionExpiryDate != null && DateTime.now().isBefore(_subscriptionExpiryDate!)) {
      debugPrint('🚫 Cannot purchase: Subscription still valid until ${_subscriptionExpiryDate}');
      return false;
    }

    // Nếu subscription đã hết hạn thì cho phép mua lại
    if (isSubscriptionExpired) {
      final subscriptionId = _normalizeProductId(_subscriptionId);
      state = state.where((p) => _normalizeProductId(p.productID) != subscriptionId).toList();
      _subscriptionExpiryDate = null;
      debugPrint('🧹 Auto-cleared expired subscription');
      return true;
    }

    // Nếu không có subscription active thì cho phép mua
    return !hasActiveSubscription();
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      debugPrint("${purchaseDetails.status}");
      if (purchaseDetails.status == PurchaseStatus.pending) {
        debugPrint('Transaction pending for: ${_normalizeProductId(purchaseDetails.productID)}');
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            _deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
          }
        }

        if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored || purchaseDetails.pendingCompletePurchase) {
          try {
            await InAppPurchase.instance.completePurchase(purchaseDetails);
            debugPrint('✅ Purchase completed: ${purchaseDetails.purchaseID}');
          } catch (e) {
            debugPrint('❌ Error completing purchase: $e');
          }
        }
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // final purchaseJson = _purchaseDetailsToJson(purchaseDetails); // Comment lại vì đang fake data
    // final purchaseModel = PurchaseModel.fromJson(purchaseJson); // Comment lại vì đang fake data

    // Comment lại vì đang fake data
    // final finalModel = purchaseModel.copyWith(
    //   platform: Platform.isAndroid ? 'ANDROID' : 'IOS',
    // );

    try {
      // Comment lại việc gọi API thật
      // final PurchaseResponse? result = await ref.read(purchaseProvider.notifier).processPurchase(finalModel);

      // Fake data theo PurchaseResponse model để test
      // final PurchaseResponse result = PurchaseResponse.fromJson({
      //   'responseMessage': 'Purchase verified successfully',
      //   'responseCode': 6984, // Success code
      //   'responseDate': DateTime.now().toIso8601String(),
      //   'isValid': true,
      //   'purchaseId': purchaseDetails.purchaseID,
      //   'expitionDate': DateTime.now().add(Duration(days: 30)).toIso8601String(), // Hết hạn sau 30 ngày
      // });

      // Uncomment dòng dưới để test trường hợp subscription expired
      final PurchaseResponse result = PurchaseResponse.fromJson({
        'responseMessage': 'Subscription has expired',
        'responseCode': 4002, // Expired code
        'responseDate': DateTime.now().toIso8601String(),
        'isValid': false,
        'purchaseId': purchaseDetails.purchaseID,
        'expitionDate': DateTime.now().subtract(Duration(days: 1)).toIso8601String(),
      });

      if (result.responseCode == 6984) {
        if (result.expitionDate != null) {
          _subscriptionExpiryDate = result.expitionDate;
        }
        debugPrint('Purchase verified successfully');
        return true;
      } else if (result.responseCode == 4002) {
        debugPrint('Subscription has expired - allowing repurchase');
        _handleExpiredSubscription(purchaseDetails);
        return false;
      } else {
        debugPrint('Purchase verification failed with code: ${result.responseCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Error during purchase verification: $e');
      return false;
    }
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) {
    final existingPurchaseIndex = state.indexWhere((p) => p.purchaseID == purchaseDetails.purchaseID && _normalizeProductId(p.productID) == _normalizeProductId(purchaseDetails.productID));

    if (existingPurchaseIndex == -1) {
      state = [...state, purchaseDetails];
      debugPrint('Added new purchase to state: ${_normalizeProductId(purchaseDetails.productID)}');
    } else {
      final existingPurchase = state[existingPurchaseIndex];
      if (existingPurchase.status != purchaseDetails.status) {
        final updatedState = List<PurchaseDetails>.from(state);
        updatedState[existingPurchaseIndex] = purchaseDetails;
        state = updatedState;
        debugPrint('Updated existing purchase status: ${_normalizeProductId(purchaseDetails.productID)} from ${existingPurchase.status} to ${purchaseDetails.status}');
      } else {
        debugPrint('Purchase already exists with same status: ${_normalizeProductId(purchaseDetails.productID)}');
      }
    }
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    debugPrint('Invalid purchase: ${_normalizeProductId(purchaseDetails.productID)}');
    state = state.where((p) => p.purchaseID != purchaseDetails.purchaseID).toList();
  }

  void _handleExpiredSubscription(PurchaseDetails purchaseDetails) {
    final productId = _normalizeProductId(purchaseDetails.productID);
    debugPrint('Handling expired subscription: $productId');

    state = state.where((p) => _normalizeProductId(p.productID) != productId).toList();
    _subscriptionExpiryDate = null;

    debugPrint('✅ Expired subscription removed. User can now repurchase: $productId');

    if (purchaseDetails.pendingCompletePurchase) {
      InAppPurchase.instance.completePurchase(purchaseDetails);
    }
  }

  void _handleError(IAPError error) {
    debugPrint('Error during purchase: ${error.message}');
  }

  void buyProduct(ProductDetails productDetails) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    final productId = _normalizeProductId(productDetails.id);

    // Kiểm tra trước khi mua subscription
    if (productId.contains('subs.')) {
      if (!canPurchaseSubscription) {
        debugPrint('🚫 Cannot buy subscription: Still have valid subscription until ${_subscriptionExpiryDate}');
        return;
      }
      InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
      debugPrint('Buying subscription: $productId');
    } else if (productId.contains('consumable')) {
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
      debugPrint('Buying consumable: $productId');
    } else {
      InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
      debugPrint('Buying non-consumable: $productId');
    }
  }

  Future<void> restorePurchases() async {
    debugPrint('Restoring purchases...');
    state = [];
    await InAppPurchase.instance.restorePurchases();
  }

  void clearAllPurchases() {
    debugPrint('Clearing all purchases from state');
    state = [];
  }

  void removePurchase(String purchaseId) {
    state = state.where((purchase) => purchase.purchaseID != purchaseId).toList();
    debugPrint('Removed purchase: $purchaseId');
  }

  bool hasActiveSubscription() {
    final subscriptionId = _normalizeProductId(_subscriptionId);
    return state.any((purchase) => _normalizeProductId(purchase.productID) == subscriptionId && (purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored));
  }

  PurchaseDetails? getCurrentSubscription() {
    try {
      final subscriptionId = _normalizeProductId(_subscriptionId);
      return state.firstWhere((purchase) => _normalizeProductId(purchase.productID) == subscriptionId && (purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored));
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkAndClearExpiredSubscription() async {
    final subscription = getCurrentSubscription();
    if (subscription == null) {
      debugPrint('No active subscription found');
      return false;
    }

    final isValid = await _verifyPurchase(subscription);
    if (!isValid) {
      return true;
    }

    debugPrint('Current subscription is still valid');
    return false;
  }

  void clearExpiredSubscription() {
    final subscriptionId = _normalizeProductId(_subscriptionId);
    final expiredCount = state.where((p) => _normalizeProductId(p.productID) == subscriptionId).length;

    if (expiredCount > 0) {
      state = state.where((p) => _normalizeProductId(p.productID) != subscriptionId).toList();
      _subscriptionExpiryDate = null;
      debugPrint('✅ Manually cleared $expiredCount expired subscription(s)');
    } else {
      debugPrint('No subscriptions to clear');
    }
  }

  // Comment lại method này vì đang fake data, chỉ dùng khi gọi API thật
  // Map<String, dynamic> _purchaseDetailsToJson(PurchaseDetails purchaseDetails) {
  //   final json = <String, dynamic>{
  //     'productId': _normalizeProductId(purchaseDetails.productID),
  //     'purchaseId': purchaseDetails.purchaseID,
  //     'status': purchaseDetails.status.name.toString(),
  //     'source': purchaseDetails.verificationData.source,
  //   };

  //   if (purchaseDetails.verificationData.localVerificationData.isNotEmpty) {
  //     json['receiptData'] = purchaseDetails.verificationData.localVerificationData;
  //   }
  //   if (purchaseDetails.verificationData.serverVerificationData.isNotEmpty) {
  //     json['signature'] = purchaseDetails.verificationData.serverVerificationData;
  //   }
  //   if (purchaseDetails.transactionDate != null) {
  //     json['purchaseTime'] = purchaseDetails.transactionDate;
  //   }
  //   if (purchaseDetails.error != null) {
  //     json['error'] = {
  //       'code': purchaseDetails.error!.code,
  //       'message': purchaseDetails.error!.message,
  //       'details': purchaseDetails.error!.details,
  //     };
  //   }

  //   json.removeWhere((key, value) => value == null);
  //   return json;
  // }
}

final purchasesNotifierProvider = StateNotifierProvider<PurchasesNotifier, List<PurchaseDetails>>((ref) {
  final notifier = PurchasesNotifier(ref);
  notifier.initializePurchases();
  ref.onDispose(() {
    notifier.disposeSubscription();
  });
  return notifier;
});

final isPremiumUserProvider = Provider<bool>((ref) {
  final purchases = ref.watch(purchasesNotifierProvider);
  final subscriptionId = _normalizeProductId(_subscriptionId);
  return purchases.any((p) => _normalizeProductId(p.productID) == subscriptionId && (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored));
});

final hasActiveSubscriptionProvider = Provider<bool>((ref) {
  final purchases = ref.watch(purchasesNotifierProvider);
  final subscriptionId = _normalizeProductId(_subscriptionId);
  return purchases.any((p) => _normalizeProductId(p.productID) == subscriptionId && (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored));
});

final currentSubscriptionProvider = Provider<PurchaseDetails?>((ref) {
  final purchases = ref.watch(purchasesNotifierProvider);
  try {
    final subscriptionId = _normalizeProductId(_subscriptionId);
    return purchases.firstWhere((p) => _normalizeProductId(p.productID) == subscriptionId && (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored));
  } catch (e) {
    return null;
  }
});

final canPurchaseSubscriptionProvider = Provider<bool>((ref) {
  ref.watch(purchasesNotifierProvider);
  return ref.read(purchasesNotifierProvider.notifier).canPurchaseSubscription;
});

final subscriptionExpiryProvider = Provider<DateTime?>((ref) {
  ref.watch(purchasesNotifierProvider);
  return ref.read(purchasesNotifierProvider.notifier).subscriptionExpiryDate;
});

final isSubscriptionExpiredProvider = Provider<bool>((ref) {
  ref.watch(purchasesNotifierProvider);
  return ref.read(purchasesNotifierProvider.notifier).isSubscriptionExpired;
});

final isSubscriptionValidProvider = Provider<bool>((ref) {
  ref.watch(purchasesNotifierProvider);
  return ref.read(purchasesNotifierProvider.notifier).isSubscriptionValid;
});

final checkExpiredSubscriptionProvider = FutureProvider<bool>((ref) async {
  final notifier = ref.read(purchasesNotifierProvider.notifier);
  return await notifier.checkAndClearExpiredSubscription();
});
