//
//  AccountUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI

struct AccountUIView: View {
    @State var wishListPresent = false
    @State var MyorderisPresent = false
    @State var AddressisPresent = false
    @State var EditProfileisPresent = false
    @State var CreditisPresent = false
    @State private var SignUpisPresented = false
    @State private var showingAlert = false
    @State var tempAddressId :String
    @State var LoginPageisPresent = false
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                HStack{
                    Spacer()
                    VStack{
                        Image("Plain blue on white version")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 200,height:200)
                            //.background(.red)
                            
                    }.padding(.leading,58)
                    Spacer()
                    VStack{
                        if NetworkManager.getUserId() == ""{
                           
                         Button(action: {
                            // SignUpisPresented = true
                             showingAlert = true
                         }, label: {
                             HStack{
                                 Text("Log In")
                                     .foregroundColor(Color("AccentColor"))
                                     .font(.system(size: 14).bold())
                                     //.padding(.top,20)
                                    
                                    
                             }.frame(width: 48,alignment: .trailing)
                                 .padding(.trailing,12)
                                // .background(.white)
                         })
                           // ContentView()
                        }
                    }
                    
                    
                }
                .frame(width: UIScreen.main.bounds.width,height: 50)
                .padding(.top,48)
                VStack(spacing: 0){
                    Text("Hello, \(NetworkManager.getUserName())")
                        .font(.system(size: 20).bold())
                        .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                        .padding(.leading,20)
                    Text("\(NetworkManager.getUserEmail())")
                        .font(.system(size: 12))
                        .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                        .padding(.leading,20)
                    ScrollView(.vertical,showsIndicators: false){
                        
                    
                    VStack{
                        Text("MY ACCOUNT")
                            .font(.system(size: 16))
                            .padding(.leading,12)
                        
                    }.frame(width: UIScreen.main.bounds.width,height: 45,alignment: .leading)
                        .background(Color("backColor2")).padding(.top,12)
                    VStack(spacing: 0){
                        Button(action: {
                            wishListPresent = true
                        }, label: {
                            HStack{
                                Image("wishlistIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 33,height: 33)
                                Text("Wishlist")
                                    .font(.system(size: 16).bold())
                                    .foregroundColor(Color.black)
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                                .foregroundColor(Color.black)
                        }).fullScreenCover(isPresented: $wishListPresent){
                            WishListUIView( WishListResponseModel: WishListResponse(status: "", msg: "", totalWishlist: 0, data: []), TempProductID: "")
                        }
                       
                        
                        Rectangle().frame(width: UIScreen.main.bounds.width-20,height: 1)
                            .foregroundColor(Color.gray.opacity(0.4))
                        Button(action: {
                            MyorderisPresent = true
                        }, label: {
                            HStack{
                                Image("ordersIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 33,height: 33)
                                Text("Orders")
                                    .font(.system(size: 16).bold())
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                                .foregroundColor(Color.black)
                        }).fullScreenCover(isPresented: $MyorderisPresent){
                            MyOrderUIView(MyOrderResponseModel: MyOrderResponse(status: "", msg: "", data: []))
                        }
                      
                        
                        Rectangle().frame(width: UIScreen.main.bounds.width-20,height: 1)
                            .foregroundColor(Color.gray.opacity(0.4))
                        Button(action: {
                            CreditisPresent = true
                        }, label: {
                            HStack{
                                Image("creditsIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 33,height: 33)
                                Text("Zvatada Credits")
                                    .font(.system(size: 16).bold())
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                                .foregroundColor(Color.black)
                        }).fullScreenCover(isPresented: $CreditisPresent){
                            CreditsPageUIView(CreditResponde: WalletHistoryModel(status: "", msg: "", walletAmount: "", data: []))
                        }
                        
                        
                        Rectangle().frame(width: UIScreen.main.bounds.width-20,height: 1)
                            .foregroundColor(Color.gray.opacity(0.4))
                        Button(action: {
                            if NetworkManager.getUserId() == ""{
                               
                              LoginPageisPresent = true
                               // ContentView()
                            }else{
                                AddressisPresent = true
                            }
                        
                        }, label: {
                            HStack{
                                Image("addressesIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 33,height: 33)
                                Text("Addresses")
                                    .font(.system(size: 16).bold())
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                                .foregroundColor(Color.black)
                        }).fullScreenCover(isPresented: $AddressisPresent){
                            addressView( AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []), addressId: $tempAddressId)
                            
                        } .alert("Log in for the best experience", isPresented: $LoginPageisPresent) {
                            Button("Cancel") { }
                            Button("Log in") {
                                SignUpisPresented = true
                              
                               
                            }
                            
                        }
                            
                       
                        
                        Rectangle().frame(width: UIScreen.main.bounds.width-20,height: 1)
                            .foregroundColor(Color.gray.opacity(0.4))
                        Button(action: {
                            EditProfileisPresent = true
                        }, label: {
                            HStack{
                                Image("userIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 33,height: 33)
                                Text("Profile")
                                    .font(.system(size: 16).bold())
                                Spacer()
                                Image(systemName: "chevron.forward")
                            }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                                .foregroundColor(Color.black)
                        }).fullScreenCover(isPresented: $EditProfileisPresent){
                            EditProfileUIView()
                        }
                       
                        VStack{
                            Text("REACH OUT TO US")
                                .font(.system(size: 16))
                                .padding(.leading,12)
                            
                        }.frame(width: UIScreen.main.bounds.width,height: 45,alignment: .leading)
                            .background(Color("backColor2"))//.padding(.top,12)
                        
                    }
                    VStack(spacing: 0){
                        Link(destination: URL(string: "https://www.zvatada.com/pages/faqs")!) {
                            HStack{
                                Image("Ellipse 582")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(width: 33,height: 33)
                                    .overlay(
                                        Image("help")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20,height: 20)
                                    )
                             
//                                    .background(Color.black)
//                                    .cornerRadius(16.5)
                           
                                
                                Text("Help")
                                    .font(.system(size: 16).bold())
                                    .foregroundColor(Color.black)
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(Color.black)
                            }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                        }
                       
                        Rectangle().frame(width: UIScreen.main.bounds.width-20,height: 1)
                            .foregroundColor(Color.gray.opacity(0.4))
                        if NetworkManager.getUserId() == ""{}else{
                            Button(action: {
                                showingAlert = true
                            }, label: {
                                HStack{
                                    Image("Ellipse 582")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 33,height: 33)
                                    //.font(.system(size: 33))
                                        .overlay(
                                            Image(systemName: "power")
                                                .foregroundColor(Color.red)
                                        )
                                    //                                .resizable()
                                    //                                .aspectRatio(contentMode: .fit)
                                    //                                .frame(width: 33,height: 33)
                                        .foregroundColor(Color.black.opacity(0.4))
                                    Text("Sign out")
                                        .font(.system(size: 16).bold())
                                        .foregroundColor(Color.red)
                                    Spacer()
                                    
                                }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                                
                            }).fullScreenCover(isPresented: $SignUpisPresented){
                                LoginPageUIView()
                            }
                            .alert("Are you sure you want to Logout?", isPresented: $showingAlert) {
                                Button("Cancel") { }
                                Button("Yes") {
                                    SignUpisPresented = true
                                    if let bundleID = Bundle.main.bundleIdentifier {
                                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
                                    }
                                }
                                
                            }
                            
                            Rectangle().frame(width: UIScreen.main.bounds.width-20,height: 1)
                                .foregroundColor(Color.gray.opacity(0.4))
                        }
                        
                    }.fullScreenCover(isPresented: $SignUpisPresented){
                        LoginPageUIView()
                    }
                    .alert("Are you sure you want to Logout?", isPresented: $showingAlert) {
                        Button("Cancel") { }
                        Button("Yes") {
                            SignUpisPresented = true
                            if let bundleID = Bundle.main.bundleIdentifier {
                                UserDefaults.standard.removePersistentDomain(forName: bundleID)
                            }
                        }
                        
                    }
                        VStack{
                            
                            
                            HStack{
                               
                                Link(destination: URL(string: "https://facebook.com/zvatada")!) {
                                    Image("facebook-color-icon 1")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 10,height: 10)
                                }
                                Spacer()
                               
                                Link(destination: URL(string: "https://twitter.com/zvatada")!) {
                                    Image("twitter-color-icon 1")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 10,height: 10)
                                }
                                Spacer()
                              
                                Link(destination: URL(string: "https://instagram.com/zvatada_business")!) {
                                    Image("black-instagram-icon 1")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 10,height: 10)
                                }
                            }.frame(width: 200,height: 15,alignment: .center)
                            //.padding(.top,34)
                            VStack{
                                HStack{
                                   
                                    Link(destination: URL(string: "https://www.zvatada.com/pages/terms-of-use")!) {
                                        Text("Terms Of Use")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.black)
                                            .padding(.trailing,20)
                                    }
                                   
                                    Link(destination: URL(string: "https://www.zvatada.com/pages/terms-of-sale")!) {
                                        Text("Terms Of Sale")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.black)
                                            .padding(.trailing,20)
                                    }
                                   
                                    Link(destination: URL(string: "https://www.zvatada.com/pages/warranty-policy")!) {
                                        Text("Privacy Policy")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.black)
                                            .padding(.trailing,20)
                                    }
                                    
                                }.font(.system(size: 12))
                                HStack{
                                    
                                    Link(destination: URL(string: "https://www.zvatada.com/pages/warranty-policy")!) {
                                        Text("Warranty Policy")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.black)
                                            .padding(.trailing,20)
                                    }
                                    Link(destination: URL(string: "https://www.zvatada.com/pages/warranty-policy")!) {
                                        Text(" Return Policy")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.black)
                                            .padding(.trailing,20)
                                    }
                                   
                                }.font(.system(size: 12))
                                Text("© 2022 ZVATADA. All rights reserved")
                                    .font(.system(size: 12))
                            }.frame(width: UIScreen.main.bounds.width,height: 45,alignment: .center)
                            
                            Spacer()
                        }.frame(width: UIScreen.main.bounds.width,height: 112,alignment: .leading)
                            .padding(.bottom,60)
                    
                    
                }
                Spacer()
               
            }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct AccountUIView_Previews: PreviewProvider {
    static var previews: some View {
        AccountUIView( tempAddressId: "")
    }
}
