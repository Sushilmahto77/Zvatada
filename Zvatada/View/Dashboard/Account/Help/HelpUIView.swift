//
//  HelpUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

import SwiftUI

struct HelpUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var HomePageisPresent = false
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
                    Text("Help")
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
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct HelpUIView_Previews: PreviewProvider {
    static var previews: some View {
        HelpUIView()
    }
}
