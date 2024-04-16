//
//  OrderCompletedUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 18/11/22.
//

import SwiftUI

struct OrderCompletedUIView: View {
    @State var Homepageispresent = false
    @State var AllOrderispresent = false
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                Image("check-out")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .frame(width: 200,height: 200)
                    .padding(.top,90)
                Text("Your Order has been accepted")
                    .font(.system(size: 16).bold())
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 240)
                Text("Order has been placed. Your items are on the way to be processed.")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(width: 270)
                    .padding(.top,12)
                
                    
                
                Spacer()
                VStack{
                    Button(action: {
                        AllOrderispresent = true
                    }, label: {
                        Text("Go to My Orders")
                            .font(.system(size: 18).bold())
                            .frame(width: UIScreen.main.bounds.width-20,height: 48)
                            .background(Color("backColor"))
                            .cornerRadius(6)
                            .foregroundColor(Color.white)
                    }).fullScreenCover(isPresented: $AllOrderispresent){
                        MyOrderUIView(MyOrderResponseModel: MyOrderResponse(status: "", msg: "", data: []))
                    }
                   Button(action: {
                       Homepageispresent = true
                   }, label: {
                       Text("Back to Home")
                           .font(.system(size: 14).bold())
                   }).fullScreenCover(isPresented: $Homepageispresent){
                       ContentView()
                   }
                  
                }.padding(.bottom,40)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct OrderCompletedUIView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCompletedUIView()
    }
}
