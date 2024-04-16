//
//  CheckoutPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 18/11/22.
//

import SwiftUI
import SwiftyJSON

struct CheckoutPageUIView: View {
    @Environment(\.presentationMode) var presentationMode
   // @Binding var CheckoutProductItemResponseModel:CartProductResponse
    @State var CheckoutProductItemResponseModel:OrderReviewResponse
   // @Binding var AddressResponseModel : MyAddressResponse
    @State var CheckoutCompletedisPresent = false
    @State var ChangeAddressisPresent = false
    @State var TempAddressId:String
    @State var DefaultAddressJson: JSON = []
    @State var placedOrderJson: JSON = []
    @State var isChecked:Bool = false
    @State var isApplyWallet:String = "0"
    func toggle(){isChecked = !isChecked}
    @State var AddType = "cod"
    @State var A1 = [Color.blue, Color.gray.opacity(0.0)]
    @State var showLoader = false
   // @State var tempAddressID :String
    @Binding var AddressResponse:JSON
   // @State var placeOrderResponse:JSON = []
    var body: some View {
        ZStack{
            Color("backColor1")
            if CheckoutProductItemResponseModel.address == ""{
                addressView( AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []), addressId: $TempAddressId)
            }else{
                VStack{
                    HStack{
                        Button(action: {
                            
                            presentationMode.wrappedValue.dismiss()
                        }) {
                           Image(systemName: "chevron.backward")
                                .font(.system(size: 20))
                                .padding(.leading,12)
                                .padding(.top,48)
                                .foregroundColor(Color.white)
                        }
                        Text("Order Review")
                            .font(.system(size: 20).bold())
                            //.padding(.l,20)
                            .padding(.top,48)
                        Spacer()
                        Image("Plain blue on white version")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 100,height: 20)
                            .padding(.top,48)
                            .padding(.trailing,20)
                       
                        
                    }.frame(width: UIScreen.main.bounds.width,height: 100)
                    .background(Color("backColor"))
                    .foregroundColor(Color.white)
                    ScrollView(.vertical,showsIndicators: false){
                        VStack{
                            Text("Address Information")
                                .font(.system(size: 16).bold())
                                .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                .padding(.leading,12)
                           // ForEach(CheckoutProductItemResponseModel.data ?? []){ item in
                                VStack(alignment: .leading){
                                   
                                    HStack{
                                        Text("\(CheckoutProductItemResponseModel.addresstype ?? "")")
                                            .font(.system(size: 16).bold())
                                            .padding(.leading,9)
                                        Spacer()
                                        Button(action: {
                                            
                                            ChangeAddressisPresent = true
                                        }, label: {
                                            Text("Change")
                                                .font(.system(size: 14).bold())
                                                .padding(.top,9)
                                                .padding(.trailing,9)
                                        }).fullScreenCover(isPresented: $ChangeAddressisPresent,onDismiss: {
                                            OrderReviewApi( AddressID: "\(NetworkManager.getDefaultAddressId())", ApplyWallet: "0")
                                        }){
                                            ChangeAddress( TempAddressId: $TempAddressId, AddressResponse: $AddressResponse)
                                            //addressView( AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []))
                                        }
                                       
                                    }
                                    Text("\(CheckoutProductItemResponseModel.name ?? "" )")
                                        .font(.system(size: 14).bold())
                                        .padding(.leading,9)
                                    Text("\(CheckoutProductItemResponseModel.mobileno ?? "")")
                                        .font(.system(size: 14))
                                        .padding(.leading,9)
                                    Text("\(CheckoutProductItemResponseModel.buildingName ?? "")")
                                        .font(.system(size: 14))
                                        .padding(.leading,9)
                                    Spacer()
                                }.frame(width: UIScreen.main.bounds.width-20,height: 85,alignment: .leading)
                                    .background(Color.white)
                                    .cornerRadius(6)
                           // }
                           
                            Text("Products")
                                .font(.system(size: 16).bold())
                                .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                .padding(.leading,12)
                            
                            VStack{
                               // ScrollView(.vertical,showsIndicators: false){
                                    ForEach(CheckoutProductItemResponseModel.data ?? []){item in
                                        // var qtycounter = item.qty
                                        VStack(spacing: 0){
                                            VStack{
                                                HStack{
                                                    VStack(alignment:.leading,spacing: 0){
                                                        Text("\(item.productname )")
                                                            .font(.system(size: 14))
                                                            .foregroundColor(Color.gray)
                                                            .lineLimit(3)
                                                        
                                                            .frame(width: 200,height: 49,alignment: .leading)
                                                            .padding(.top,9)
                                                            .padding(.leading,9)
                                                        HStack{
                                                            Text("USD")
                                                                .font(.system(size: 16))
                                                                .padding(.leading,9)
                                                            Text("\(item.productSellingprice ?? "")")
                                                                .font(.system(size: 16).bold())
                                                            Text("~USD \(item.productMrp ?? "")~ ")
                                                                .font(.system(size: 14))
                                                                .padding(.leading,9)
                                                            Spacer()
                                                        } .frame(width: 200, alignment: .leading)
                                                          
                                                        Text("Qty : \(item.qty ?? "")")
                                                            .font(.system(size: 14))
                                                            .foregroundColor(Color.gray)
                                                            .lineLimit(3)
                                                            .padding(.leading,9)
                                                            .frame(width: 200,height: 49,alignment: .leading)
                                                        Button(action: {
                                                           // DeleteItemApi(itemID: "\(item.id ?? "")")
                                                        }, label: {
                                                            HStack{
                            
                                                                Image(systemName: "trash")
                                                                    .padding(.leading,9)
                                                                Text("Remove")
                                                                    .font(.system(size: 14))
                                                                    .padding(.trailing,6)
                                                                 
                                                                Spacer()
                                                                
                                                            }.frame(width: 200)
                                                                .foregroundColor(Color.black.opacity(0.6))
                                                                //.padding(.bottom,9)
                                                        })
                                                       
                                                       Spacer()
                                                    }.frame(width: 200)
                                                        .padding(.leading,12)
                                                    VStack{
                                                        VStack {
                                                            AsyncImage(url: URL(string: "\(item.imageurl)")) { image in
                                                                image.resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 130, height: 125)
                                                                    .padding(.top,9)
                                                                
                                                            } placeholder: {
                                                                Image("user (1)")
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 35, height: 35)
                                                                    .cornerRadius(25)
                                                                    .padding(.leading,20)
                                                                    .padding(.top,10)
                                                            }
                                                          
                                                            
                                                        }
                                                    }.frame(width: 144,height: 130)
                                                        //.background(Color.yellow)
                                                        .padding(.trailing,12)
                                                }
                                               
                                            }
                                        }.frame(width: UIScreen.main.bounds.width-20,height: 150)
                                            .background(Color.white)
                                            .cornerRadius(6)
                                           // .padding(.top,12)
                                    }
                                    
                                //}
                            }.frame(width: UIScreen.main.bounds.width-20,alignment: .leading)
                               // .background(Color.white)
                                .cornerRadius(6)
                            VStack{
                                HStack{
                                    Image("Group")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 30,height: 30)
                                        .padding(.leading,9)
                                    VStack(alignment: .center){
                                        Text("Zvatada Credits")
                                            .font(.system(size: 18).bold())
                                            .foregroundColor(Color("backColor"))
                                            .frame(width: 260,alignment: .leading)
                                        if CheckoutProductItemResponseModel.walletAmountApplied == "0"{
                                            Text("Available Balance: USD  \(CheckoutProductItemResponseModel.userwalletamount ?? "")")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color.gray)
                                                .frame(width: 260,alignment: .leading)
                                        }else{
                                            Text("Available Balance: USD \(CheckoutProductItemResponseModel.walletAmountRemaining ?? "")")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color.gray)
                                                .frame(width: 260,alignment: .leading)
                                        }
                                        
                                       

                                    }
                                    Spacer()
                                    if CheckoutProductItemResponseModel.walletAmountApplied == "0"{
                                        Button(action: {

                                            isChecked = true
                                            isApplyWallet = "1"
                                            OrderReviewApi( AddressID: "\(NetworkManager.getDefaultAddressId())", ApplyWallet: "1")
                                        }, label: {
                                            Image(systemName: isChecked ? "checkmark.square": "square")
                                               
                                                .font(.system(size: 20))
                                                .padding(.trailing,12)
                                        })
                                    }else {
                                        Button(action: {
                                            let a = Double(CheckoutProductItemResponseModel.walletAmountApplied ?? "")
                                            let b = Double(CheckoutProductItemResponseModel.grandtotal ?? "" )
                                            let c = Double(b ?? 0.0)-Double(a ?? 0.0)
                                            if c == 0.00{
                                                AddType = "cod"
                                                A1 = [ Color("Background").opacity(0.3),Color.blue]
                                            }   
                                            isChecked = true
                                            isApplyWallet = "0"
                                            OrderReviewApi( AddressID: "\(NetworkManager.getDefaultAddressId())", ApplyWallet: "0")
                                        }, label: {
                                            Image(systemName: isChecked ? "square": "checkmark.square")
                                            
                                                .font(.system(size: 20))
                                                .padding(.trailing,12)
                                        })
                                    }
                                   
                                }
                            }.frame(width: UIScreen.main.bounds.width-20,height: 65,alignment: .leading)
                             .background(Color.white)
                             .cornerRadius(6)
                            
                            
                            VStack{
                                Text("Price Summary")
                                    .font(.system(size: 16).bold())
                                    .foregroundColor(Color("backColor"))
                                    .frame(width: UIScreen.main.bounds.width-20,height:20,alignment: .leading)
                                    .padding(.leading,9)
                                    .padding(.top,9)
                                HStack{
                                    Text("Total items:")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black.opacity(0.5))
                                        .padding(.leading,9)
                                    Spacer()
                                    Text("\(CheckoutProductItemResponseModel.totalquantity ?? "")")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black)
                                        .padding(.trailing,9)

                                }
                                HStack{
                                    Text("Sub Total:")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black.opacity(0.5))
                                        .padding(.leading,9)
                                    Spacer()
                                    Text(" USD \(CheckoutProductItemResponseModel.subtotal ?? "")")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black)
                                        .padding(.trailing,9)

                                }
                                HStack{
                                    Text("Wallet Discount:")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black.opacity(0.5))
                                        .padding(.leading,9)
                                    Spacer()
                                    Text("USD \(CheckoutProductItemResponseModel.walletAmountApplied ?? "")")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black)
                                        .padding(.trailing,9)

                                }
                                HStack{
                                    Text("Delivery Charges:")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black.opacity(0.5))
                                        .padding(.leading,9)
                                    Spacer()
                                    Text("USD \(CheckoutProductItemResponseModel.totalshipping ?? "")")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black)
                                        .padding(.trailing,9)

                                }
                                Rectangle()
                                    .frame(width: UIScreen.main.bounds.width-40,height: 1,alignment: .center)
                                    .foregroundColor(Color.gray.opacity(0.6))
                                HStack{
                                    Text("Total:")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black.opacity(0.5))
                                        .padding(.leading,9)
                                    Spacer()
                                    Text("USD \(CheckoutProductItemResponseModel.grandtotal ?? "" )")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black)
                                        .padding(.trailing,9)

                                }.padding(.bottom,9)
                                    .padding(.top,9)
                                
                            }.frame(width: UIScreen.main.bounds.width-20,alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(6)
                            Text("Payment Method")
                                .font(.system(size: 16).bold())
                                .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                .padding(.leading,12)
                            if(AddType == "cod"){
                                
                            } else if (AddType == "online"){
                                
                            }
                            VStack{
                                HStack{
                                   Image("dollar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30,height: 30)
                                        .padding(.leading,9)
                                    Text("Cash On Delivery")
                                        .font(.system(size: 14).bold())
                                    Spacer()
                                    Image(systemName: "circle")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color.black)
                                        .overlay(
                                            Image(systemName: "circle.fill")
                                                //.foregroundColor(A1[0])
                                                .foregroundColor(AddType == "cod" ?Color.blue:Color("Background").opacity(0.3) )

                                        )
                                        .padding(.trailing,12)
                                        .onTapGesture {
                                            AddType = "cod"
                                            
                                            A1 = [Color.blue, Color("Background").opacity(0.3)]
                                           
                                        }
                                }
                            }.frame(width: UIScreen.main.bounds.width-20,height: 58,alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(6)
                            
                            
                            VStack{
                                HStack{
                                   Image("mastercard")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                      
                                        .frame(width: 50,height: 30)
                                        .padding(.leading,9)
                                    Text("Pay Online or Credit/Debit Card")
                                        .font(.system(size: 14).bold())
                                    Spacer()
                                    Image(systemName: "circle")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color.black)
                                        .overlay(
                                            Image(systemName: "circle.fill")
                                                .foregroundColor(AddType == "online" ?Color.blue :Color("Background").opacity(0.3))

                                        )
                                        .padding(.trailing,12)
                                        .onTapGesture {
                                            let a = Double(CheckoutProductItemResponseModel.walletAmountApplied ?? "")
                                            let b = Double(CheckoutProductItemResponseModel.grandtotal ?? "" )
                                            let c = Double(b ?? 0.0)-Double(a ?? 0.0)
                                            if c == 0.00{
                                                print("c\(c)")
                                            }else{
                                                print("d\(c)")
                                                AddType = "online"

                                                A1 = [ Color("Background").opacity(0.3),Color.blue]
                                            }

                                           
                                        }
                                }
                            }.frame(width: UIScreen.main.bounds.width-20,height: 58,alignment: .leading)
                                .background(Color.white)
                                .cornerRadius(6)
                            
                            
                            
                            
                            
                            
                        }
                    }
                    
                    
                    
                    Spacer()
                    Button(action: {
                        if isApplyWallet == "0"{
                            PlaceOrderApi(AddressID: "\(NetworkManager.getDefaultAddressId())", orderValue: "\(CheckoutProductItemResponseModel.grandtotal ?? "" )", paymentMethod: "\(AddType)", totalQuantity: "\(CheckoutProductItemResponseModel.totalquantity ?? "")", deliveryInstuction: "\(CheckoutProductItemResponseModel.address ?? "" )", ShipPrice: "\(CheckoutProductItemResponseModel.totalshipping ?? "")", walletAmountApplied: "\(CheckoutProductItemResponseModel.userwalletamount ?? "")", walletAmountRemaining: "\(CheckoutProductItemResponseModel.walletAmountRemaining ?? "")", isWalletApplied: "\(isApplyWallet)")
                            CheckoutCompletedisPresent = true
                        }else if isApplyWallet == "1"{
                            PlaceOrderApi(AddressID: "\(NetworkManager.getDefaultAddressId())", orderValue: "\(CheckoutProductItemResponseModel.grandtotal ?? "" )", paymentMethod: "\(AddType)", totalQuantity: "\(CheckoutProductItemResponseModel.totalquantity ?? "")", deliveryInstuction: "\(CheckoutProductItemResponseModel.address ?? "" )", ShipPrice: "\(CheckoutProductItemResponseModel.totalshipping ?? "")", walletAmountApplied: "\(CheckoutProductItemResponseModel.grandtotal ?? "")", walletAmountRemaining: "\(CheckoutProductItemResponseModel.walletAmountRemaining ?? "")", isWalletApplied: "\(isApplyWallet)")
                            CheckoutCompletedisPresent = true
                        }




                       
                    }, label: {
                        VStack{
                            Text("Pay USD \(CheckoutProductItemResponseModel.grandtotal ?? "" )")
                                .font(.system(size: 20).bold())
                                .frame(width: UIScreen.main.bounds.width-20,height: 58)
                                .background(Color("backColor"))
                                .cornerRadius(6)
                                .foregroundColor(Color.white)
                                .padding(.bottom,20)
                        }
                        .padding(.bottom,20)
                    }).fullScreenCover(isPresented: $CheckoutCompletedisPresent){
                        if AddType == "cod"{
                            OrderCompletedUIView()
                        }else if AddType == "online"{
                            paymentPage(placedOrderJsonResponse: $placedOrderJson)
                        }
                    }
                    
                }
                if self.showLoader{
                    GeometryReader{_ in
                        Loader()
                    }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                       
                }
            }
          
            
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                OrderReviewApi( AddressID: "\(NetworkManager.getDefaultAddressId())", ApplyWallet: "0")
                //MyAddressApi(Customerid: NetworkManager.getUserId())
                showLoader = true
            }
    }
    func OrderReviewApi(AddressID:String,ApplyWallet:String){
        let parameters = [
            "basketid":NetworkManager.getBasketID(),
            "addressid":AddressID,
            "customerid":NetworkManager.getUserId(),
            "is_apply_wallet":ApplyWallet
        ]
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "order-review", parameters: parameters) { responseData in
            print(" Chechout Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "400"{
            }else if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(OrderReviewResponse.self, from:responseData)
                CheckoutProductItemResponseModel = postResponse
                print(" Checkout is Response:\(CheckoutProductItemResponseModel)")
                isChecked = false
                showLoader = false
                let a = Double(CheckoutProductItemResponseModel.walletAmountApplied ?? "")
                let b = Double(CheckoutProductItemResponseModel.grandtotal ?? "" )
                let c = Double(b ?? 0.0)-Double(a ?? 0.0)
                if c == 0.00{
                    AddType = "cod"
                    A1 = [ Color("Background").opacity(0.3),Color.blue]
                }
            }
        }
        
    }
    func PlaceOrderApi(AddressID:String,orderValue:String,paymentMethod:String,totalQuantity:String,deliveryInstuction:String,ShipPrice:String,walletAmountApplied:String,walletAmountRemaining:String,isWalletApplied:String){
        let parameters = [
            "basketid":NetworkManager.getBasketID(),
            "addressid":AddressID,
            "order_value":orderValue,
            "payment_method":paymentMethod,
            "total_quantity":totalQuantity,
            "delivery_instuction":deliveryInstuction,
            "shipprice":ShipPrice,
            "wallet_amount_applied":walletAmountApplied,
            "wallet_amount_remaining":walletAmountRemaining,
            "is_apply_wallet":isWalletApplied,
            "customerid":NetworkManager.getUserId(),
//            "is_apply_wallet":"",
//            "wallet_amount_applied":"",
//            "wallet_amount_remaining":""

        ]
        print("parameter  is :\(parameters)")
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "place-order", parameters: parameters) { responsejson in
            print("Response : ", responsejson)
            placedOrderJson = responsejson
            if placedOrderJson["status"].stringValue == "200"{
                UserDefaults.standard.set("", forKey: "BasketID")
                
            }
//            let postResponse = try! JSONDecoder().decode(OrderReviewResponse.self, from:responseData)
//            CheckoutProductItemResponseModel = postResponse
//            print(" Home Response:\(CheckoutProductItemResponseModel)")
            
            
            
        }
        
    }
   
    
}

//struct CheckoutPageUIView_Previews: PreviewProvider {
//    static var previews: some View {
//       // CheckoutPageUIView( CheckoutProductItemResponseModel: Binding<CartProductResponse>)
//        ChangeAddress( TempAddressId: .constant("0"))
//    }
//}
struct paymentPage:View{
    @Environment(\.presentationMode) var presentationMode
    @Binding var placedOrderJsonResponse: JSON
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                       Image(systemName: "chevron.backward")
                            .font(.system(size: 20))
                            .padding(.leading,12)
                            .padding(.top,48)
                            .foregroundColor(Color.white)
                    }
                    Text("Payment")
                        .font(.system(size: 20).bold())
                        //.padding(.l,20)
                        .padding(.top,48)
                    Text("\("https://www.zvatada.com/api/online-payment-redirect?payment_method=online&total_amount=\(placedOrderJsonResponse["total_amount"].doubleValue)&address_id=\(placedOrderJsonResponse["address_id"].intValue)&delivery_instuction=\(placedOrderJsonResponse["delivery_instuction"].intValue)&codcharge=\(placedOrderJsonResponse["codcharge"].doubleValue)&shipprice=\(placedOrderJsonResponse["shipprice"].doubleValue)&total_quantity=\(placedOrderJsonResponse["total_quantity"].intValue)&basket_id=\(placedOrderJsonResponse["basket_id"].intValue)&customer_id=\(placedOrderJsonResponse["customer_id"].intValue)&is_apply_wallet=\(placedOrderJsonResponse["is_apply_wallet"].intValue)&wallet_amount_applied=\(placedOrderJsonResponse["wallet_amount_applied"].doubleValue)&wallet_amount_remaining=\(placedOrderJsonResponse["wallet_amount_remaining"].doubleValue)")")
                        .font(.system(size: 8))
                    Spacer()
                    Image("Asset 4")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 100,height: 20)
                        .padding(.top,48)
                        .padding(.trailing,20)
                   
                    
                }.frame(width: UIScreen.main.bounds.width,height: 100)
                .background(Color("backColor"))
                .foregroundColor(Color.white)
              //  WebView(urlString: "https://www.zvatada.com/api/online-payment-redirect?order_id=\(placedOrderJsonResponse["order_id"].intValue)&url=\(placedOrderJsonResponse["url"].stringValue)")
                WebView(urlString: "https://www.zvatada.com/api/online-payment-redirect?payment_method=online&total_amount=\(placedOrderJsonResponse["total_amount"].doubleValue)&address_id=\(placedOrderJsonResponse["address_id"].intValue)&delivery_instuction=\(placedOrderJsonResponse["delivery_instuction"].intValue)&codcharge=\(placedOrderJsonResponse["codcharge"].doubleValue)&shipprice=\(placedOrderJsonResponse["shipprice"].doubleValue)&total_quantity=\(placedOrderJsonResponse["total_quantity"].intValue)&basket_id=\(placedOrderJsonResponse["basket_id"].intValue)&customer_id=\(placedOrderJsonResponse["customer_id"].intValue)&is_apply_wallet=\(placedOrderJsonResponse["is_apply_wallet"].intValue)&wallet_amount_applied=\(placedOrderJsonResponse["wallet_amount_applied"].doubleValue)&wallet_amount_remaining=\(placedOrderJsonResponse["wallet_amount_remaining"].doubleValue)")
              //  Text("https://www.zvatada.com/api/online-payment-redirect?payment_method=online&total_amount=\(placedOrderJsonResponse["total_amount"].intValue)&address_id=\(placedOrderJsonResponse["address_id"].intValue)&delivery_instuction=\(placedOrderJsonResponse["delivery_instuction"].intValue)&codcharge=\(placedOrderJsonResponse["codcharge"].intValue)&shipprice=\(placedOrderJsonResponse["shipprice"].intValue)&total_quantity=\(placedOrderJsonResponse["total_quantity"].intValue)&basket_id=\(placedOrderJsonResponse["basket_id"].intValue)&customer_id=\(placedOrderJsonResponse["customer_id"].intValue)")
                Spacer()
            }
          
        }.edgesIgnoringSafeArea(.all)
    }
}
struct ChangeAddress :View{
    @Environment(\.presentationMode) var presentationMode
    @State var checkoutisPresent = false
    @Binding var TempAddressId:String
    @AppStorage("AddressId") var AddressId: String = ""
    //@State var AddressResponseModel : MyAddressResponse
    @Binding var AddressResponse:JSON
    @State var showToast = false
    @State var errorTost = 0
    var body: some View{
        //ZStack{
            VStack{
                
                addressView( AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []), addressId: $TempAddressId)
                    .padding(.top,40)
                
                VStack{
                    Button(action: {
                        if NetworkManager.getDefaultAddress() == ""{
                            showToast = true
                            errorTost = 1
                        }else if NetworkManager.getDefaultAddress() == ""{
                            showToast = true
                            errorTost = 2
                        }else{
                            checkoutisPresent = true
                            showToast = false
                        }
                       
                    }, label: {
                        Text("Confirm")
                            .font(.system(size: 24).bold())
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width-40,height: 56)
                            .background(Color("backColor"))
                            .cornerRadius(6)
                            .padding(.bottom,20)
                    }).fullScreenCover(isPresented: $checkoutisPresent){
                        CheckoutPageUIView( CheckoutProductItemResponseModel: OrderReviewResponse(status: "", msg: "", walletAmountApplied: "", walletAmountRemaining: "", subtotal: "", totalshipping: "", userwalletamount: "", totalquantity: "", grandtotal: "", name: "", address: "", addresstype: "", zipcode: "", mobileno: "", buildingName: "", city: "", data: []),  TempAddressId: "", AddressResponse: $AddressResponse)
                    }.padding(.bottom,20)
                
                }
//                    Button(action: {
//
//                        checkoutisPresent = true
//                    }, label: {
//                        Text("Confirm")
//                            .font(.system(size: 24).bold())
//                            .foregroundColor(Color.white)
//                            .frame(width: UIScreen.main.bounds.width-40,height: 56)
//                            .background(Color("backColor"))
//                            .cornerRadius(6)
//                            .padding(.bottom,20)
//                    }).fullScreenCover(isPresented: $checkoutisPresent){
//                        CheckoutPageUIView( CheckoutProductItemResponseModel: OrderReviewResponse(status: "", msg: "", walletAmountApplied: "", walletAmountRemaining: "", subtotal: "", totalshipping: "", userwalletamount: "", totalquantity: "", grandtotal: "", name: "", address: "", addresstype: "", zipcode: "", mobileno: "", buildingName: "", city: "", data: []),  TempAddressId: "")
//                    }
                
            }
            .edgesIgnoringSafeArea(.all)
            .frame(height: UIScreen.main.bounds.height)
            .present(isPresented: self.$showToast, type: .toast, position: .bottom) {
                self.createTopToastView(errorMsg: "")
               
             }
        //}.edgesIgnoringSafeArea(.all)
    }
    func MakeDefaultAddressApi(Addressid:String){
        let parameters = [
            "id":Addressid,
            "customerid":NetworkManager.getUserId()

        ]
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "mark-default-address", parameters: parameters) { responseData in
            print(" Delete Response : ", responseData)

           // MyAddressApi(Customerid: NetworkManager.getUserId())


        }

    }
    func createTopToastView(errorMsg:String) -> some View {
           VStack {
               Spacer()
               HStack {
                   if errorTost == 1 {
                       Text("Please Add Address & set Default Address")
                           .foregroundColor(.white)
                           .font(.custom("Roboto-Regular", size: 14))
                           .padding(.leading,20)
                   }else if errorTost == 2{
                       Text("Please selsect default")
                           .foregroundColor(.white)
                           .font(.custom("Roboto-Regular", size: 14))
                           .padding(.leading,20)
                   }
                   Text("\(errorMsg)")
                       .foregroundColor(.white)
                       .font(.custom("Roboto-Regular", size: 14))
                       .padding(.leading,20)
                   //Spacer()
                   Text("")
                       .font(.system(size: 12))
                       .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
               } .frame(width: UIScreen.main.bounds.width-20, height: 50,alignment: .center)
                   .background(Color.red)
                   .cornerRadius(12)
                   .padding(.bottom,100)
           }
       }
    
}
