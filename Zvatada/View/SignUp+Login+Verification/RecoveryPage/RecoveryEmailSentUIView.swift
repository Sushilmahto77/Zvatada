//
//  RecoveryEmailSentUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
struct RecoveryEmailSentUIView: View {
    @State  var otp: String = ""
    @State var ContinuePasswordisPresented = false
  
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                VStack{
                    Image("undraw_opened_re_i38e 1")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 122,height: 107)
                        .padding(.top,100)
                    Text("Check your email")
                        .font(.system(size: 32).bold())
                        .padding(.top,40)
                    Text("We have sent you password recovery code.")
                        .font(.system(size: 22))
                        .frame(width: 180)
                        .multilineTextAlignment(.center)
                        .padding(.top,30)
//                    TextField("", text: $otp)
//                            .padding(7)
//                            .font(.system(size: 22).bold())
//                            .multilineTextAlignment(.center)
//
//                    Rectangle().frame(width: 100,height: 2).foregroundColor(Color.black.opacity(0.4))
                    Button(action: {
                        ContinuePasswordisPresented = true
                    }, label: {
                        Text("Continue")
                            .font(.system(size: 20))
                            .padding(.top,20)
                    }).fullScreenCover(isPresented: $ContinuePasswordisPresented){
                        LoginPageUIView()
                    }
                    VStack {
                        Text("Did not receive the email? Check your spam folder or ")
                            .frame(width: 320)
                            .font(.system(size: 20))
                            .multilineTextAlignment(.leading)
                        Button(action: {}, label: {
                            Text("resend email.")
                                .font(.system(size: 20))
                                .offset(x:90,y:-25)
                        })
                       
                    }.padding(.top,30)
                }
                
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

//struct RecoveryEmailSentUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecoveryEmailSentUIView()
//    }
//}
