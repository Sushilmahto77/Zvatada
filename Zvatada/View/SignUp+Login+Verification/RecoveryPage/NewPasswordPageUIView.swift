//
//  NewPasswordPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI

struct NewPasswordPageUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State  var Code: String = ""
    @State  var Password: String = ""
    @State  var NewPassword: String = ""
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
               VStack{
                    VStack{
                        HStack {
                            Button(action: {
                                
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color.black)
                            }
                            .padding(.leading,24)
                            
                            Text("Back")
                                .font(.system(size: 24).bold())
                                .foregroundColor(Color.black)
                                .padding(.trailing,54)
                            Spacer()
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 53)
                    .padding(.top,48)
                   VStack{
                       Text("Create new password")
                           .font(.system(size: 32).bold())
                       Text("Your new password must be different from your previous password.")
                           .font(.system(size: 20))
                           .frame(width: 280)
                           .multilineTextAlignment(.center)
                           .padding(.top,12)
                       TextField("Enter code sent to your email", text: $Code)
                           .font(.system(size: 14))
                               .padding(7)
                               .padding(.horizontal, 10)
                               .frame(width: 260,height: 50)
                               .background(Color.white)
                               .cornerRadius(25)
                               .padding(.top,20)
                       VStack (alignment: .leading){
                           Text("Password")
                               .font(.system(size: 20))
                               .padding(.leading,12)
                               
                           TextField("", text: $Code)
                               .font(.system(size: 14))
                                   .padding(7)
                                   .padding(.horizontal, 10)
                                   .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                   .background(Color.white)
                                   .cornerRadius(25)
                                   
                           Text("Confirm Password")
                               .font(.system(size: 20))
                               .padding(.leading,12)
                               .padding(.top,20)
                               
                           TextField("", text: $Code)
                               .font(.system(size: 14))
                                   .padding(7)
                                   .padding(.horizontal, 10)
                                   .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                   .background(Color.white)
                                   .cornerRadius(25)
                       }.padding(.top,20)
                       VStack{
                           Text("Reset password")
                               .font(.system(size: 32).bold())
                               .foregroundColor(Color.white)
                       }.frame(width: UIScreen.main.bounds.width-30,height: 72)
                       .background(Color("backColor"))
                       .cornerRadius(6)
                       .padding(.top,40)
                   }
                    
                    
                }
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct NewPasswordPageUIView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordPageUIView()
    }
}
