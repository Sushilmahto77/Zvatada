//
//  WhatsHotUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
struct WhatsHotUIView: View {
    @State var HomeResponseModel : HomeResponse
    // @State var ProductSlabModel : ProductSlab
    @State var TempProductID:String
    @State var ProductDetailsisPresent = false
    @State var bannerHome:JSON = []
    @State var TempIdSubCat:String
    @State var SearchisPresent = false
    @State var showLoader = false
    @State var SignUpisPresented = false
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                VStack{
                    HStack{
                        Spacer()
                        VStack{
                            Image("Plain blue on white version")
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(width: 200,height:200)
                                .padding(.leading,40)
                            
                        }
                        Spacer()
                        VStack{
                            if NetworkManager.getUserId() == ""{
                               
                             Button(action: {
                                 SignUpisPresented = true
                             }, label: {
                                 HStack{
                                     Text("Log In")
                                         .foregroundColor(Color("AccentColor"))
                                         .font(.system(size: 14).bold())
                                         //.padding(.top,20)
                                        
                                        
                                 }.frame(width: 48,alignment: .trailing)
                                     .padding(.trailing,12)
                                    // .background(.white)
                             }).fullScreenCover(isPresented: $SignUpisPresented){
                                 LoginPageUIView()
                             }
                               // ContentView()
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width,height: 50)
                    .padding(.top,48)
                    Button(action: {
                        SearchisPresent = true
                    }, label: {
                        VStack{
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.black.opacity(0.6))
                                    .padding(.leading,12)
                                Text("Search for what you are looking for")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.black.opacity(0.8))
                                Spacer()
                            }
                        }.frame(width: UIScreen.main.bounds.width-20,height: 48)
                            .background(Color.white)
                            .cornerRadius(6)
                            .shadow(color: .black.opacity(0.2), radius: 2)
                    }).fullScreenCover(isPresented: $SearchisPresent){
                        SearchPageUIView( ProSearchtext: "", CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCatId: "")
                    }
                    
                }
                
                //Best Selling
                ScrollView(.vertical,showsIndicators: false){
                    VStack {
                        AsyncImage(url: URL(string: "\("")")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width,height: 140,alignment: .center)
                                .padding(.top,12)
                                .padding(.bottom,12)
                            
                            
                        } placeholder: {
                            VStack{
                                Image("Banner1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .padding(.top,12)
                                    .padding(.bottom,12)
                            }.frame(width: UIScreen.main.bounds.width,height: 140,alignment: .center)
                            
                        }
                        
                    }.padding(.top,12)
                        .padding(.bottom,12)
                    VStack{
                        ForEach(HomeResponseModel.productSlab ?? [] , id: \.id){ item in
                            //Imagebanner = item.stripbanner
                            // Text("BEST SELLING")
                            
                            Text("\(item.stripname ?? "")")
                                //.font(.system(size: 20).bold())
                                .font(.custom("SourceSansPro-Bold", size: 22))
                                .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                .padding(.leading,20)
                                .padding(.top,12)
                                .foregroundColor(Color.black)
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack(spacing:0){
                                    ForEach(item.products ?? [],id: \.id) { position in
                                        VStack{
                                            Button(action: {
                                                TempProductID = position.productid ?? ""
                                                ProductDetailsisPresent = true
                                            }, label: {
                                                VStack{
                                                    VStack(alignment: .center, spacing: 2){
                                                        HStack{
                                                            Spacer()
                                                            if position.isFav == 0 {
                                                                Image(systemName: "heart")
                                                                    .font(.system(size: 14))
                                                                    .frame(width: 12,height: 11)
                                                                    .padding(.trailing,8)
                                                                    .onTapGesture {
                                                                        AddWishApi(ProductID: "\(position.productid ?? "")")
                                                                        print("\(position.isFav ?? 0)")
                                                                    }
                                                            }else if position.isFav == 1{
                                                                Image(systemName: "heart.fill")
                                                                    .font(.system(size: 14))
                                                                    .frame(width: 12,height: 11)
                                                                    .padding(.trailing,8)
                                                                    .foregroundColor(Color.red)
                                                                    .onTapGesture {
                                                                        AddWishApi(ProductID: "\(position.productid ?? "")")
                                                                        print("\(position.isFav ?? 0)")
                                                                    }
                                                            }
                                                            //                                                                Image(systemName:"heart")
                                                            //                                                                    .font(.system(size: 12))
                                                            //
                                                            //                                                                    .padding(.trailing,12)
                                                        }
                                                        VStack{
                                                            AsyncImage(url: URL(string: "\(position.imageurl ?? "")")) { image in
                                                                image.resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 107,height: 86)
                                                                
                                                                
                                                            } placeholder: {
                                                                Image("user (1)")
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 107,height: 86)
                                                                
                                                            }
                                                        }
                                                        
                                                        HStack{
                                                            Text("\(position.productname ?? "")")
                                                                .font(.custom("SourceSansPro-Black",size:12))
                                                                .frame(width: 140,height: 32,alignment: .leading)
                                                                .lineLimit(3)
                                                                .multilineTextAlignment(.leading)
                                                                .padding(.leading,8)
                                                                .foregroundColor(Color.black.opacity(0.8))
                                                            Spacer()
                                                        }
                                                        HStack{
                                                            Text("USD")
                                                                .font(.custom("SourceSansPro-Bold", size: 14))
                                                                .foregroundColor(Color.black)
                                                                .padding(.leading,8)
                                                            Text("\(position.productSellingprice ?? "")")
                                                                .font(.custom("SourceSansPro-Bold", size: 16))
                                                                .foregroundColor(Color.black)
                                                            
                                                            Spacer()
                                                            if position.discountPercent == "0"{
                                                                
                                                            }else if position.discountPercent != "0"{
                                                                Text("\(position.discountPercent ?? "") % Off")
                                                                    .font(.system(size: 10))
                                                                    .padding(.trailing,6)
                                                                    .foregroundColor(Color.green)
                                                            }
                                                        }
                                                        HStack{
                                                            if position.productMrp != position.productSellingprice{
                                                                Text("~USD\(position.productMrp ?? "")~")
                                                                    .font(.system(size: 10))
                                                                    .foregroundColor(Color.black.opacity(0.6))
                                                                    .padding(.leading,8)
                                                            }else if position.productMrp == position.productMrp{
                                                                
                                                            }
                                                            
                                                            Spacer()
                                                            if position.totalRating != 0 {
                                                                Text("★ \(position.totalRating ?? 0) Ratings")
                                                                    .font(.system(size: 10))
                                                                    .padding(.trailing,6)
                                                                    .foregroundColor(Color.red)
                                                            }
                                                        }
                                                    }.frame(width: 160,height: 180,alignment: .center)
                                                        .background(Color.white)
                                                        .cornerRadius(6)
                                                        .padding(.leading,6)
                                                        .shadow(color: .gray.opacity(0.4), radius: 2)
                                                }.padding(.leading,12)
                                            }).fullScreenCover(isPresented: $ProductDetailsisPresent){
                                                ProductPageUIView(text: "",  ProductDetailsResponseModel: ProductDetailsResponse(status: "", msg: "", brandname: "", sellername: "", sellerID: "", productname: "", productDetailsResponseDescription: "", specification: "", discountPercent: "", sizeID: "", productMrp: "", productSellingprice: "", slug: "", isFavorite: 0, cartquantity: "", variants: [], sizes: [], cashbacks: [], images: [], reviews: [], similarproducts: [], attributes: [], totalReview: 0, averageRatting: 0, totalquatity: ""),  productIdTemp: $TempProductID, AddToCartResponse: bannerHome)
                                            }
                                        }
                                        
                                    }
                                    
                                }.padding(.bottom,12)
                                    .padding(.trailing,12)
                                
                                // }
                                
                            }
                            
                            //Banner
                            
                            VStack {
                                AsyncImage(url: URL(string: "\(item.stripbanner ?? "")")) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width,height: 140,alignment: .center)
                                        .padding(.top,12)
                                        .padding(.bottom,12)
                                    
                                    
                                } placeholder: {
                                    VStack{
                                        Image("Banner1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .padding(.top,12)
                                            .padding(.bottom,12)
                                    }.frame(width: UIScreen.main.bounds.width,height: 140,alignment: .center)
                                    
                                }
                                
                            }.padding(.top,12)
                                .padding(.bottom,12)
                            
                        }.padding(.bottom,9)
                        
                    }.padding(.bottom,90)
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
                HomeApi(Customerid: "\(NetworkManager.getUserId())")
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
            HomeApi(Customerid: "\(NetworkManager.getUserId())")
        }
        
    }
    func HomeApi(Customerid:String){
        let parameters = [
            "customerid":Customerid,
            
        ]
        showLoader = true
        
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "home-page", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "400"{
            }else if swiftyJsonVar["status"].stringValue == "200"{

                let postResponse = try! JSONDecoder().decode(HomeResponse.self, from:responseData)
                HomeResponseModel = postResponse
                // ProductSlabModel = HomeResponseModel[ProductSlab]
                print(" Home Response:\(HomeResponseModel)")
                showLoader = false
            }

        }
        
        
        
    }
}

struct WhatsHotUIView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsHotUIView(HomeResponseModel: HomeResponse(status: "", msg: "", sliders: [], categories: [], productSlab: []), TempProductID: "", TempIdSubCat: "")
    }
}
