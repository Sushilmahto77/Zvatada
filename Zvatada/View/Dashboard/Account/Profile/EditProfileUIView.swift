//
//  EditProfileUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

import SwiftUI
import SwiftyJSON
struct EditProfileUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var Fname:String = ""
    @State var MobileNo:String = ""
    @State var Email:String = ""
    @State var changePassPresent = false
    @State var detailsResponse :JSON = []
    @State var HomePageisPresent = false
    @State var showLoader = false
    @State private var showingAlert = false
    @State private var showingSuccssAlert = false
    var body: some View {
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
                    Text("Profile")
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
                    })
                        .fullScreenCover(isPresented: $HomePageisPresent){
                            ContentView()
                        }
                    Button(action: {
                        showingAlert = true
                    }, label: {
                        Image(systemName: "trash.fill")
                            .padding(.top,48)
                            .font(.system(size: 18).bold())
                            .foregroundColor(Color.white)
                            .padding(.trailing,12)
                    }).alert("Do you really want to delete your account?", isPresented: $showingAlert) {
                        Button("Cancel") {
                            showingAlert = false
                        }
                        Button("Yes") {
                            showingSuccssAlert = true
                            showingAlert = false
                        }
                        
                    }
                    .alert("Account Deletion Request successfully sent to Zvatada Team. We will get back to you and update asap.", isPresented: $showingSuccssAlert) {
                        //                            Button("Cancel") { }
                        Button(action: {
                            showingSuccssAlert = false
                        }, label: {
                            Text("Ok")
                        })
                        
                        
                    }
                   
                    
                }.frame(width: UIScreen.main.bounds.width,height: 100)
                .background(Color("backColor"))
                .foregroundColor(Color.white)
                VStack{
                    Text("Personal Information")
                        .font(.system(size: 18))
                        .frame(width: UIScreen.main.bounds.width-20,height: 24,alignment: .leading)
                    VStack(alignment: .leading,spacing: 9){
                      
                        Text("Full Name")
                            .font(.system(size: 16))
                            .foregroundColor(Color.black.opacity(0.5))
                        TextField("\(detailsResponse["name"].stringValue)", text: $Fname)
                            .font(.system(size: 16))
                           // .font(.system(size: 12).bold())
                            .padding(.horizontal,10)
                            .frame(width: UIScreen.main.bounds.width-20,height: 48,alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(6)
                    }.padding(.top,12)
                    VStack(alignment: .leading,spacing: 9){
                      
                        Text("Mobile Number")
                            .font(.system(size: 16))
                            .foregroundColor(Color.black.opacity(0.5))
                        TextField("\(detailsResponse["mobile"].stringValue)", text: $MobileNo)
                            .font(.system(size: 16))
                           // .font(.system(size: 12).bold())
                            .padding(.horizontal,10)
                            .keyboardType(.numberPad)
                            .frame(width: UIScreen.main.bounds.width-20,height: 48,alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(6)
                    }.padding(.top,12)
                    VStack(alignment: .leading,spacing: 9){
                      
                        Text("Email Address")
                            .font(.system(size: 16))
                            .foregroundColor(Color.black.opacity(0.5))
                        TextField("\(detailsResponse["email"].stringValue)", text: $MobileNo)
                            .font(.system(size: 16))
                            //.font(.system(size: 12).bold())
                            .padding(.horizontal,10)
                            .frame(width: UIScreen.main.bounds.width-20,height: 48,alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(6)
                    }.padding(.top,12)
                        .padding(.bottom,9)
                    Rectangle().frame(width: UIScreen.main.bounds.width,height: 2)
                        .foregroundColor(Color.gray.opacity(0.4))
                    VStack{
                        Text("Security Information")
                            .font(.system(size: 16))
                            .frame(width: UIScreen.main.bounds.width,height: 24,alignment: .leading)
                            .padding(.top,9)
                            .padding(.leading,20)
                        Button(action: {
                            changePassPresent = true
                        }, label: {
                            HStack {
                                Text("Change Password")
                                    .font(.system(size: 16))
                                    .padding(.all,9)
                                    .frame(height: 40,alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.blue,lineWidth: 2)
                                        )
                                    .padding(.top,9)
                                .padding(.leading,20)
                                Spacer()
                            }
                            .foregroundColor(Color.blue)
                        }).fullScreenCover(isPresented: $changePassPresent){
                            ChangePasswordUIView()
                        }
                      
                        
                    }
                    
                    
                }
                Spacer()
                Button(action: {
                    saveDetailsApi(name: Fname, email: Email, phone: MobileNo)
                }, label: {
                    VStack{
                        Text("Save Details")
                            .font(.system(size: 24).bold())
                            .foregroundColor(Color.white)
                    }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                        .background(Color("backColor"))
                        .cornerRadius(5)
                        .padding(.bottom,58)
                })
            }
            if self.showLoader{
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                   
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                CustomerDetailsApi(Customerid: NetworkManager.getUserId())
                showLoader = true
            }
    }
    func CustomerDetailsApi(Customerid :String){
        let parameters = [
            "customerid":Customerid
            
        ]
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "customer-details", parameters: parameters) { responseJson in
            print("Response CustomerDetailsApi: ", responseJson)
            detailsResponse = responseJson
            showLoader = false

        }
        
    }
    func saveDetailsApi(name :String,email:String,phone:String){
        let parameters = [
            "id" :"",
            "name":name,
            "email":email,
            "phone":phone,
            "userlogo":"",
            "old_email":"\(detailsResponse["email"].stringValue)",
            "old_phone":"\(detailsResponse["mobile"].stringValue)",
           
            
        ]
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "customer-details", parameters: parameters) { responseJson in
            print("Response saveDetailsApi : ", responseJson)
            detailsResponse = responseJson
showLoader = false
        }
        
    }
}

struct EditProfileUIView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileUIView()
    }
}
