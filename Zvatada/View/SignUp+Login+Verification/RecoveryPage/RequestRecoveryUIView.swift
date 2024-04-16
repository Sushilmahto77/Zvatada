//
//  RequestRecoveryUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
import Toast_Swift
import SSToastMessage

struct RequestRecoveryUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State  var Email: String = ""
    @State var ResetPasswordisPresented = false
    @State var RecoveryPasswordResponse:JSON = []
    @State private var isEmailValid : Bool   = true
    @State var showToast = false
    @State var checktost = false
    @State var errorCount = 0
    var body: some View {
        ZStack{
            Color("backColor1")
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
                    ScrollView(.vertical,showsIndicators: false){
                        VStack{
                            VStack(alignment: .leading,spacing: 0){
                                Text("Reset password")
                                    .font(.system(size: 32).bold())
                                Text("Enter the email associated with your account and we’ll send an email with a code to reset your password.")
                                    .frame(width: 306,height: 126,alignment: .leading)
                                    .font(.system(size: 20))
                            }
                            Text("Email address")
                                .font(.system(size: 20))
                                .frame(width: 305,height: 24,alignment: .leading)
                                .padding(.top,30)
                            HStack{
                                TextField("Email", text: $Email, onEditingChanged: { (isChanged) in
                                    if !isChanged {
                                        if self.textFieldValidatorEmail(self.Email) {
                                            self.isEmailValid = true
                                        } else {
                                            self.isEmailValid = false
                                            self.Email = ""
                                            
                                        }
                                    }
                                })
                                .autocapitalization(.none)
                                .padding(7)
                                .padding(.horizontal, 10)
                                .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                .background(Color.white)
                                .cornerRadius(100)
                                //.padding(.top,12)
                                
                            }.onChange(of: Email, perform: { value in
                                Email = String(Email)
                            })
//                            TextField("Enter your email", text: $Email)
//                                    .padding(7)
//                                    .padding(.horizontal, 10)
//                                    .frame(width: UIScreen.main.bounds.width-40,height: 50)
//                                    .background(Color.white)
//                                    .cornerRadius(25)
                            Button(action: {
                                checktost = true
                                if (!self.textFieldValidatorEmail(self.Email)){
                                errorCount = 1
                                }else{
                                    ForgotPasswordApi(Email: Email)
                                    showToast = true
                                    checktost = false
                                }
                            }, label: {
                                VStack{
                                    Text("Send email")
                                        .font(.system(size: 24).bold())
                                        .foregroundColor(Color.white)
                                }.frame(width: UIScreen.main.bounds.width-30,height: 58)
                                .background(Color("backColor"))
                                .cornerRadius(6)
                                .padding(.top,40)
                            }).fullScreenCover(isPresented: $ResetPasswordisPresented, content: {RecoveryEmailSentUIView()})
                           
                        }
                    }
                }.present(isPresented: self.$checktost, type: .toast, position: .top) {
                    // self.createTopToastView(errorMsg: "")
                    self.TopToastView(errorMsg: "")
                    
                }
                .present(isPresented: self.$showToast, type: .toast, position: .top) {
                    self.createTopToastView(errorMsg: "\(RecoveryPasswordResponse["message"].stringValue)")
                   
                 }
                        
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
    }
    func TopToastView(errorMsg:String) -> some View {
        VStack{
            if self.errorCount == 1{
              
                Text("Please Enter Valid Email")
                    .font(.callout)
                    .foregroundColor(Color.white)
             
            }

        } .frame(width: UIScreen.main.bounds.width-20, height: 50,alignment: .center)
            .background(Color.black.opacity(0.8))
            .cornerRadius(12)
            .padding(.top,100)
    }
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    func ForgotPasswordApi(Email:String){
        let parameters = [
            "email":Email,
           
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "forget-password", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
            RecoveryPasswordResponse = responseJson
            if RecoveryPasswordResponse["status"].stringValue == "400"{
                showToast = true
                checktost = false
            }else {
                ResetPasswordisPresented = true
            }

        }
    }
    func createTopToastView(errorMsg:String) -> some View {
           VStack {
              
               HStack {
                
                   Text("\(errorMsg)")
                       .foregroundColor(.white)
                       .font(.custom("Roboto-Regular", size: 14))
                       .padding(.leading,20)
                   //Spacer()
                   Text("")
                       .font(.system(size: 12))
                       .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
               } .frame(width: UIScreen.main.bounds.width-20, height: 50,alignment: .center)
                   .background(Color.black.opacity(0.8))
                   .cornerRadius(12)
                   //.padding(.bottom,100)
                   .padding(.top,100)
               Spacer()
           }
       }
}

struct RequestRecoveryUIView_Previews: PreviewProvider {
    static var previews: some View {
        RequestRecoveryUIView()
    }
}
