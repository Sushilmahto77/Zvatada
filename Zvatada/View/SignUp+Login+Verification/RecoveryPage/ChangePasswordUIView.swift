//
//  ChangePasswordUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

import SwiftUI

struct ChangePasswordUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var CurrentPass:String = ""
    @State var NewPassword:String = ""
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
                    Text("Change Password")
                        .font(.system(size: 20).bold())
                        //.padding(.l,20)
                        .padding(.top,48)
                    Spacer()
                    Image("Plain blue on white version 2")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 100,height: 20)
                        .padding(.top,48)
                        .padding(.trailing,20)
                   
                    
                }.frame(width: UIScreen.main.bounds.width,height: 100)
                .background(Color("backColor"))
                .foregroundColor(Color.white)
                VStack{
                    VStack (alignment: .leading){
                        Text("Current Password")
                            .font(.system(size: 20))
                            .padding(.leading,12)
                            
                        TextField("Please enter your current password", text: $CurrentPass)
                            .font(.system(size: 14))
                                .padding(7)
                                .padding(.horizontal, 10)
                                .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                .background(Color.white)
                                .cornerRadius(25)
                                
                        Text("New Password")
                            .font(.system(size: 20))
                            .padding(.leading,12)
                            .padding(.top,20)
                            
                        TextField("please enter your new password", text: $NewPassword)
                            .font(.system(size: 14))
                                .padding(7)
                                .padding(.horizontal, 10)
                                .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                .background(Color.white)
                                .cornerRadius(25)
                    }.padding(.top,20)
                   
                  
                }
                Spacer()
                Button(action: {
                    ChangePasswordApi(oldPass: CurrentPass, newPass: NewPassword)
                }, label: {
                    VStack{
                        Text("Reset password")
                            .font(.system(size: 24).bold())
                            .foregroundColor(Color.white)
                    }.frame(width: UIScreen.main.bounds.width-30,height: 58)
                    .background(Color("backColor"))
                    .cornerRadius(6)
                   .padding(.bottom,58)
                })
            }
        }.edgesIgnoringSafeArea(.all)
    }
    func ChangePasswordApi(oldPass:String,newPass:String){
        let parameters = [
            "customerid":NetworkManager.getUserId(),
            "oldpassword":oldPass,
            "newpassword":newPass
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "change-password", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
//
//            let postResponse = try! JSONDecoder().decode(HomeResponse.self, from:responseData)
//            HomeResponseModel = postResponse
//            print(" Home Response:\(HomeResponseModel)")
           
            //
        }
       
       
        
    }
}

struct ChangePasswordUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordUIView()
    }
}
