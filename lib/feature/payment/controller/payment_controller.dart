import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
class PaymentController extends GetxController{
  var selectedPayment="".obs;

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

  Future<void>makePayment(double amount, String currency)async{
    
  }
}
