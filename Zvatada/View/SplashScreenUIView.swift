//
//  SplashScreenUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
struct SplashScreenUIView: View {
    @State private var isActive = false
    @State private var size = 0.8
   @State private var opacity = 0.5
    @AppStorage("login") var login = false
    
    var body: some View {
        if isActive{
            if NetworkManager.getUserId() == ""{
               LoginPageUIView()
               // ContentView()
            }else{
                ContentView()
            }
          
            }else{
        ZStack{
            Color("backColor")
            VStack{
                VStack{
                  // Image("Asset 4")
                    Image("out")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.scaledToFill()
                        .frame(width: 280,height: 70)
                }.background(Color("backColor"))
                
            }
        }.background(Color("backColor"))
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                        self.isActive = true
                    }
                }
              
        
        }
    }
}

//struct SplashScreenUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashScreenUIView()
//    }
//}
struct Loader:View{
    @State var animate = false
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Circle()
                    .trim(from: 0,to: 0.8)
                    .stroke(AngularGradient(gradient: .init(colors: [.blue,.gray.opacity(0.1)]), center: .center),style: StrokeStyle(lineWidth: 4,lineCap: .round))
                    .frame(width: 30,height: 30)
                    .rotationEffect(.init(degrees: self.animate ? 360:0))
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                    //.padding(.leading,20)
                Text("Please Wait...")
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.leading,12)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width-80,height: 75)
                .background(Color.white)
                .cornerRadius(4)
                .padding(.leading,40)
            Spacer()
        }
        .onAppear{
            self.animate.toggle()
        }
       
    }
}
