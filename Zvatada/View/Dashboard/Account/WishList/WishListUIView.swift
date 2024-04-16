//
//  WishListUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

import SwiftUI
import SwiftyJSON
struct WishListUIView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @Environment(\.presentationMode) var presentationMode
    @State  var text: String = ""
    @State private var searchText = ""
    @State var WishListResponseModel : WishListResponse
    @State var HomePageisPresent = false
    @State var SearchisPresent = false
    @State var showLoader = false
    @State var TempProductID:String
    @State var ProductDetailsisPresent = false
    @State var bannerHome:JSON = []
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                VStack{
                    VStack{
                        HStack{
                            Button(action: {
                                
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 30))
                                    .foregroundColor(Color.white)
                                    .padding(.top,48)
                                //.padding(.leading,20)
                            }
                            .padding(.leading,24)
                            Button(action: {
                                SearchisPresent = true
                            }, label: {
                                VStack{
                                    //LSearchBar(text: $searchText)
                                    HStack{
                                        Image(systemName: "magnifyingglass")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.black.opacity(0.5))
                                        Text("Search for what you are looking for")
                                            .font(.system(size: 15))
                                            .foregroundColor(Color.black.opacity(0.5))
                                    }
                                  
                                        //.padding(7)
                                        //.padding(.horizontal, 10)
                                        
                                       
                                       
                                } .frame( width: 300,height: 45)
                                    .background(.white)
                                    .cornerRadius(6)
                                    .padding(.top,48)
                            }).fullScreenCover(isPresented: $SearchisPresent){
                                SearchPageUIView(ProSearchtext: "",  CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCatId: "")
                            }
                           
                            
                            
                            Spacer()
                            Button(action: {
                                HomePageisPresent = true
                            }, label: {
                                VStack{
                                    Image("Asset 1")
                                        .resizable()
                                        .aspectRatio( contentMode: .fit)
                                        .frame(width: 40,height: 40)
                                        .padding(.trailing,20)
                                    
                                        .padding(.top,48)
                                }
                                
                            }).fullScreenCover(isPresented: $HomePageisPresent){
                                ContentView()
                            }
                        }
                        
                        
                    }
                }.frame(width: UIScreen.main.bounds.width,height: 120)
                    .background(Color("backColor"))
                
                
                VStack{
                    HStack(spacing: 0){
                        Text("My Wishlist")
                            .font(.custom("SourceSansPro-Bold", size: 20))
                            .padding(.leading,20)
                            .padding(.top,9)
                        Spacer()
                        
                    }
                    
                    ScrollView (.vertical,showsIndicators: false){
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(WishListResponseModel.data ?? []){item in
//                            ForEach(product1.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { item in
                                
                                Button(action: {
                                    TempProductID = item.productid ?? ""
                                    ProductDetailsisPresent = true
                                }, label: {
                                    VStack {
                                        HStack{
                                            Spacer()
                                            if item.isFav == 0 {
                                                Image(systemName: "heart")
                                                    .font(.system(size: 16))
                                                    .padding(.all,6)
                                                    .onTapGesture {
                                                        AddWishApi(ProductID: "\(item.productid)")
                                                    }
                                            }else{
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 16))
                                                    .padding(.all,6)
                                                    .foregroundColor(Color.red)
                                                    .onTapGesture {
                                                        AddWishApi(ProductID: "\(item.productid)")
                                                    }
                                            }
                                           
                                            
                                        }
                                        VStack(spacing:0){
                                            VStack {
                                                AsyncImage(url: URL(string: "\(item.imageurl)")) { image in
                                                    image.resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 120, height: 124)
                                                        
                                                    
                                                } placeholder: {
                                                    Image("user (1)")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 120, height: 124)
                                                        .cornerRadius(25)
                                                        .padding(.leading,20)
                                                        .padding(.top,10)
                                                }
                                              
                                                
                                            }//.background(Color.yellow)
                                            Text("\(item.productname)")
                                                .font(.system(size: 9))
                                                .frame(width: 170,height: 28,alignment:.leading)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(3)
                                                .foregroundColor(Color.black)
                                                .padding(.leading,6)
                                          //  VStack(alignment: .leading,spacing: 0) {
                                               
                                              
                                                    HStack{
                                                     
                                                        Text("USD")
                                                            .font(.system(size: 9))
                                                            .padding(.leading,3)
                                                            .foregroundColor(Color.gray)
                                                        
                                                        Text("\(item.productSellingprice)")
                                                            .font(.system(size: 12).bold())
                                                              .foregroundColor(Color.black)
                                                        Spacer()
                                                        if item.discountPercent == "0"{
                                                            Text("\(item.discountPercent)% OFF")
                                                             .font(.system(size: 12).bold())
                                                                .padding(.trailing,11)
                                                                .foregroundColor(Color.white)
                                                        }else{
                                                            Text("\(item.discountPercent)% OFF")
                                                             .font(.system(size: 12).bold())
                                                                .padding(.trailing,11)
                                                                .foregroundColor(Color.green)
                                                        }
                                                       
                                                    } .frame(width: 170,alignment:.leading)
                                             
                                                HStack{
                                                 
                                                    if item.productMrp != item.productSellingprice{
                                                        Text("~USD \(item.productMrp)~")
                                                            .font(.system(size: 9).bold())
                                                            .foregroundColor(Color.gray)
                                                            .padding(.leading,3)
                                                    }
                                                    Spacer()
                                                    if item.totalRating != 0 {
                                                        Text("★ \(item.totalRating ?? 0) Rating")
                                                            .font(.system(size: 10).bold())
                                                            .padding(.trailing,11)
                                                            .foregroundColor(Color.red)
                                                    }
                                                } .frame(width: 170,alignment:.leading)
                                                .padding(.bottom,6)
                                                
                                                Spacer()
                                               
                                           // }.frame(width: UIScreen.main.bounds.width / 2, height: 80, alignment: .leading)
                                                
                                            //.background(Color.green)
                                            
                                        }
                                        .frame(width: UIScreen.main.bounds.width / 2 - 20 , height: 180, alignment: .center)
                                        
                                        
                                        
                                    }
                                }).fullScreenCover(isPresented: $ProductDetailsisPresent){
                                    ProductPageUIView(text: "",  ProductDetailsResponseModel: ProductDetailsResponse(status: "", msg: "", brandname: "", sellername: "", sellerID: "", productname: "", productDetailsResponseDescription: "", specification: "", discountPercent: "", sizeID: "", productMrp: "", productSellingprice: "", slug: "", isFavorite: 0, cartquantity: "", variants: [], sizes: [], cashbacks: [], images: [], reviews: [], similarproducts: [], attributes: [], totalReview: 0, averageRatting: 0, totalquatity: ""),  productIdTemp: $TempProductID, AddToCartResponse: bannerHome)
                                }
                                
                                
                                .background(Color.white)
                                .cornerRadius(8)
                                .padding(.top,6)
                            }
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width-12)
                    
                    
                    
                }
                
                Spacer()
            }
            if self.showLoader{
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                   
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                MyWishListApi(Customerid: NetworkManager.getUserId())
                showLoader = true
            }
    }
    func AddWishApi(ProductID:String){
        let parameters = [
            "product_id":ProductID,
            "customerid":NetworkManager.getUserId()
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "wishlist-product", parameters: parameters) { responseData in
            print("Response : ", responseData)
            MyWishListApi(Customerid: NetworkManager.getUserId())
            showLoader = false
        }
        
    }
    func MyWishListApi(Customerid:String){
        let parameters = [
            "customerid":Customerid
            
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "my-wishlists", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "400"{
            }else if swiftyJsonVar["status"].stringValue == "200"{
                
                
                let postResponse = try! JSONDecoder().decode(WishListResponse.self, from:responseData)
                WishListResponseModel = postResponse
                print(" WishList Response:\(WishListResponseModel)")
                showLoader = false
            }
            
        }
        
    }
}

struct WishListUIView_Previews: PreviewProvider {
    static var previews: some View {
        WishListUIView( WishListResponseModel: WishListResponse(status: "", msg: "", totalWishlist: 0, data: []), TempProductID: "")
    }
}
