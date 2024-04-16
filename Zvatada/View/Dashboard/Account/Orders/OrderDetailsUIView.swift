//
//  OrderDetailsUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 21/11/22.
//

import SwiftUI
import SwiftyJSON
struct OrderDetailsUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var orderDetailsResponse :JSON = []
    @Binding var orderID :String
    @State var HomePageisPresent = false
    @State var showLoader = false
    @State var TempProductID:String
    @State var orderPageisPresent = false
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                VStack{
                    VStack{
                        HStack{
                            Button(action: {
                                
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.white)
                                    .padding(.top,48)
                                //.padding(.leading,20)
                            }
                            .padding(.leading,24)
                           Text("Order Details")
                                .font(.system(size: 24).bold())
                                .foregroundColor(Color.white)
                            .padding(.top,48)
                            
                            
                            Spacer()
                            Button(action: {
                                HomePageisPresent = true
                            }, label: {
                                VStack{
                                    Image("Plain blue on white version")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 109,height: 40)
                                        .padding(.trailing,20)
                                    
                                        .padding(.top,48)
                                }
                                
                            }).fullScreenCover(isPresented: $HomePageisPresent){
                                ContentView()
                            }
                        }
                        
                        
                    }
                    
                }.frame(width: UIScreen.main.bounds.width,height: 120)
                    .background(Color("backColor"))
                
                VStack(alignment: .leading,spacing: 5){
                    HStack{
                        Text("Order ID :\(orderDetailsResponse["data"]["orderid"].stringValue) ")
                            .font(.system(size: 16).bold())
                            .padding(.leading,6)
                        Spacer()
                        Text("\(orderDetailsResponse["data"]["approve_status"].stringValue)")
                            .font(.system(size: 12))
                            .frame(width: 100,height: 24)
                            .background(Color("backColor"))
                            .cornerRadius(12)
                            .foregroundColor(Color.white)
                            .padding(.trailing,6)
                    }.padding(.top,9)
                    Text("Place On \(orderDetailsResponse["data"]["orderdate"].stringValue)")
                        .font(.system(size: 14))
                        .padding(.leading ,6)
                    Text("Payment Type : \(orderDetailsResponse["data"]["payment_mode"].stringValue)")
                        .font(.system(size: 14).bold())
                        .padding(.leading ,6)
                        .padding(.bottom,9)
                }.frame(width: UIScreen.main.bounds.width-20,alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(6)
                Text("Product Details")
                    .font(.system(size: 16).bold())
                    .padding(.leading ,12)
                    .frame(width: UIScreen.main.bounds.width,height: 20,alignment: .leading)
                    
                HStack{
                    Button(action: {
                        orderPageisPresent = true
                        TempProductID = orderDetailsResponse["data"]["productid"].stringValue
                    }, label: {
                        VStack {
                            AsyncImage(url: URL(string: "\(orderDetailsResponse["data"]["productimage"].stringValue)")) { image in
                                image.resizable()
                                    .frame(width: 100,height: 100,alignment: .center)
                                    .aspectRatio(contentMode: .fill)
                                    .padding(.top,12)
                                     .padding(.bottom,12)
                                
                                
                            } placeholder: {
                                VStack{
                                    Image("Banner1")
                                        .resizable()
                                        .frame(width: 100,height: 100,alignment: .center)
                                        .aspectRatio(contentMode: .fill)
                                        .padding(.top,12)
                                         .padding(.bottom,12)
                                        
                                }.frame(width: 100,height: 100,alignment: .center)
                                    .background(Color.gray)
                                    .padding(.leading,12)
                                
                            }
                            
                        }.padding(.top,12)
                            .padding(.bottom,12)
                    }).fullScreenCover(isPresented: $orderPageisPresent){
                        orderDetailsPageUIView(ProductDetailsResponseModel: ProductDetailsResponse(status: "", msg: "", brandname: "", sellername: "", sellerID: "", productname: "", productDetailsResponseDescription: "", specification: "", discountPercent: "", sizeID: "", productMrp: "", productSellingprice: "", slug: "", isFavorite: 0, cartquantity: "", variants: [], sizes: [], cashbacks: [], images: [], reviews: [], similarproducts: [], attributes: [], totalReview: 0, averageRatting: 0, totalquatity: ""), productIdTemp: $TempProductID)
                    }
                 
                    VStack(alignment: .leading,spacing: 8){
                       Text("\(orderDetailsResponse["data"]["productname"].stringValue)")
                            .font(.system(size: 14).bold())
                            .multilineTextAlignment(.leading)
                            .frame(width: 210,height: 34,alignment: .leading)
                        Text("Qty:\(orderDetailsResponse["data"]["quantity"].stringValue)")
                            .font(.system(size: 14))
                            .foregroundColor(Color.black.opacity(0.5))
                        Text("USD \(orderDetailsResponse["data"]["sellingprice"].stringValue)")
                            .font(.system(size: 16).bold())
                            .foregroundColor(Color("backColor"))
                        Spacer()
                    }.padding(.top,5)
                }.frame(width: UIScreen.main.bounds.width-20,height: 120,alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.top,12)
                VStack{
                    Text("Price Summary")
                        .font(.system(size: 16).bold())
                        .padding(.leading ,12)
                        .frame(width: UIScreen.main.bounds.width,height: 20,alignment: .leading)
                        .padding(.top,9)
                        .padding(.leading,8)
                        .foregroundColor(Color("backColor"))
                    HStack{
                        Text("Sub Total:")
                            .font(.system(size: 14))
                            .padding(.leading,8)
                            .foregroundColor(Color.black.opacity(0.5))
                        Spacer()
                        Text("USD \(orderDetailsResponse["data"]["sellingprice"].stringValue)")
                            .font(.system(size: 14))
                            //.foregroundColor(Color("backColor"))
                            .padding(.trailing,12)
                    }
                    HStack{
                        Text("Wallet Discount:")
                            .font(.system(size: 14))
                            .padding(.leading,8)
                            .foregroundColor(Color.black.opacity(0.5))
                        Spacer()
                        Text("USD \(orderDetailsResponse["data"]["walletused"].stringValue)")
                            .font(.system(size: 14))
                            //.foregroundColor(Color("backColor"))
                            .padding(.trailing,12)
                    }
                    HStack{
                        Text("Delivery Charges:")
                            .font(.system(size: 14))
                            .padding(.leading,8)
                            .foregroundColor(Color.black.opacity(0.5))
                        Spacer()
                        Text("USD \(orderDetailsResponse["data"]["shipprice"].stringValue)")
                            .font(.system(size: 14))
                            //.foregroundColor(Color("backColor"))
                            .padding(.trailing,12)
                    }
                    Rectangle().frame(width: UIScreen.main.bounds.width-40,height: 1,alignment: .center)
                        .foregroundColor(.gray.opacity(0.4))
                    HStack{
                        Text("Total :")
                            .font(.system(size: 14))
                            .padding(.leading,8)
                            .foregroundColor(Color.black.opacity(0.5))
                        Spacer()
                        let myString = "\(orderDetailsResponse["data"]["sellingprice"].stringValue)"
                        let myFloat = (myString as NSString).floatValue
                      
                        let selling = "\(orderDetailsResponse["data"]["shipprice"].stringValue)"
                        let myFloat1 = (selling as NSString).floatValue
                        let totalP = myFloat + myFloat1
                        //Text("USD \(totalP.clean)")
                        Text("USD \(orderDetailsResponse["data"]["ordervalue"].stringValue)")
                            .font(.system(size: 16).bold())
                            //.foregroundColor(Color("backColor"))
                            .padding(.trailing,12)
                    }
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width-20,height: 120)
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.top,12)
                Text("Delivery Address")
                    .font(.system(size: 16).bold())
                    .padding(.leading ,12)
                    .frame(width: UIScreen.main.bounds.width,height: 20,alignment: .leading)
                VStack(alignment: .leading){
                    Text("\(orderDetailsResponse["data"]["deliver_name"].stringValue)")
                        .font(.system(size: 14).bold())
                        .frame(width: UIScreen.main.bounds.width-20,height: 20,alignment: .leading)
                        .padding(.leading,12)
                    Text("\(orderDetailsResponse["data"]["deliver_phone"].stringValue)")
                        .font(.system(size: 14).bold())
                        .frame(width: UIScreen.main.bounds.width-20,height: 20,alignment: .leading)
                        .padding(.leading,12)
                    HStack{
                        
                    }
                    Text("\(orderDetailsResponse["data"]["deliver_name"].stringValue),\(orderDetailsResponse["data"]["building_address"].stringValue),\(orderDetailsResponse["data"]["deliver_city"].stringValue)")
                        .font(.system(size: 14).bold())
                        .frame(width: UIScreen.main.bounds.width-20,alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .padding(.leading,12)
                }.frame(width: UIScreen.main.bounds.width-20,height: 120)
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.top,12)
                if orderDetailsResponse["data"]["approve_status"].stringValue == "New Order"{
                    Button(action: {
                        UpdateorderApi(Orderid: "\(orderID)")
                    }, label: {
                        Text("Cancel Order")
                            .frame(width: UIScreen.main.bounds.width-20,height: 48,alignment: .center)
                            .background(Color.red)
                            .cornerRadius(6)
                            .foregroundColor(Color.white)
                            .padding(.top,12)
                    })
                 
                }else {
                   
                }
                Spacer()
            }
            if self.showLoader{
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                   
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                OrderDetailsApi(Orderid: "\(orderID)")

            }
    }
    func OrderDetailsApi(Orderid:String){
        let parameters = [
            "orderid":Orderid,
          
        ]
        showLoader = true
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "order-details", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
            orderDetailsResponse = responseJson
            print(" Order Detail Response : ", orderDetailsResponse)
            showLoader = false
            
        }
        
    }
    func UpdateorderApi(Orderid:String){
        let parameters = [
            "oid":Orderid,
            "status":"Cancelled"
          
        ]
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "update-order", parameters: parameters) { responseJson in
            print(" Update Response : ", responseJson)
            OrderDetailsApi(Orderid: "\(orderID)")
            showLoader = false
//            orderDetailsResponse = responseJson
//            print(" Order Detail Response : ", orderDetailsResponse)
            
        }
        
    }
}

//struct OrderDetailsUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderDetailsUIView( orderID: <#Binding<String>#>)
//    }
//}
extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.2f", self) : String(self)
    }
}
