//
//  ReviewPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 22/11/22.
//

import SwiftUI
import SwiftyJSON
struct ReviewPageUIView: View {
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
               /* Button(action: {
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
               */
               
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

//struct ReviewPageUIView_Previews: PreviewProvider {
//    static var previews: some View {
//       // ReviewPageUIView()
//        StarRatingUIView()
//    }
//}
struct StarRatingUIView: View {
    @Environment(\.dismiss) var dismiss
    @State private var rating: Int?
    @State var writeReview :String = ""
    @Binding var ProductId:String
    var body: some View {
        VStack{
            RatingView(rating: $rating, max: 5)
                .padding(.top,150)
            if writeReview == "" {
               
            }
            Text(rating != nil ? "You rating: \(rating!)" : "")
            HStack{
                Text("Write your review..")
                    .foregroundColor(.gray)
                   // .background(Color.white)
                    .padding(.leading,20)
                    //.offset(x:10,y: 30)
                   
                Spacer()
            }
                TextEditor(text: $writeReview)
                .frame(width: UIScreen.main.bounds.width-40,height: 100)
             .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.blue, lineWidth: 1)
                )
             .onAppear(
             )
          
            HStack{
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                        .font(.system(size: 16).bold())
                        .frame(width: UIScreen.main.bounds.width / 2 - 10,height: 48)
                        .background(Color("backColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(6)
                    
                })
                Button(action: {
                    reviewProductApi(ProductId: "\(ProductId)", reviewStars: "\(rating!)", reviewMsg: "\(writeReview)")
                }, label: {
                    Text("Submit")
                        .font(.system(size: 16).bold())
                        .frame(width: UIScreen.main.bounds.width / 2 - 10,height: 48)
                        .background(Color("backColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(6)
                    
                })
            }.padding(.top,60)
          
            Spacer()
            
        }
        
       
    }
    func reviewProductApi(ProductId:String,reviewStars:String,reviewMsg:String){
        let parameters = [
            "customerid":NetworkManager.getUserId(),
            "review_stars":reviewStars,
            "review_name":NetworkManager.getUserName(),
            "review_email" :NetworkManager.getUserEmail(),
            "review_msg": reviewMsg,
            "product_id":ProductId,
           

        ]


        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "review-product", parameters: parameters) { responseData in
            print("Response : ", responseData)
            dismiss()
//            let postResponse = try! JSONDecoder().decode(ProductDetailsResponse.self, from:responseData)
//            ProductDetailsResponseModel = postResponse
//            print(" Product  List Response:\(ProductDetailsResponseModel)")

        }

    }
}
struct RatingView: View {
    
    @Binding var rating: Int?
    var max: Int = 5
   
    var body: some View {
           HStack {
               ForEach(1..<(max + 1), id: \.self) { index in
                   Image(systemName: self.starType(index: index))
                       .foregroundColor(Color.blue)
                       .font(.system(size: 30))
                       .onTapGesture {
                           self.rating = index
                   }
               }
           }.padding(.top,58)
       }
    
    private func starType(index: Int) -> String {
           
           if let rating = self.rating {
               return index <= rating ? "star.fill" : "star"
           } else {
               return "star"
           }
           
       }
}

struct ProgressBar: View {
    private let value: Double
    private let maxValue: Double
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    
    init(value: Double,
         maxValue: Double,
         backgroundEnabled: Bool = true,
         backgroundColor: Color = Color(UIColor(red: 262/255,
                                                green: 262/255,
                                                blue: 262/255,
                                                alpha: 1.0)),
         foregroundColor: Color = Color.black) {
        self.value = value
        self.maxValue = maxValue
        self.backgroundEnabled = backgroundEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        // 1
        ZStack {
            // 2
            GeometryReader { geometryReader in
                // 3
                if self.backgroundEnabled {
                   // Capsule()
                    Rectangle()
                        .foregroundColor(self.backgroundColor) // 4
                }
                
               // Capsule()
                Rectangle()
                    .frame(width: self.progress(value: self.value,
                                                maxValue: self.maxValue,
                                                width: geometryReader.size.width)) // 5
                    .foregroundColor(self.foregroundColor) // 6
                    .animation(.easeIn) // 7
            }
        }
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

