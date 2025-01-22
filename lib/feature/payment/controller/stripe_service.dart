import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/payment/controller/key.dart';
import 'package:unforgettable_getaway/feature/payment/controller/subcribtion_plan.dart';

class StripeService {
  StripeService._();

  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());

  static final StripeService instance = StripeService._();

  Future<void> setupPaymentMethod() async {
    try {
      // Step 1: Create SetupIntent and retrieve client secret
      String? setupIntentClientSecret = await _createSetupIntent();

      if (setupIntentClientSecret == null) {
        log('Setup Intent creation failed');
        return;
      }

      log('Setup Intent Created: $setupIntentClientSecret');

      // Step 2: Initialize the Payment Sheet with SetupIntent
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: setupIntentClientSecret,
          merchantDisplayName: "Unforgattable Getaway",
        ),
      );

      // Step 3: Present the Payment Sheet for the user to confirm the payment method
      await _confirmSetupIntent(setupIntentClientSecret);
    } catch (e) {
      log('Setup Failed: $e');
    }
  }

  Future<void> _confirmSetupIntent(String setupIntentClientSecret) async {
    try {
      // Present the Payment Sheet for the user
      await Stripe.instance.presentPaymentSheet();

      // Confirm that the Payment Sheet was successfully completed
      log('Setup Successful!');

      // Step 4: Retrieve final details including the payment method ID
      await _getSetupDetails(setupIntentClientSecret);
    } catch (e) {
      log('Setup Confirmation Failed: $e');
    }
  }

  Future<void> _getSetupDetails(String setupIntentClientSecret) async {
    try {
      final Dio dio = Dio();

      // Extract SetupIntent ID from the client secret
      final setupIntentId = setupIntentClientSecret.split('_secret')[0];
      log('Setup Intent ID: $setupIntentId');

      // Retrieve SetupIntent details from Stripe
      var response = await dio.get(
        "https://api.stripe.com/v1/setup_intents/$setupIntentId",
        options: Options(
          headers: {
            "Authorization": "Bearer $secretkey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );

      log('Response Status: ${response.statusCode}');
      log('Response Data: ${response.data}');

      // Retrieve and log the payment method ID if available
      if (response.data != null && response.data['payment_method'] != null) {
        String paymentMethodId = response.data['payment_method'];
        log('Payment Method ID: $paymentMethodId');
        await subscriptionController.sendPaymentServer(paymentMethodId);
      } else {
        log('No payment method returned from Stripe');
      }
    } catch (e) {
      log('Failed to retrieve setup details: $e');
    }
  }

  Future<String?> _createSetupIntent() async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "payment_method_types[]": "card",
        // Uncomment if associating with a customer
        // "customer": "cus_yourCustomerIdHere",
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/setup_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $secretkey",
          },
        ),
      );

      if (response.data != null) {
        log('Setup Intent Response: ${response.data}');
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      log('Error creating SetupIntent: $e');
      return null;
    }
  }
}
