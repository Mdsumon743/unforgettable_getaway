import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class PaymentController extends GetxController {
  final instance = Stripe.instance;
  var selectedPayment = "".obs;
  var img = Assetpath.creditcard.obs;

  void selectPlan(String izaz) {
    selectedPayment.value = izaz;
    if (selectedPayment.value == "credit_card") {
      img.value = Assetpath.creditcard;
    } else if (selectedPayment.value == "visa_card") {
      img.value = Assetpath.visa;
    } else if (selectedPayment.value == "paypal") {
      img.value = Assetpath.paypal;
    } else if (selectedPayment.value == "google_pay") {
      img.value = Assetpath.gpay;
    } else {
      img.value = Assetpath.pay;
    }
  }

  // Future<void> makePayment(double price) async {
  //   try {
  //     String? clientSecret = await _createPaymentIntent(price, "usd");

  //     if (clientSecret == null) {
  //       debugPrint("==========+ Client Secret is null");
  //       return;
  //     }
  //     debugPrint("=========>>$clientSecret");

  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         paymentIntentClientSecret: clientSecret,
  //         merchantDisplayName: "Unforgettable Getaway",
  //       ),
  //     );

  //     await _processPayment();
  //   } catch (e) {
  //     debugPrint("====== CatchError ====== $e");
  //   }
  // }

  // Future<void> _processPayment() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet();
  //     debugPrint("Payment successful!");
  //   } catch (e) {
  //     debugPrint("Error in payment processing: $e");
  //   }
  // }

  // Future<String?> _createPaymentIntent(double price, String currency) async {
  //   try {
  //     final Dio dio = Dio();

  //     int amountInCents = (price * 100).toInt();

  //     Map<String, dynamic> data = {
  //       "amount": amountInCents.toString(),
  //       "currency": currency,
  //       "payment_method_types[]": "card",
  //     };

  //     final response = await dio.post(
  //       "https://api.stripe.com/v1/payment_intents",
  //       data: data,
  //       options: Options(
  //         headers: {
  //           "Authorization": "Bearer $secretkey",
  //           "Content-Type": "application/x-www-form-urlencoded",
  //         },
  //       ),
  //     );

  //     debugPrint("Response Status Code: ${response.statusCode}");

  //     if (response.statusCode == 200 && response.data != null) {
  //       debugPrint("Response Data ========>>>: ${response.data}");
  //       return response.data['client_secret'];
  //     } else {
  //       debugPrint("Failed to create Payment Intent: ${response.data}");
  //     }
  //   } catch (e) {
  //     debugPrint("===== CatchError in _createPaymentIntent ===== $e");
  //   }
  //   return null;
  // }
}

