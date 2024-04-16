//
//  AddressPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 08/11/22.
//

import SwiftUI
import SwiftyJSON
struct addressView:View{
    @AppStorage("AddressId") var AddressId: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State var AddressResponseModel : MyAddressResponse
    @State var DataFound = 0
    @State var HomePageisPresent = false
    @State private var showingAlert = false
    @State var AddAddressisPresent = false
    @State var showLoader = false
    @State var AddressAddisPresent = false
    @State var mapAddress:String = ""
    @Binding var addressId:String
    var body: some View{
        ZStack{
            Color("backColor1")
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
                    Text("My Address")
                        .font(.system(size: 20).bold())
                        //.padding(.l,20)
                        .padding(.top,48)
                    Spacer()
                    Button(action: {
                        HomePageisPresent = true
                    }, label: {
                        Image("Plain blue on white version")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 100,height: 20)
                            .padding(.top,48)
                            .padding(.trailing,20)
                    }).fullScreenCover(isPresented: $HomePageisPresent){
                        ContentView()
                    }
                   
                   
                    
                }.frame(width: UIScreen.main.bounds.width,height: 100)
                .background(Color("backColor"))
                .foregroundColor(Color.white)
                if DataFound == 2{
                   // AddAddressPage()
                    VStack{
                        Button(action: {
                            AddressAddisPresent = true
                        }, label: {
                            HStack{
                                Image(systemName: "plus")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.black.opacity(0.5))
                                Text("Add a New address")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color.black.opacity(0.5))
                            }.frame(width: UIScreen.main.bounds.width-30,height: 48)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.blue.opacity(0.8),lineWidth: 2)
                                    )
                            .cornerRadius(6)
                            .padding(.top,40)
                        }).fullScreenCover(isPresented: $AddressAddisPresent,onDismiss: {
                          MyAddressApi(Customerid: NetworkManager.getUserId())
                        }){
                            EditAddressPageUIView( MapAddress: $mapAddress, tempAddressID: "")
                        }
                    }
                }else if DataFound == 1{
                    //AddressPageUIView( AddressDataResponseModel: $AddressResponseModel)
                    VStack{
                        VStack{
                            
                            ScrollView(.vertical,showsIndicators: false){
                                ForEach(AddressResponseModel.data){ item in
                                    //UserDefaults.standard.set(item.id, forKey: "AddressID")
                                    VStack{
                                        VStack{
                                            HStack{
                                                //
                                                Text("\(item.addresstype ?? "")")
                                                    .font(.system(size: 14).bold())
                                                    .padding(.leading,9)
                                                if item.defaultAddress == "1"{
                                                    Text("Default")
                                                        .font(.system(size: 14))
                                                        .padding(.all,2)
                                                        .padding(.leading,9)
                                                        .padding(.trailing,9)
                                                        .background(Color.blue)
                                                        .cornerRadius(30)
                                                        .foregroundColor(Color.white)
                                                }else{
                                                    
                                                }
                                                
                                                Spacer()
                                                
                                            }.padding(.top,9)
                                            VStack(alignment: .leading, spacing: 0){
                                         
                                                Text("\(item.name ?? "")")
                                                    .font(.system(size: 14).bold())
                                                    .padding(.leading,9)
                                               
                                                Text("\(item.mobileno ?? "")")
                                                    .font(.system(size: 14))
                                                    .padding(.leading,9)
                                                    .foregroundColor(Color.black.opacity(0.6))
                                            
                                                Text("\(item.buildingName  ?? "")")
                                                    .font(.system(size: 14))
                                                    .padding(.leading,9)
                                                    .foregroundColor(Color.black.opacity(0.6))
                                              
                                        }.frame(width: UIScreen.main.bounds.width-20,alignment: .leading)
                                        
                                        HStack(spacing: 20){
                                            Button(action: {
                                                AddAddressisPresent = true
                                            }, label: {
                                                Text("Edit Address")
                                                    .font(.system(size: 14).bold())
                                                    .frame(width: UIScreen.main.bounds.width / 2.1 - 20,height: 40)
                                                    .background(Color.blue.opacity(0.4))
                                                    .cornerRadius(6)
                                                
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 6)
                                                            .stroke(Color.blue.opacity(0.4), lineWidth: 1)
                                                    ).padding(.leading,10)
                                            }).fullScreenCover(isPresented: $AddAddressisPresent){
                                                EditAddressPageUIView( MapAddress: $mapAddress, tempAddressID: "")
                                            }
                                            
                                            Button(action: {
                                                showingAlert = true
                                                DeleteAddressApi(Addressid: "\(item.id)")
                                            }, label: {
                                                Text("Delete Address")
                                                    .font(.system(size: 14).bold())
                                                    .frame(width: UIScreen.main.bounds.width / 2.1 - 20,height: 40)
                                                    .background(Color.white.opacity(0.4))
                                                    .cornerRadius(6)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 6)
                                                            .stroke(Color.red, lineWidth: 1)
                                                    )
                                                    .foregroundColor(Color.red)
                                                    .padding(.trailing,10)
                                            })
//                                            .alert("Are you sure you want to Delete?", isPresented: $showingAlert) {
//                                                Button("Cancel") { }
//                                                Button("Yes") {
//
//                                                }
//
//                                            }
                                            
                                            
                                            
                                        }.padding(.top,9)
                                            .padding(.bottom,12)
                                    }

                                        VStack{
                                            if (item.defaultAddress == "1"){
                                                
                                            }else if (item.defaultAddress == "0"){
                                                Button(action: {
                                                    let AddressIDis = item.id
                                                    UserDefaults.standard.set(AddressIDis,forKey: "DefaultAddressId")
                                                
                                                    UserDefaults.standard.set(item.name,forKey: "DefaultName")
                                                    UserDefaults.standard.set(item.mobileno,forKey: "DefaultNumber")
                                                    UserDefaults.standard.set(item.address,forKey: "DefaultAddress")
                                                    UserDefaults.standard.set(item.addresstype,forKey: "userType")
                                                    UserDefaults.standard.set(item.defaultAddress,forKey: "isdefaultAddress")
                                                    
                                                    MakeDefaultAddressApi(Addressid: "\(item.id)")
                                                    AddressId = item.defaultAddress ?? ""
                                                    addressId = AddressId
                                                }, label: {
                                                    VStack{
                                                        Text("Set Default Address")
                                                            .font(.system(size: 16).bold())
                                                        
                                                    }.frame(width: UIScreen.main.bounds.width-40,height: 40)
                                                        .background(Color("backColor"))
                                                        .cornerRadius(6)
                                                        .foregroundColor(Color.white)
                                                    .padding(.bottom,8)
                                                    
                                                })
                                            }
                                            
                                        }
                                        
                                    }.frame(width: UIScreen.main.bounds.width-20)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .padding(.top,12)
                                }
                              Button(action: {
                                  AddAddressisPresent = true
                              }, label: {
                                  HStack{
                                      Image(systemName: "plus")
                                          .font(.system(size: 18))
                                          .foregroundColor(Color.black.opacity(0.5))
                                      Text("Add a New address")
                                          .font(.system(size: 18))
                                          .foregroundColor(Color.black.opacity(0.5))
                                  }.frame(width: UIScreen.main.bounds.width-30,height: 48)
                                      .background(
                                          RoundedRectangle(cornerRadius: 6)
                                              .stroke(Color.blue.opacity(0.8),lineWidth: 2)
                                          )
                                  .cornerRadius(6)
                                  .padding(.top,40)
                              }).fullScreenCover(isPresented: $AddAddressisPresent, onDismiss: {
                                  MyAddressApi(Customerid: NetworkManager.getUserId())
                                 // addressView( AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []))
                                 // presentationMode.wrappedValue.dismiss()
                              }){
                                  EditAddressPageUIView( MapAddress: $mapAddress, tempAddressID: "")
                              }
                                
                            }
                        }
                        Spacer()
        //                HStack{
        //
        //                    Text("Confirm")
        //                        .font(.system(size: 24).bold())
        //                        .foregroundColor(Color.white)
        //                }.frame(width: UIScreen.main.bounds.width-30,height: 58)
        //                .background(Color("backColor"))
        //                .cornerRadius(6)
        //                .padding(.bottom,40)
                    }
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
                self.MyAddressApi(Customerid: NetworkManager.getUserId())
                showLoader = true
                //MakeDefaultAddressApi(Addressid: "\(addressId)")
            }
    }
    func DeleteAddressApi(Addressid:String){
        let parameters = [
            "id":Addressid

        ]
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "delete-address", parameters: parameters) { responseData in
            print(" Delete Response : ", responseData)
            MyAddressApi(Customerid: NetworkManager.getUserId())
              showLoader = false


        }

    }
    func MakeDefaultAddressApi(Addressid:String){
        let parameters = [
            "id":Addressid,
            "customerid":NetworkManager.getUserId()

        ]
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "mark-default-address", parameters: parameters) { responseData in
            print(" Delete Response : ", responseData)

            MyAddressApi(Customerid: NetworkManager.getUserId())


        }

    }
    func MyAddressApi(Customerid:String){
        let parameters = [
            "customerid":Customerid
           
        ]
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "my-addresses", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "200"{
               // UserDefaults.standard.set(responseData["data"]["id"].stringValue, forKey: "DefaultAddressId")
               // UserDefaults.standard.set(item.id,forKey: "DefaultAddressId")
                if swiftyJsonVar["data"].count > 0 {
                    let postResponse = try! JSONDecoder().decode(MyAddressResponse.self, from:responseData)
                    AddressResponseModel = postResponse
                    DataFound = 1
                    showLoader = false
                    
                }else{
                    DataFound = 2
                    showLoader = false
                }
            }else{
                DataFound = 2
                showLoader = false
            }
                    
          //  UserDefaults.standard.set(AddressResponseModel.data.id, forKey: "UserID")
            
        }
        
    }
}

//struct AddressPageUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddressPageUIView( AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []))
//    }
//}

/*struct AddAddressPage:View{
    @State var AddressAddisPresent = false
    var body: some View{
        VStack{
            Button(action: {
                AddressAddisPresent = true
            }, label: {
                HStack{
                    Image(systemName: "plus")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black.opacity(0.5))
                    Text("Add a New address")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black.opacity(0.5))
                }.frame(width: UIScreen.main.bounds.width-30,height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.blue.opacity(0.8),lineWidth: 2)
                        )
                .cornerRadius(6)
                .padding(.top,40)
            }).fullScreenCover(isPresented: $AddressAddisPresent, content: {
                EditAddressPageUIView()
            })
        }
    }
}*/
