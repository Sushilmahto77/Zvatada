//
//  MyOrderUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

import SwiftUI
import SwiftyJSON
struct MyOrderUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var MyOrderResponseModel:MyOrderResponse
    @State var DataFound = 0
    @State var HomePageisPresent = false
    @State var showLoader = false
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                VStack{
                    VStack{
                        HStack{
                            Button(action: {
                                HomePageisPresent = true
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.white)
                                    .padding(.top,48)
                            }).fullScreenCover(isPresented: $HomePageisPresent){
                                ContentView()
                            }
                            .padding(.leading,24)
                           Text("All Order")
                                .font(.system(size: 24).bold())
                                .foregroundColor(Color.white)
                            .padding(.top,48)
                            
                            
                            Spacer()
                            Button(action: {
                                HomePageisPresent = true
                            }, label: {
                                VStack{
                                    //Image("Plain blue on white version")
                                    Image("out")
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
                if (DataFound == 2){
                  
                    orderListUIView(MyOrderListResponseModel: $MyOrderResponseModel, TempOrderId: "")
                }else if (DataFound == 1){
                   
                    NoOrder()
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
                MyOrderApi(emailId: NetworkManager.getUserEmail())
                showLoader = true
            }
        
    }
    func MyOrderApi(emailId:String){
        let parameters = [
            "email":emailId,
            "status":""
        ]
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "my-orders", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "400"{
                DataFound = 1
            }else if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(MyOrderResponse.self, from:responseData)
                MyOrderResponseModel = postResponse
                print(" Home Response:\(MyOrderResponseModel)")
                if MyOrderResponseModel.status == "200"{
                    if ((MyOrderResponseModel.data?.isEmpty) != nil){

                        DataFound = 2
                        showLoader = false
                    }else{
                        DataFound = 1
                        showLoader = false
                    }
                }else {
                    DataFound = 1
                    showLoader = false

                }
            }

        }
        
    }
}

struct MyOrderUIView_Previews: PreviewProvider {
    static var previews: some View {
       // MyOrderUIView( MyOrderResponseModel: MyOrderResponse(status: "", msg: "", data: []))
        NoOrder()
       // orderListUIView()
    }
}

struct NoOrder:View{
  @State var homeisPresent = false
    var body: some View{
        ZStack {
            Color("backColor1")
            VStack(spacing: 5){
               
                Image("OrderNot")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .padding(.top,120)
                Text("No Post Order Found!")
                    .font(.system(size: 16).bold())
                    .padding(.top,9)
                Text("There is nothing in your orders. Let's add some items.")
                    .font(.system(size: 16))
                    .foregroundColor(Color.gray)
                    .frame(width: 310)
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action: {
                    homeisPresent = true
                }, label: {
                    HStack{
                       
                        Text("Explore")
                            .font(.system(size: 32).bold())
                            .foregroundColor(Color.white)
                    }.frame(width: UIScreen.main.bounds.width-30,height: 72)
                    .background(Color("backColor"))
                    .cornerRadius(6)
                    .padding(.bottom,40)
                    
                }).fullScreenCover(isPresented: $homeisPresent, content: {
                    ContentView()
                })

            }.background( Color("backColor1"))
        }.edgesIgnoringSafeArea(.all)
    }
}
struct orderListUIView :View{
    @Binding var MyOrderListResponseModel:MyOrderResponse
    @State var TempOrderId :String
    @State var orderDetailPresent = false
    var body: some View{
        ZStack {
            Color("backColor1")
            VStack{
                ScrollView(.vertical,showsIndicators: false){
                    ForEach(MyOrderListResponseModel.data ?? []){item in
                        
                        VStack{
                            HStack {
                                VStack {
                                    AsyncImage(url: URL(string: "\(item.productimage)")) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 120)
                                        
                                        
                                    } placeholder: {
                                        Image("user (1)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 120)
                                            .cornerRadius(25)
                                            .padding(.leading,20)
                                            .padding(.top,10)
                                    }
                                    
                                }
                                VStack(alignment: .leading){
                                    Text("\(item.productname ?? "")")
                                        .font(.system(size: 14).bold())
                                        .foregroundColor(Color.black)
                                        
                                    Text("qty : \(item.quantity ?? "")")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.black.opacity(0.5))
                                    Text("USD \(item.sellingprice ?? "")")
                                        .font(.system(size: 14).bold())
                                        .foregroundColor(Color.blue)
                                    HStack{
                                        Text("Order ID : ")
                                            .font(.system(size: 14).bold())
                                            .foregroundColor(Color.black.opacity(0.5))
                                        Text("\(item.orderid)")
                                            .font(.system(size: 14).bold())
                                            .foregroundColor(Color.black)
                                        Spacer()
                                    }
                                    //Text("Order ID : \(item.orderid)")
                                }
                                Spacer()
                            }
                            HStack{
                                VStack(alignment: .leading){
                                    Text("\(item.orderdate)")
                                        .font(.system(size: 14))
                                        .padding(.leading,9)
                                    Text("\(item.approveStatus)")
                                        .font(.system(size: 14))
                                        .padding(.leading,9)
                                        .foregroundColor(item.approveStatus == "New Order" ? Color.blue:Color.red)
                                }
                                Spacer()
                                Button(action: {
                                    TempOrderId = item.orderid
                                    orderDetailPresent = true
                                }, label: {
                                    Text("View Details")
                                        .font(.system(size: 14).bold())
                                        .frame(width: 100,height: 30)
                                        .background(Color("backColor"))
                                        .cornerRadius(6)
                                        .padding(.trailing,12)
                                        .foregroundColor(Color.white)
                                }).fullScreenCover(isPresented: $orderDetailPresent){
                                    OrderDetailsUIView(orderID: $TempOrderId, TempProductID: "")
                                }
                              
                            }
                            Spacer()
                            
                        }.frame(width: UIScreen.main.bounds.width-20,height: 180)
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding(.top,12)
                    }
                   
                }
            }
        }
    }
}
