//
//  SelectServicePageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI

struct SelectServicePageUIView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(stops: [
                .init(color: Color.white, location: 0.65),
                   .init(color: Color("backColor"), location: 0.95),
               ]), startPoint: .top, endPoint: .bottom)
            VStack{
                VStack{
                   Image("Artboard4 1")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 68,height: 44)
                        Text("ZVATADA")
                        .font(.system(size: 16).bold())
                        .padding(.top,4)
                    Text("Find products at great prices")
                        .font(.system(size: 9))
                        .foregroundColor(Color.black.opacity(0.6))
                        .padding(.top,2)
                        .padding(.bottom,8)
                }.frame(width: 250,height: 120)
                    .background(Color("backColor1"))
                    .cornerRadius(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue,lineWidth: 2)
                    )
                .padding(.top,90)
                VStack{
                    Image("undraw_breakfast_psiw 1")
                         .resizable()
                         .aspectRatio( contentMode: .fit)
                         .frame(width: 68,height: 44)
                         Text("FOOD")
                         .font(.system(size: 16).bold())
                         .padding(.top,4)
                     Text("Best deals on delicious meals")
                         .font(.system(size: 9))
                         .foregroundColor(Color.black.opacity(0.6))
                         .padding(.top,2)
                         .padding(.bottom,8)
                }.frame(width: 250,height: 120)
                    .background(Color("backColor1"))
                    .cornerRadius(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue,lineWidth: 2)
                    )
                .padding(.top,30)
                VStack{
                    Image("undraw_shopping_app_flsj 1")
                         .resizable()
                         .aspectRatio( contentMode: .fit)
                         .frame(width: 68,height: 44)
                         Text("GROCERIES")
                         .font(.system(size: 16).bold())
                         .padding(.top,4)
                     Text("Broad selection of everyday essentials")
                         .font(.system(size: 9))
                         .foregroundColor(Color.black.opacity(0.6))
                         .padding(.top,2)
                         .padding(.bottom,8)
                }.frame(width: 250,height: 120)
                    .background(Color("backColor1"))
                    .cornerRadius(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue,lineWidth: 2)
                    )
                .padding(.top,30)
                Spacer()
              
            }
           
        }.edgesIgnoringSafeArea(.all)
    }
}

struct SelectServicePageUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectServicePageUIView()
    }
}
