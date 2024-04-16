//
//  RegistrationPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
import Network
import Toast_Swift
import SSToastMessage
struct RegistrationPageUIView: View {
    @State  var FName: String = ""
    @State  var Password: String = ""
    @State  var CPassword: String = ""
    @State  var Email: String = ""
    @State  var MobileNo: String = ""
    @State private var isEmailValid : Bool   = true
    @State var signUpResponse : JSON = []
    @State var errorCount = 0
    @State private var HomeisPresented = false
    @State private var SiginisPresented = false
    @State var checktost = false
    @State var showToast = false
    
    @ObservedObject var monitor = NetworkMonitor()
    var body: some View {
        ZStack{
            Color("backColor1")
            /*LinearGradient(colors: [.orange, .red],
                                 startPoint: .top,
                                 endPoint: .center)*/
            VStack{
                
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                        VStack(spacing:0){
                            Image("blue logo lockup 1")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(width: 233,height: 165)
                                .padding(.top,65)
                            Text("Welcome!")
                                .font(.system(size: 32).bold())
                                .foregroundColor(Color("backColor"))
                            Text("Let’s get you started.")
                                .font(.system(size: 20))
                                .foregroundColor(Color.black.opacity(0.6))
                            TextField("Enter your full name", text: $FName)
                                .padding(7)
                                .padding(.horizontal, 10)
                                .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                .background(Color.white)
                                .cornerRadius(25)
                                .padding(.top,48)
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
                                .cornerRadius(25)
                                .padding(.top,12)
                                
                            }.onChange(of: Email, perform: { value in
                                Email = String(Email)
                            })
                            
                            TextField("Enter Mobile Number", text: $MobileNo)
                                .padding(7)
                                .padding(.horizontal, 10)
                                .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                .background(Color.white)
                                .cornerRadius(25)
                                .padding(.top,12)
                                .keyboardType(.numberPad)
                                .onChange(of: MobileNo, perform: { value in
                                    MobileNo = String(MobileNo.prefix(10))
                                   
                                })
                                .onTapGesture {
                                    hideKeyboard()
                                }
                            
                            SecureField("Enter password", text: $Password)
                                .padding(7)
                                .padding(.horizontal, 10)
                                .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                .background(Color.white)
                                .cornerRadius(25)
                                .padding(.top,12)
                            //.keyboardType(.numberPad)
                                .onTapGesture {
                                    hideKeyboard()
                                }
                            SecureField("Confirm Password", text: $CPassword)
                                .padding(7)
                                .padding(.horizontal, 10)
                                .frame(width: UIScreen.main.bounds.width-20,height: 50)
                                .background(Color.white)
                                .cornerRadius(25)
                                .padding(.top,12)
                                .onTapGesture {
                                    hideKeyboard()
                                }
                        }
                        VStack(spacing: 0){
                            HStack(spacing:0){
                                Text("By registering, you agree with our ")
                                Link(destination: URL(string: "https://www.zvatada.com/pages/warranty-policy")!) {
                                    Text("terms")
//                                        .font(.system(size: 12))
//                                        .foregroundColor(Color.black)
//                                        .padding(.trailing,20)
                                }
//                                Button(action: {}, label: {
//                                    Text("terms")
//                                })
                                Text(",")
                                Link(destination: URL(string: "https://www.zvatada.com/pages/warranty-policy")!) {
                                    Text(" conditions")
//                                        .font(.system(size: 12))
//                                        .foregroundColor(Color.black)
//                                        .padding(.trailing,20)
                                }
//                                Button(action: {}, label: {
//                                    Text(" conditions")
//                                })
                                Text(" & ")
                                Link(destination: URL(string: "https://www.zvatada.com/pages/warranty-policy")!) {
                                    Text("Privacy Policy")
//                                        .font(.system(size: 12))
//                                        .foregroundColor(Color.black)
//                                        .padding(.trailing,20)
                                }
//                                Button(action: {}, label: {
//                                    Text("privacy policy.")
//                                })
                            }
                            .font(.system(size: 9))
                            .padding(.top,25)
                            Button(action: {
                                checktost = true
                                    if FName.count < 2{
                                        errorCount = 1
                                        
                                    }else if (!self.textFieldValidatorEmail(self.Email)){
                                        errorCount = 2
                                    }else if MobileNo.count < 9{
                                        errorCount = 3
                                    }else if Password.count < 4 {
                                        errorCount = 4
                                        
                                    }else if CPassword.count < 4 {
                                        errorCount = 5
                                       
                                    }else if  CPassword == Password{
                                        checktost = false
                                        signUpApi(UserName: FName, Email: Email, Mobile: MobileNo, password: CPassword)
                                       
                                    }
                                
                            }, label: {
                                VStack{
                                    Text("Register")
                                        .font(.system(size: 24).bold())
                                        .foregroundColor(Color.white)
                                }.frame(width: UIScreen.main.bounds.width-20,height: 58)
                                    .background(Color("backColor"))
                                    .cornerRadius(6)
                                    .padding(.top,12)
                            }).fullScreenCover(isPresented: $HomeisPresented){
                                ContentView()
                            }
                            
                            
                            HStack {
                                Text("Already have an account?")
                                    .font(.system(size: 20))
                                Button(action: {
                                    SiginisPresented = true
                                }, label: {
                                    Text("Sign in")
                                        .font(.system(size: 20))
                                }).fullScreenCover(isPresented: $SiginisPresented, content: {LoginPageUIView( UserIDResponse: signUpResponse)})
                            }.padding(.top,12)
                                .padding(.bottom,58)
                            
                            
                            
                            
                            //Spacer()
                        }.padding(.bottom,200)
                    }
                }
            }.present(isPresented: self.$checktost, type: .toast, position: .top) {
                // self.createTopToastView(errorMsg: "")
                self.TopToastView(errorMsg: "")
                
            }.present(isPresented: self.$showToast, type: .toast, position: .top) {
                self.createTopToastView(errorMsg: "\(signUpResponse["message"].stringValue)")
               
             }
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
                   if !monitor.isConnected{
                      // showToast = true
                   }
               }
            //.background(Color("backColor1"))
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
    func signUpApi(UserName:String,Email : String,Mobile:String,password:String){
        
        let parameters = [
            "email":Email,
            "mobile": Mobile,
            "name": UserName,
            "password":password
        ]


        NetworkManager.postRequestUsingLoginToken(remainingUrl: "customer-register", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
            signUpResponse = responseJson
            if responseJson["status"].stringValue == "400" {
                //Show error msg
               // presentOtpAlert = true
                showToast = true
                checktost = false
            }else{

                //Save data in local
                UserDefaults.standard.set(signUpResponse["ConsumerDetails"]["USER_NAME"].stringValue, forKey: "userName")
                UserDefaults.standard.set(signUpResponse["ConsumerDetails"]["MOBILE_NO"].stringValue, forKey: "userMobile")
                UserDefaults.standard.set(signUpResponse["ConsumerDetails"]["EMAIL"].stringValue, forKey: "userEmail")
                showToast = false
                SiginisPresented = true

               // HomeisPresented = true
            }
        }
    }
    func TopToastView(errorMsg:String) -> some View {
        VStack{
            if self.errorCount == 1{
              
                Text("Please Enter Full Name")
                    .font(.callout)
                    .foregroundColor(Color.white)
             
            }else if errorCount == 2 {
                Text("Please Enter Valid Email")
               .font(.callout)
                    .foregroundColor(Color.white)
             
            }else if errorCount == 3 {
                Text("Please Enter Valid Mobile No.")
               .font(.callout)
                    .foregroundColor(Color.white)
                
            }else if errorCount == 4 {
                Text("Please Enter Password")
                .font(.callout)
                    .foregroundColor(Color.white)
               
           }else if errorCount == 5 {
                Text("Please Enter Confirm your Password")
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

struct RegistrationPageUIView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationPageUIView()
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true
     
    init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
