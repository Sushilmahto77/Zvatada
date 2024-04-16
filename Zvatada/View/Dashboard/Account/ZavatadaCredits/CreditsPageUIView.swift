//
//  CreditsPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 08/11/22.
//

import SwiftUI
import SwiftyJSON
struct CreditsPageUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var DataFound = 0
    @State var CreditResponde :WalletHistoryModel
    @State var HomePageisPresent = false
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                HStack{
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24))
                            .foregroundColor(Color.black)
                            .padding(.top,48)
                        .padding(.leading,20)
                        Text("Zvatada Credits")
                            .font(.system(size: 18).bold())
                            .foregroundColor(Color.black)
                            .padding(.top,48)
                    }
                    Spacer()
                    Button(action: {
                        HomePageisPresent = true
                    }, label: {
                        VStack{
                            Image("Plain blue on white version")
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(width: 80,height:140)
                                .padding(.trailing,12)

                            
                               
                        }.frame(width: 80,height:30)
                            .padding(.top,48)
                            .padding(.trailing,20)
                           // .background( Color.red)
                    }).fullScreenCover(isPresented: $HomePageisPresent){
                        ContentView()
                    }
                   
                   // Spacer()
                }
                if DataFound == 0{
                    VStack{
                        VStack(spacing: 0){
                            Text("Wallet balance")
                                .font(.system(size: 14))
                                .padding(.top,12)
                            HStack {
                                Text("USD")
                                    .font(.system(size: 18).bold())
                                .padding(.top,12)
                                Text("0.00")
                                    .font(.system(size: 28).bold())
                                .padding(.top,12)
                            }
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width-60,height: 95)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray.opacity(0.4),lineWidth: 2)
                                )
                    }.padding(.top,20)
                    VStack{
                        Image("Group")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 76,height: 65)
                            .padding(.top,99)
                    }
                    VStack(spacing: 20){
                        Text("You dont have any zvatada Credits yet.")
                             Text(" They will be displayed here once you get them.")
                             Text("You can use your credits to pay for your items at checkout.")
                    }.frame(width: 256)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16))
                        .padding(.top,9)
                }else if DataFound == 1{
                    VStack{
                        VStack(spacing: 0){
                            Text("Wallet balance")
                                .font(.system(size: 14))
                                .padding(.top,12)
                            HStack {
                                Text("USD")
                                    .font(.system(size: 18).bold())
                                .padding(.top,12)
                                Text("0.00")
                                    .font(.system(size: 28).bold())
                                .padding(.top,12)
                            }
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width-60,height: 95)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray.opacity(0.4),lineWidth: 2)
                                )
                    }.padding(.top,20)
                    VStack{
                        Image("Group")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 76,height: 65)
                            .padding(.top,99)
                    }
                    VStack(spacing: 20){
                        Text("You dont have any zvatada Credits yet.")
                             Text(" They will be displayed here once you get them.")
                             Text("You can use your credits to pay for your items at checkout.")
                    }.frame(width: 256)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16))
                        .padding(.top,9)
                    
                }else if DataFound == 2{
                    VStack{
                        ScrollView{
                            VStack{
                                VStack{
                                    Text("Wallet Balance")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.black.opacity(0.6))
                                        .padding(.top,12)
                                        .padding(.bottom,9)
                                    HStack{
                                        Text("USD")
                                            .font(.system(size: 16))
                                            .foregroundColor(Color.black)
                                            
                                            .padding(.bottom,9)
                                        Text("\(CreditResponde.walletAmount ?? "")")
                                            .font(.system(size: 20).bold())
                                            .foregroundColor(Color.black)
                                        
                                            .padding(.bottom,9)
                                    }
                                }.frame(width: UIScreen.main.bounds.width-30)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.blue.opacity(0.3),lineWidth: 1)
                                    ).padding(.all,2)
                                    .padding(.top,20)
                                Text("Recent Wallet Transactions")
                                    .font(.system(size: 16).bold())
                                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                    .padding(.leading,20)
                                    .padding(.top,12)
                                ForEach(CreditResponde.data){item in
                                    VStack(spacing: 9){
                                        HStack{
                                            Text("Transaction Number:")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color.black.opacity(0.5))
                                                .padding(.leading,12)
                                            Text("\(item.orderID ?? "")")
                                                .font(.system(size: 16).bold())
                                                .foregroundColor(Color("backColor"))
                                            Spacer()
                                        }
                                        if item.credit == "" {
                                            HStack{
                                                Text("Debit:")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color.black.opacity(0.5))
                                                    .padding(.leading,12)
                                                Text("USD \(item.debit)")
                                                    .font(.system(size: 16).bold())
                                                    .foregroundColor(Color("backColor"))
                                                Spacer()
                                                Text("Date:")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color.black.opacity(0.5))
                                                Text("\(item.adddate)")
                                                    .font(.system(size: 16).bold())
                                                    .foregroundColor(Color.black)
                                                    .padding(.trailing,12)
                                            }
                                        }else{
                                            HStack{
                                                Text("Credit:")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color.black.opacity(0.5))
                                                    .padding(.leading,12)
                                                Text("USD \(item.credit)")
                                                    .font(.system(size: 16).bold())
                                                    .foregroundColor(Color("backColor"))
                                                Spacer()
                                                Text("Date:")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color.black.opacity(0.5))
                                                Text("\(item.adddate)")
                                                    .font(.system(size: 16).bold())
                                                    .foregroundColor(Color.black)
                                                    .padding(.trailing,12)
                                            }
                                        }
                                     
                                        
                                    }.frame(width: UIScreen.main.bounds.width-20,height: 70)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                
                
                
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                if NetworkManager.getUserId() == ""{
                    
                }else{
                    WallethistoryApi()
                }
            }
    }
    
    func WallethistoryApi(){
        let parameters = [
            "customerid":NetworkManager.getUserId(),
        ]
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "wallet-history", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "400"{
            }else if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(WalletHistoryModel.self, from:responseData)
                CreditResponde = postResponse
                print(" Home Response:\(CreditResponde)")
                if CreditResponde.status == "200"{
                    DataFound = 2

                }else {
                    DataFound = 1


                }
            }



        }

    }
    /*func WallethistoryApi(){
        let parameters = [
            "customerid":NetworkManager.getUserId(),
        
          
        ]
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "wallet-history", parameters: parameters) { responseJson in
            print(" Wallet Response : ", responseJson)
            CreditResponde = responseJson
            if CreditResponde["msg"].stringValue == "No Record found"{
                DataFound = 1
            }else{
                DataFound = 2
            }
        }
        
    }*/
}

struct CreditsPageUIView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsPageUIView( CreditResponde: WalletHistoryModel(status: "", msg: "", walletAmount: "", data: []))
    }
}
struct creditUIView :View{
    var body: some View{
        ZStack{
            
        }
    }
}
