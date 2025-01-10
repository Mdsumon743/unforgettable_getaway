import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
class PaymentController extends GetxController{
  var selectedPayment="".obs;
  var publickey = "pk_test_51QKdoWHlqANa4h6mpxHAu85KhAFt2fnBsRRFKeWUhdqmlZJQ0SI6b3ZCuZ0LU3lCu7Gc4qT6rdl8xVsGqntH2G0400sW14ZlIt";
  var secretkey = "sk_test_51QKdoWHlqANa4h6mz1D3tXUHzKCKZhiMCghWis6YXvF2zIdyr51X8Bm4bkiFfuxSIlQf8s9FSLoSQlXnbe3htsTU00r2qjdSn1";
  var img= Assetpath.creditcard.obs;
  void selectPlan(String izaz){
    selectedPayment.value=izaz;
    if(selectedPayment.value=="credit_card") {
      img.value=Assetpath.creditcard;

    }else if(selectedPayment.value=="visa_card"){
      img.value=Assetpath.visa;

    }else if(selectedPayment.value=="paypal"){
      img.value=Assetpath.paypal;

    }else if(selectedPayment.value=="google_pay"){
      img.value= Assetpath.gpay;

    }else{
   img.value=Assetpath.pay;
    }
  }
}
