//
//  orderReviewPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 07/02/23.
//

import SwiftUI
import SwiftyJSON
//struct orderReviewPageUIView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

//struct orderReviewPageUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        orderReviewPageUIView()
//    }
//}
struct orderReviewPageUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var ProductDetailsResponseModel:ProductDetailsResponse
    @State var DataFound = 0
    @State var writeStarisPresent = false
    @State var rating: Int?
    var max: Int = 5
    @State var progressValue: Int = 10
    @State var HomePageisPresent = false
    @Binding var tempProductId :String
    @Binding var productIdTemp :String
    @Binding var ratings: Int
    var label = "Tap on the Star to rate"
    var maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray.opacity(0.5)
    var onColor = Color.blue
    private let maxValue: Double = 5
    @State var barRate :Int
    @State var starUser1 = 0
    @State var starUser2 = 0
    @State var starUser3 = 0
    @State var starUser4 = 0
    @State var starUser5 = 0
    @State var productDetailResponse :JSON = []
    @State var showLoader = false
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
                    Text("User Reviews")
                        .font(.system(size: 20).bold())
                        //.padding(.l,20)
                        .padding(.top,48)
                    Spacer()
                    Button(action: {
                        HomePageisPresent = true
                    }, label: {
                        Image("Plain blue on white version 2")
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
                HStack{
                    VStack{
                        Text("\(ProductDetailsResponseModel.averageRatting ?? 0)")
                            .font(.system(size: 28).bold())
                        Text("Rating")
                            .font(.system(size: 14).bold())
                            .foregroundColor(Color.gray.opacity(0.6))
                    }.frame(width: 100)
                    .padding(.leading,20)
                    VStack(alignment: .trailing){
                       
                        ForEach(0...4,id: \.self){i in
                            HStack(spacing: 0){
                              
                                ForEach(0...i,id: \.self ){j in
                                    
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color.yellow)
                                }
                                
                               
                            }
                           Image(systemName: "")
                        }
                        
                    }
                    VStack(spacing: 6){
                       
                        HStack{
                            ProgressBar(value: Double(starUser1), maxValue: Double(ProductDetailsResponseModel.totalReview ?? 0),foregroundColor: Color("backColor"))
                                .frame(height: 6)
                                //.padding(.top,)
                            Text("\(starUser1)")
                                .font(.system(size: 14))
                                .padding(.trailing,8)
                        }
                        HStack{
                            ProgressBar(value: Double(starUser2), maxValue: Double(ProductDetailsResponseModel.totalReview ?? 0),foregroundColor: Color("backColor"))
                                .frame(height: 6)
                                //.padding(.top,6)
                            Text("\(starUser2)")
                                .font(.system(size: 14))
                                .padding(.trailing,8)
                        }
                        HStack{
                            ProgressBar(value: Double(starUser3), maxValue: Double(ProductDetailsResponseModel.totalReview ?? 0),foregroundColor: Color("backColor"))
                                .frame(height: 6)
                                //.padding(.top,6)
                            Text("\(starUser3)")
                                .font(.system(size: 14))
                                .padding(.trailing,8)
                        }
                        HStack{
                            ProgressBar(value: Double(starUser4), maxValue: Double(ProductDetailsResponseModel.totalReview ?? 0),foregroundColor: Color("backColor"))
                                .frame(height: 6)
                               // .padding(.top,6)
                            Text("\(starUser4)")
                                .font(.system(size: 14))
                                .padding(.trailing,8)
                        }
                        HStack{
                            ProgressBar(value: Double(starUser5), maxValue: Double(ProductDetailsResponseModel.totalReview ?? 0),foregroundColor: Color("backColor"))
                                .frame(height: 6)
                                //.padding(.top,6)
                            Text("\(starUser5)")
                                .font(.system(size: 14))
                                .padding(.trailing,8)
                        }
                       
                       
                        
                    }.padding(.trailing,20)
                }
                VStack{
                    Text("\(ProductDetailsResponseModel.totalReview ?? 0) Reviews")
                        .font(.system(size: 16).bold())
                        .frame(width: UIScreen.main.bounds.width,height: 20,alignment: .leading)
                        .padding(.leading,12)
                        .padding(.bottom,12)
                    ScrollView(.vertical,showsIndicators: false){
                        ForEach(ProductDetailsResponseModel.reviews ?? [],id: \.self){item in
                            
                            VStack(spacing: 4){
                                Text("\(item.name)")
                                    .font(.system(size: 14).bold())
                                    .padding(.leading,12)
                                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                HStack{
 
                                    HStack(spacing: 0){
                                               ForEach(1..<maxRating + 1, id:\.self){number in
                                                   let myString1 = "\(item.rating)"
                                                   let star1 = Int(myString1)
                                                   
                                                   image(for: number)
                                                       .font(.system(size: 14))
                                                       .foregroundColor(number>star1 ?? 0 ? offColor : onColor)
                                                       .padding(.leading,6)
                                                       
                                                       }
                                        Spacer()
                                               }
                                    Spacer()
                                    Text("\(item.adddate)")
                                        .font(.system(size: 12))
                                        .padding(.trailing,12)
                                        .foregroundColor(Color.black.opacity(0.5))
                                }.padding(.leading,12)
                                
                                Text("\(item.comments)")
                                    .font(.system(size: 12))
                                    .padding(.leading,12)
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                Rectangle().frame(width: UIScreen.main.bounds.width,height: 1)
                                    .foregroundColor(Color.gray.opacity(0.4))
                            }
                        }
                        
                    }
                }
                
                Spacer()
                Button(action: {
                    writeStarisPresent = true
                }, label: {
                    HStack {
                        Spacer()
                        HStack{
                           
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 16).bold())
                            Text("Write a Review")
                                .font(.system(size: 16).bold())
                                
                        }.frame(width: 180,height: 48,alignment: .center)
                            .background(Color("backColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(30)
                            .padding(.trailing,20)
                        .padding(.bottom,90)
                    }
                }).sheet(isPresented: $writeStarisPresent,onDismiss: {
                    ProductDetailsApi(Productid: "\(productIdTemp)")
                }){
                    StarRatingUIView( ProductId: $tempProductId)
                }
               
               
            }
            if self.showLoader{
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                   
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                ProductDetailsApi(Productid: "\(productIdTemp)")
                    showLoader = true
            }
    }
    func ProductDetailsApi(Productid:String){
        let parameters = [
            "basketid":NetworkManager.getBasketID(),
            "customerid":NetworkManager.getUserId(),
            "productid":Productid,
           

        ]


        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "product-details", parameters: parameters) { responseJson in
            //print("Response : ", responseJson)
            productDetailResponse = responseJson
            print("details response is \(productDetailResponse)")
//            let postResponse = try! JSONDecoder().decode(ProductDetailsResponse.self, from:responseData)
//            ProductDetailsResponseModel = postResponse
//            print(" Product  List Response:\(ProductDetailsResponseModel)")
            //ForEach(productDetailResponse["reviews"]["rating"].stringValue){item in
            showLoader = false
            if productDetailResponse["reviews"].isEmpty {
                
            }else{
                for item in productDetailResponse["reviews"].arrayValue {
                    print(item["rating"].stringValue)
                    if item["rating"].stringValue == "1" || item["rating"].stringValue == "1.5"{
                        starUser1 = starUser1 + 1
                    }else if item["rating"].stringValue == "2" || item["rating"].stringValue == "2.5"{
                        starUser2 = starUser2 + 1
                    }else if item["rating"].stringValue == "3" || item["rating"].stringValue == "3.5"{
                        starUser3 = starUser3 + 1
                    }else if item["rating"].stringValue == "4" || item["rating"].stringValue == "4.5"{
                        starUser4 = starUser4 + 1
                    }else if item["rating"].stringValue == "5"{
                        starUser5 = starUser5 + 1
                    }
                }
               
                
            }
            //}

        }

    }
    func image(for number: Int) -> Image {
        if number > ratings {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    private func starType(index: Int) -> String {
           
           if let rating = self.rating {
               return index <= rating ? "star.fill" : "star"
           } else {
               return "star"
           }
           
       }
    func startProgressBar() {
            for _ in 0...80 {
                self.progressValue += 3
            }
        }
        
        func resetProgressBar() {
            self.progressValue = 1
        }
    
}
