//
//  EditAddressPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 08/11/22.
//

import SwiftUI
import MapKit
struct EditAddressPageUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var SignUpisPresented = false
    @State private var TypeAddress: String = ""
    @State private var FName: String = ""
    @State private var Mobile: String = ""
    @State private var Name: String = ""
    @State private var FullAddress: String = ""
    @State private var State: String = ""
    @State private var City: String = ""
    @State private var Pin: String = ""
    @State private var Building: String = ""
    @State var HomePageisPresent = false
    @State var AdType = "Home"
    @State var A1 = [Color.blue, Color.gray.opacity(0.0), Color.gray.opacity(0.0)]
    @State var AddressListPresent = false
    @State var AddressMapisPresent = false
    @State var showLoader = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
   // @StateObject var locationViewModel = LocationViewModel()
   // @EnvironmentObject var locationViewModel: LocationViewModel
    @State var checktost = false
    @State var errorCount = 0
    @Binding var MapAddress:String
    @State var tempAddressID:String
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
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
                    ScrollView(.vertical,showsIndicators: false){
                        VStack{
                            VStack(alignment: .leading, spacing: 0){
                                VStack {
                                    if(AdType == "Home"){
                                        
                                    } else if (AdType == "Office"){
                                        
                                    } else if (AdType == "Other"){
                                        
                                    }
                                    
                                    Text("Select Address Type")
                                        .font(.system(size: 16).bold())
                                        .padding(.top,9)
                                        .padding(.bottom,9)
                                        .padding(.leading,10)
                                    
                                }
                                HStack{
                                    HStack {
                                        Image(systemName: "circle")
                                            .font(.system(size: 24))
                                            .foregroundColor(Color.black)
                                            .overlay(
                                                Image(systemName: "circle.fill")
                                                    .foregroundColor(A1[0])
                                                
                                            )
                                            .padding(.leading,20)
                                        
                                        Text("Home")
                                            .font(.system(size: 14).bold())
                                    }.onTapGesture {
                                        AdType = "Home"
                                        
                                        A1 = [Color.blue, Color("Background").opacity(0.3), Color("Background").opacity(0.3)]
                                        
                                    }
                                    
                                    Spacer()
                                    HStack {
                                        Image(systemName: "circle")
                                            .font(.system(size: 24))
                                            .foregroundColor(Color.black)
                                            .overlay(
                                                Image(systemName: "circle.fill")
                                                    .foregroundColor(A1[1])
                                            )
                                        
                                        Text("Office")
                                            .font(.system(size: 14).bold())
                                    }.onTapGesture {
                                        AdType = "Office"
                                        
                                        A1 = [Color("Background").opacity(0.3), Color.blue, Color("Background").opacity(0.3)]
                                        
                                    }
                                    Spacer()
                                    HStack {
                                        Image(systemName: "circle")
                                            .font(.system(size: 24))
                                            .foregroundColor(Color.black)
                                            .overlay(
                                                Image(systemName: "circle.fill")
                                                    .foregroundColor(A1[2])
                                            )
                                        
                                        Text("Other")
                                            .font(.system(size: 14).bold())
                                    }.onTapGesture {
                                        AdType = "Other"
                                        
                                        A1 = [Color("Background").opacity(0.3), Color("Background").opacity(0.3), Color.blue]
                                        
                                    }
                                    Spacer()
                                    
                                }
                                .padding(.top,9)
                                // .padding(.bottom,9)
                            }.frame(width: UIScreen.main.bounds.width-10, alignment: .leading)
                                .foregroundColor(Color.black)
                            
                            
                            VStack{
                                
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Full Name")
                                        .font(.system(size: 14).bold())
                                        .frame(width: 80, height: 20)
                                        .padding(.leading,10)
                                        .padding(.top,9)
                                        .padding(.bottom,9)
                                    
                                    TextField(
                                        "Enter Full Name",
                                        text: $FName)
                                    .padding(.all)
                                    .font(.system(size: 14).bold())
                                    .frame(width: UIScreen.main.bounds.width-20, height: 56)
                                    .background(Color.white)
                                    .cornerRadius(6)
                                    .disableAutocorrection(true)
                                }.frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Mobile")
                                        .font(.system(size: 14).bold())
                                        .frame(width: 50, height: 20)
                                        .padding(.leading,10)
                                        .padding(.top,9)
                                        .padding(.bottom,9)
                                    TextField(
                                        "Enter Mobile Number",
                                        text: $Mobile)
                                    .padding(.all)
                                    .font(.system(size: 14).bold())
                                    .frame(width: UIScreen.main.bounds.width-20, height: 56)
                                    .background(Color.white)
                                    .keyboardType(.numberPad)
                                    .cornerRadius(6)
                                    .disableAutocorrection(true)
                                    .onChange(of: Mobile, perform: { value in
                                        Mobile = String(Mobile.prefix(10))
                                        
                                    })
                                    
                                }.frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Full Address")
                                        .font(.system(size: 14).bold())
                                        .frame(width: 150, height: 20,alignment: .leading)
                                        .padding(.leading,10)
                                        .padding(.top,9)
                                        .padding(.bottom,9)
                                    VStack{
                                        
//                                        Text("\(MapAddress)")
//                                            .frame(width: 337)
                                        HStack{
                                            // var FullAddress = "\(locationViewModel.currentPlacemark?.description ?? "")"
                                            TextField(
                                                "Enter Full Address",
                                                text: $MapAddress)
//                                            TextField(
//                                                "Enter Full Address",
//                                                text: $FullAddress)
                                            .font(.system(size: 14).bold())
                                            .font(.system(size: 14).bold())
                                            .frame(width:250, height: 56)
                                            .padding(.horizontal,8)
                                            .multilineTextAlignment(.leading)
                                            .cornerRadius(6)
                                            .padding(.bottom,30)
                                            .disableAutocorrection(true)
                                            Spacer()
                                            Button(action: {
                                                AddressMapisPresent = true
                                            }, label: {
                                                VStack{
                                                    Map(coordinateRegion: $region)
                                                        .frame(width: 60, height: 60)
                                                }.frame(width: 58,height: 58)
                                                    .background(Color.yellow)
                                                    .cornerRadius(6)
                                                    .padding(.trailing,12)
                                            }).sheet(isPresented: $AddressMapisPresent){
                                               // MapAddressUIView()
                                                MapAddressUIView()
                                            }
                                            
                                        }
                                    }.frame(width: UIScreen.main.bounds.width-20,height: 90, alignment: .leading)
                                        .background(Color.white)
                                        .cornerRadius(6)
                                    
                                    
                                }.frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("City")
                                        .font(.system(size: 14).bold())
                                        .frame(width: 40, height: 20)
                                        .padding(.leading,10)
                                        .padding(.top,9)
                                        .padding(.bottom,9)
                                    TextField(
                                        "Enter City",
                                        text: $City)
                                    .padding(.all)
                                    .font(.system(size: 14).bold())
                                    .frame(width: UIScreen.main.bounds.width-20, height: 56)
                                    .background(Color.white)
                                    .cornerRadius(6)
                                    .disableAutocorrection(true)
                                    
                                }.frame(width: UIScreen.main.bounds.width-20, alignment: .leading)
                                
                                
                               /* VStack(alignment: .leading, spacing: 0) {
                                    Text("Pin Code")
                                        .font(.system(size: 14).bold())
                                        .frame(width: 70, height: 20)
                                        .padding(.leading,10)
                                        .padding(.top,9)
                                        .padding(.bottom,9)
                                    TextField(
                                        "Enter Pin Code",
                                        text: $Pin)
                                    .padding(.all)
                                    .font(.system(size: 14).bold())
                                    .frame(width: UIScreen.main.bounds.width-20, height: 56)
                                    .background(Color.white)
                                    .keyboardType(.numberPad)
                                    .cornerRadius(6)
                                    .onChange(of: Pin, perform: { value in
                                        Pin = String(Pin.prefix(6))
                                        
                                    })
                                    
                                    
                                }.frame(width: UIScreen.main.bounds.width-20, alignment: .leading)*/
                                
                                
                                
                                
                            }
                            
                            
                        }.padding(.bottom,220)
                            .onTapGesture {
                                hideKeyboard()
                            }
                            .present(isPresented: self.$checktost, type: .toast, position: .top) {
                                // self.createTopToastView(errorMsg: "")
                                self.TopToastView(errorMsg: "")
                                
                            }
                    }
                    
                }
                Spacer()
                Button(action: {
                    checktost = true
                        if FName.count < 2{
                            errorCount = 1
                            
                        }else if Mobile.count < 9{
                            errorCount = 2
                        }else if MapAddress.count < 2{
                            errorCount = 3
                        }else if City.count < 2{
                            errorCount = 4
                        }
//                    else if Pin.count < 5{
//                            errorCount = 5
//
//                        }
                    else{
                            checktost = false
                            AddAddressApi(Type: AdType, Building_name:MapAddress , Name: FName, Addresses:MapAddress, Phone: Mobile,  City: City)
                           
                        }
                    
                   
                   
                }, label: {
                    HStack{
                       
                        Text("Save Address")
                            .font(.system(size: 24).bold())
                            .foregroundColor(Color.white)
                    }.frame(width: UIScreen.main.bounds.width-30,height: 58)
                    .background(Color("backColor"))
                    .cornerRadius(6)
                    .padding(.bottom,40)
                }).fullScreenCover(isPresented: $AddressListPresent,onDismiss: {
                   // presentationMode.wrappedValue.dismiss()
                    //AddAddressApi(Type: AdType, Building_name:FullAddress , Name: FName, Addresses:"\(locationViewModel.currentPlacemark?.description ?? "")", Phone: Mobile, Postcode:Pin, City: City)
                }){
                    addressView( AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []), addressId: $tempAddressID)
                 
                }
              
            }
            if self.showLoader{
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                   
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                //showLoader = true
            }
    }
//    var coordinate: CLLocationCoordinate2D? {
//        locationViewModel.lastSeenLocation?.coordinate
//    }
    func TopToastView(errorMsg:String) -> some View {
        VStack{
            if self.errorCount == 1{
              
                Text("Please Enter Full Name")
                    .font(.callout)
                    .foregroundColor(Color.white)
             
            }else if errorCount == 2 {
                Text("Please Enter Valid Mobile No.")
               .font(.callout)
                    .foregroundColor(Color.white)
             
            }else if errorCount == 3 {
                Text("Please Enter Full Address")
               .font(.callout)
                    .foregroundColor(Color.white)
                
            }else if errorCount == 4 {
                Text("Please Enter City Name")
                .font(.callout)
                    .foregroundColor(Color.white)
               
           }
//            else if errorCount == 5 {
//               Text("Please Enter PIN Code")
//                .font(.callout)
//                    .foregroundColor(Color.white)
//            }
        } .frame(width: UIScreen.main.bounds.width-20, height: 50,alignment: .center)
            .background(Color.black.opacity(0.8))
            .cornerRadius(12)
            .padding(.top,120)
    }
    func AddAddressApi(Type:String,Building_name:String,Name:String,Addresses:String,Phone:String,City:String){
        let parameters = [
            "customerid":NetworkManager.getUserId(),
            "id":"",
            "type" :Type,
            "building_name":Building_name,
            "name":Name,
            "address":Addresses,
            "phone":Phone,
            "postcode":"",
            "city":City
            
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "add-address", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
            
            showLoader = false
            //AddressListPresent = true
            presentationMode.wrappedValue.dismiss()
//                        let postResponse = try! JSONDecoder().decode(MyAddressResponse.self, from:responseData)
//            AddressResponseModel = postResponse
//                        print(" WishList Response:\(AddressResponseModel)")
            
            
        }
        
    }
}

struct EditAddressPageUIView_Previews: PreviewProvider {
    static var previews: some View {
        EditAddressPageUIView( MapAddress: .constant(""), tempAddressID: "")
    }
}
