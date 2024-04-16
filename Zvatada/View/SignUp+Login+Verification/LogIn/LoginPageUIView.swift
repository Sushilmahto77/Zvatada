//
//  LoginPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
import Toast_Swift
import SSToastMessage
//import ActivityIndicatorView
struct LoginPageUIView: View {
    @State  var Password: String = ""
    @State  var Email: String = ""
    @State  var HomeisPresented = false
    @State  var SignUpisPresented = false
    @State  var ForgotPasswordisPresented = false
    @State private var isEmailValid : Bool   = true
    @State var UserIDResponse:JSON = []
    @State var showToast = false
    @State var checktost = false
    @State var errorCount = 0
    @State var DashboardisPresent = false
    var body: some View {
       // GeometryReader { reader in
            ZStack{
                
                LinearGradient(gradient: Gradient(stops: [
                    .init(color: Color("backColor"), location: 0.23),
                    .init(color: Color("backColor1"), location: 0.62),
                ]), startPoint: .top, endPoint: .bottom)
                VStack{
                    ScrollView(.vertical,showsIndicators: false){
                        VStack{
                            HStack{
                                Spacer()
                                Button(action: {
                                    DashboardisPresent = true
                                }, label: {
                                    Text("Skip")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.white)
                                        .padding(.top,48)
                                        .padding(.trailing,20)
                                }).fullScreenCover(isPresented: $DashboardisPresent){
                                    ContentView()
                                }
                            }
                            VStack{
                                HStack{
                                    //Image("Asset 4")
                                    Image("out")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: UIScreen.main.bounds.width-70,height: 70)
                                        
                                }.frame(width: UIScreen.main.bounds.width-20,height: 48)
                                    //.background(Color.red)
                                    .padding(.top,95)
                               
                            }
                            VStack{
                                Text("Welcome back!")
                                    .font(.custom("SourceSansPro-Bold", size: 24))
                                    //.font(.system(size: 24).bold())
                                    .foregroundColor(Color("textColor"))
                            }.frame(width: UIScreen.main.bounds.width,height: 58)
                                .padding(.top,20)
                                //.background(Color.red)
                            VStack{
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
                                    .disableAutocorrection(true)
                                    //.padding(.top,12)
                                    
                                }.onChange(of: Email, perform: { value in
                                    Email = String(Email)
                                })

                                SecureField("Enter password", text: $Password)
                                    .padding(7)
                                    .padding(.horizontal, 10)
                                    .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                    .background(Color.white)
                                    .cornerRadius(100)
                                    .padding(.top,20)
                                    .disableAutocorrection(true)
                            }.frame(width: UIScreen.main.bounds.width,height: 150)
                               //.background(Color.red)
                            VStack{
                                Button(action: {
                                    ForgotPasswordisPresented = true
                                }, label: {
                                    Text("Forgot Password?")
                                        .font(.system(size: 20))
                                       // .padding(.top,55)
                                    
                                }).fullScreenCover(isPresented: $ForgotPasswordisPresented, content:{
                                    RequestRecoveryUIView()
                                })
                            }.frame(width: UIScreen.main.bounds.width,height: 24)
                            // .background(Color.red)
                           Spacer()
                         
                        }
                    }
                   Spacer()
                    
                    VStack{
                        VStack{
                            Button(action: {
                                
                                checktost = true
                                if (!self.textFieldValidatorEmail(self.Email)){
                                    errorCount = 1
                                }else if Password.count < 2{
                                    errorCount = 2
                                }else{
                                    
                                    loginUser(EmailID: Email, Password: Password)
                                    checktost = false
                                }
                            }, label: {
                                VStack{
                                    Text("Sign in")
                                        .font(.system(size: 24).bold())
                                        .foregroundColor(Color.white)
                                }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                                    .background(Color("backColor"))
                                    .cornerRadius(5)
                            }).fullScreenCover(isPresented: $HomeisPresented, content: {ContentView()})
                            
                            //.padding(.top,77)
                        }.frame(width: UIScreen.main.bounds.width,height: 58)
                        // .background(Color.red)
                        
                        // Spacer()
                        HStack {
                            Text("Don’t have an account? ")
                                .font(.system(size: 20))
                                .padding(.bottom,20)
                            Button(action: {
                                SignUpisPresented = true
                            }, label: {
                                Text(" Sign up")
                                    .font(.system(size: 20))
                                    .padding(.bottom,20)
                            }).fullScreenCover(isPresented: $SignUpisPresented, content: {
                                RegistrationPageUIView()
                            })
                        }.frame(width: UIScreen.main.bounds.width,height: 58)
                            .padding(.bottom,20)
                        //.background(Color.red)
                    }
                    
                    
                    
                   
                }.present(isPresented: self.$checktost, type: .toast, position: .top) {
                    // self.createTopToastView(errorMsg: "")
                    self.TopToastView(errorMsg: "")
                    
                }
                .present(isPresented: self.$showToast, type: .toast, position: .top) {
                    self.createTopToastView(errorMsg: "\(UserIDResponse["message"].stringValue)")
                   
                 }
            }.edgesIgnoringSafeArea(.all)
       // }
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
    func loginUser(EmailID:String,Password:String){
        let parameters = [
            "email":EmailID,
            "password":Password
        ]
        
        
        NetworkManager.postRequestUsingLoginToken(remainingUrl: "customer-login", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
            UserIDResponse = responseJson
            if responseJson["status"].intValue == 200{
                checktost = false
                HomeisPresented = true
            }
            if responseJson["status"].stringValue == "400" {
                //Show error msg
                showToast = true
                checktost = false
            }else{
               
               
                let USERid = responseJson["basketid"].stringValue
                UserDefaults.standard.set(responseJson["id"].stringValue, forKey: "UserID")
                UserDefaults.standard.set(responseJson["email"].stringValue, forKey: "userEmail")
                UserDefaults.standard.set(responseJson["name"].stringValue, forKey: "userName")
                print("User ID is :\(USERid)")
               // HomeisPresented = true
            }
           
            //
        }
    }
    func TopToastView(errorMsg:String) -> some View {
        VStack{
            if self.errorCount == 1{
              
                Text("Please Enter Valid Email")
                    .font(.callout)
                    .foregroundColor(Color.white)
             
            }else if errorCount == 2 {
                Text("Please Enter Password")
               .font(.callout)
                    .foregroundColor(Color.white)
             
            }

        } .frame(width: UIScreen.main.bounds.width-20, height: 50,alignment: .center)
            .background(Color.black.opacity(0.8))
            .cornerRadius(12)
            .padding(.top,100)
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

//struct LoginPageUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginPageUIView()
//    }
//}


