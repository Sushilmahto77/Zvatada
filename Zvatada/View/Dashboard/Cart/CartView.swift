//
//  CartView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
struct CartView: View {
    @State var DataFound = 0
    @State var CartProductListResponseModel:CartProductResponse
    @State var homeisPresent = false
    @State var AddressResponseModel : JSON = []
    @State var counter = 1
    @State var qtycounter :String = ""
    @State var CheckoutisPresent = false
    @State var CheckoutAddressisPresent = false
    @State var SearchisPresent = false
    @State var CheckoutProductItemResponseModel:OrderReviewResponse
    @State var showLoader = false
    @State var TempAddressId:String
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                VStack{
                    HStack{
//                        Button(action: {
//                            homeisPresent = true
//                        }, label: {
//                            Image(systemName: "chevron.left")
//                                .font(.system(size: 20).bold())
//                                .foregroundColor(Color.black.opacity(0.6))
//                                .padding(.top,48)
//                                .padding(.leading,20)
//                        }).fullScreenCover(isPresented: $homeisPresent, content: {ContentView()})
                       Spacer()
                        HStack{
                            Image("Plain blue on white version")
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(width: 200,height:200)
                        }
                       .frame(width: 200,height: 50)
                        .padding(.top,48)
                        Spacer()
                    }
//                   Image("Grey logo version 1")
//                        .resizable()
//                        .aspectRatio( contentMode: .fit)
//                        .frame(width: 200,height: 50)
//                        .padding(.top,48)
                    Button(action: {
                        SearchisPresent = true
                    }, label: {
                        VStack{
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.black.opacity(0.6))
                                    .padding(.leading,12)
                                Text("Search for what you are looking for")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.black.opacity(0.8))
                                Spacer()
                            }
                        }.frame(width: UIScreen.main.bounds.width-20,height: 48)
                            .background(Color.white)
                            .cornerRadius(6)
                            .shadow(color: .black.opacity(0.2), radius: 2)
                    }).fullScreenCover(isPresented: $SearchisPresent){
                        SearchPageUIView(CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCatId: "")
                    }
                   
                }
                
               // ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        if (DataFound == 2){
                            CartEmptyView()
                          
                        }else if(DataFound == 1){
                            VStack{
                                Text("My Cart")
                                    .font(.system(size: 20).bold())
                                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                    .padding(.leading,20)
                                ScrollView(.vertical,showsIndicators: false){
                                    ForEach(CartProductListResponseModel.data){item in
                                        // var qtycounter = item.qty
                                        VStack{
                                            VStack{
                                                HStack{
                                                    VStack(alignment: .leading,spacing: 0){
                                                        Text("\(item.productname ?? "")")
                                                            .font(.system(size: 14))
                                                            .foregroundColor(Color.gray)
                                                            .lineLimit(3)
                                                        
                                                            .frame(width: 200,height: 38,alignment: .leading)
                                                            .padding(.top,5)
                                                         //   .background(Color.yellow)
                                                        HStack{
                                                            Text("USD")
                                                                .font(.system(size: 16))
                                                                //.padding(.leading,9)
                                                            Text("\(item.productSellingprice ?? "")")
                                                                .font(.system(size: 16).bold())
                                                            Spacer()
                                                        } .frame(width: 200, alignment: .leading)
                                                            .padding(.top,5)
                                                        HStack{
                                                            Text("~USD \(item.productMrp ?? "")~ ")
                                                                .font(.system(size: 14))
                                                                //.padding(.leading,9)
                                                            Spacer()
                    //                                        Text("Aug 20, 2022")
                    //                                            .font(.system(size: 15).bold())
                    //                                            .foregroundColor(Color.green)
                                                        } .frame(width: 200, alignment: .leading)
                                                       Spacer()
                                                    }.frame(width: 200)
                                                        .padding(.leading,12)
                                                    VStack{
                                                        VStack {
                                                            AsyncImage(url: URL(string: "\(item.imageurl ?? "")")) { image in
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
                                                HStack{
                                                    HStack (spacing:15){
                                                        Button(action: {
                                                            //qtycounter = ""
                                                           //self.counter -= 1
                                                            UpdateQTYApi(TypeQty: "minus", Basketid: "\(item.id ?? "")")
                                                            
                                                        }){
                                                            Image(systemName: "minus")
                                                                .font(.system(size: 16, weight: .heavy))
                                                                //.padding(.leading,5)
                                                                .foregroundColor(Color.black)
                                                                .frame(width: 25,height: 25,alignment: .center)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 6)
                                                                        .stroke(Color.gray,lineWidth: 2)
                                                                    )
                                                                .cornerRadius(6)
                                                                
                                                        }//.allowsHitTesting(counter > 1 ? false:true)
                                                        Text("\(item.qty ?? "" )")
                                                            .font(.system(size: 20))
                                                            .foregroundColor(Color.black)
                                                           // .padding(.vertical,5)
                                                            //.padding(.horizontal,10)
                                                            //.background(Color.black.opacity(0.06))
                                                        
                                                        Button(action: {
                                                           // qtycounter = "minus"
                                                            //self.counter += 1
                                                            UpdateQTYApi(TypeQty: "add",Basketid: "\(item.id ?? "")")
                                                            
                                                        }){
                                                            Image(systemName: "plus")
                                                                .font(.system(size: 16, weight: .heavy))
                                                                .foregroundColor(Color.black)
                                                                .frame(width: 25,height: 25,alignment: .center)
                                                               // .background(Color.green)
                                                                .background(
                                                                    RoundedRectangle(cornerRadius: 6)
                                                                        .stroke(Color.gray,lineWidth: 2)
                                                                    )
                                                                .cornerRadius(6)
                                                                
                                                        }//.allowsHitTesting(counter > 1 ? false:true)
                                                        
                                                        
                                                        
                                                    }.background(Color.white)
                                                        .cornerRadius(5)
                                                        //.shadow(color: Color.gray, radius: 1, x: 0.2, y: 0.2)
                                                    .padding(.bottom,9)
                                                    .padding(.leading,10)
                                                    Spacer()
                                                    Button(action: {
                                                        DeleteItemApi(itemID: "\(item.id ?? "")")
                                                    }, label: {
                                                        HStack{
                        //
                                                            Image(systemName: "trash")
                                                            Text("Remove")
                                                                .font(.system(size: 14))
                                                                .padding(.trailing,6)
                                                            
                                                        }
                                                    })
                                                   
                                                }.padding(.bottom,9)
                                            }.frame(width: UIScreen.main.bounds.width-20,height: 160)
                                                .background(Color.white)
                                                .cornerRadius(6)
                                        }
                                    }
                                    
                                }
                                Spacer()
                                VStack{
                                    Button(action: {
                                        if AddressResponseModel["data"][0]["default_address"].stringValue == "0"{
                                            CheckoutAddressisPresent = true
                                        }else{
                                            OrderReviewApi( AddressID: "\(AddressResponseModel["data"][0]["id"].stringValue)", ApplyWallet: "0")
                                        }
                                    }, label: {
                                        HStack{
                                            Text("Go to Checkout")
                                                .font(.system(size: 20).bold())
                                                .foregroundColor(Color.white)
                                                .padding(.leading,12)
                                            Spacer()
                                            Text("USD \(CartProductListResponseModel.grandtotal)")
                                                .font(.system(size: 18))
                                                .padding(.all,6)
                                                .frame(height: 24,alignment: .center)
                                                .background(Color.yellow)
                                                .foregroundColor(Color.black)
                                                .cornerRadius(6)
                                             
                                                .padding(.trailing,12)
                                            
                                        }.frame(width: UIScreen.main.bounds.width-20,height: 58,alignment: .center)
                                            .background(Color("backColor"))
                                            .cornerRadius(6)
                                            .padding(.bottom,80)
                                    }).fullScreenCover(isPresented: $CheckoutAddressisPresent){
                                        ChangeAddress( TempAddressId: $TempAddressId, AddressResponse: $AddressResponseModel)
                                        //addressView( AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []))
                                    }
                                    .fullScreenCover(isPresented: $CheckoutisPresent){
                                       
                                        CheckoutPageUIView( CheckoutProductItemResponseModel: OrderReviewResponse(status: "", msg: "", walletAmountApplied: "", walletAmountRemaining: "", subtotal: "", totalshipping: "", userwalletamount: "", totalquantity: "", grandtotal: "", name: "", address: "", addresstype: "", zipcode: "", mobileno: "", buildingName: "", city: "", data: []),  TempAddressId: "", AddressResponse: $AddressResponseModel)
                                       
                                 
                                    }
                                        
                                   
                                }
                            }
                        }
                    }
               // }
                Spacer()
            }
            if self.showLoader{
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                   
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                CartProductApi(basketID: "\(NetworkManager.getBasketID())")
                showLoader = true
                self.MyAddressApi(Customerid: NetworkManager.getUserId())
               // OrderReviewApi( AddressID: "\(NetworkManager.getDefaultAddressId())", ApplyWallet: "0")
            }
    }
    func DeleteItemApi(itemID:String){
        let parameters = [
            "id":itemID,
          
        ]
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "delete-basket", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
            CartProductApi(basketID: "\(NetworkManager.getBasketID())")
           // ProductDetailsApi(basketID: NetworkManager.getBasketID())
            
        }

    }
    func UpdateQTYApi(TypeQty:String,Basketid:String){
        let parameters = [
            "basketid":Basketid,
            "type":TypeQty
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "update-quantity", parameters: parameters) { responseData in
            print("Response : ", responseData)
            CartProductApi(basketID: "\(NetworkManager.getBasketID())")
           // ProductDetailsApi(basketID: "\(NetworkManager.getBasketID())")
  
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
                if CheckoutProductItemResponseModel.address == nil{
                    CheckoutAddressisPresent = true
                    //CheckoutisPresent = true
                }else {
                    CheckoutisPresent = true
                }
            }
            
        }
        
    }
    func CartProductApi(basketID:String){
        let parameters = [
            "basketid":basketID,
           

        ]


        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "cart-products", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(CartProductResponse.self, from:responseData)
                CartProductListResponseModel = postResponse
                print(" Cart Product Response:\(CartProductListResponseModel)")
                DataFound = 1
                showLoader = false
//                if CartProductListResponseModel.data.isEmpty{
//                    DataFound = 2
//                }else{
//                    DataFound = 1
//                }
            }else{
                DataFound = 2
                showLoader = false
            }
            
           
        }

    }
    func MyAddressApi(Customerid:String){
        let parameters = [
            "customerid":Customerid
           
        ]
        NetworkManager.postRequestUsingLoginToken(remainingUrl: "my-addresses", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
             let postResponse = responseJson
                    AddressResponseModel = postResponse
                    print("Address Data \(AddressResponseModel)")
            let AddressIDis = AddressResponseModel["data"][0]["id"].stringValue
            UserDefaults.standard.set(AddressIDis,forKey: "DefaultAddressId")
        
            UserDefaults.standard.set(AddressResponseModel["data"][0]["name"].stringValue,forKey: "DefaultName")
            UserDefaults.standard.set(AddressResponseModel["data"][0]["mobileno"].stringValue,forKey: "DefaultNumber")
            UserDefaults.standard.set(AddressResponseModel["data"][0]["default_address"].stringValue,forKey: "DefaultAddress")
            UserDefaults.standard.set(AddressResponseModel["data"][0]["addresstype"].stringValue,forKey: "userType")
           // UserDefaults.standard.set(item.defaultAddress,forKey: "isdefaultAddress")
            MakeDefaultAddressApi(Addressid: "\(AddressResponseModel["data"][0]["id"].stringValue)")
//
                    
          //  UserDefaults.standard.set(AddressResponseModel.data.id, forKey: "UserID")
            
        }
        
    }
    func MakeDefaultAddressApi(Addressid:String){
        let parameters = [
            "id":Addressid,
            "customerid":NetworkManager.getUserId()

        ]
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "mark-default-address", parameters: parameters) { responseData in
            print(" Response : ", responseData)

           // MyAddressApi(Customerid: NetworkManager.getUserId())


        }

    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}

struct CartEmptyView:View{
   @State var HomeisPresent = false
    var body: some View{
        VStack(spacing: 0){
            Text("My Cart")
                .font(.system(size: 20).bold())
                .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                .padding(.leading,20)
            Image("cartImage")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width,alignment: .center)
            Text("Hey, it feels so light!")
                .font(.system(size: 16).bold())
            Text("There is nothing in your bag.Let's add some items.")
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
                .padding(.top,6)
           Spacer()
            Button(action: {
                HomeisPresent = true
            }, label: {
                VStack{
                    Text("Explore")
                        .font(.system(size: 25).bold())
                        .foregroundColor(Color.white)
                }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                .background(Color("backColor"))
                .cornerRadius(6)
                .padding(.bottom,100)
            }).fullScreenCover(isPresented: $HomeisPresent, content: {ContentView()})
           
        }
    }
}


