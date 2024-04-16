//
//  orderDetailsPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/02/23.
//

import SwiftUI
import SwiftyJSON
struct orderDetailsPageUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State  var text: String = ""
    @State private var searchText = ""
    @State var ProductDetailsResponseModel:ProductDetailsResponse
    @State var DataFound = 0
    @Binding var productIdTemp :String
    @State var AddToCartResponse:JSON = []
    @State var GoToCartisPresent  = false
    @State var options = ["1", "2", "3", "4","5","6","7","8","9","10","11", "12", "13", "14","15","16","17","18","19","20"]
    @State var selectedQTY = "1"
    @State var starratingisPresent = false
    @State var HomePageisPresent = false
    @State var showLoader = false
    @State var productisPresent = false
    @State var QryIs = ""
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
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
                                HStack{
                                    TextField("Search for what you are looking for", text: $text)
                                        .padding(7)
                                        .padding(.horizontal, 25)
                                        .font(.system(size: 15))
                                        .frame( height: 45)
                                        .background(Color("backColor1"))
                                        .cornerRadius(6)
                                                    .overlay(
                                                        HStack {
                                                            Image(systemName: "magnifyingglass")
                                                                .foregroundColor(.gray)
                                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                                .padding(.leading, 8)
                                    
                                                          
                                                        }
                                                    )
                                }
                               // LSearchBar(text: $searchText)
                                    .padding(.top,48)
                                
                                
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
                    ScrollView(.vertical,showsIndicators: false){
                        
                        VStack{
                            HStack{
                                Text("Brand:\(ProductDetailsResponseModel.brandname ?? "")")
                                    .font(.custom("SourceSansPro-Regular", size: 14))
                                    .padding(.leading,12)
                                    .foregroundColor(Color("backColor"))
                                Spacer()
                                Button(action: {
                                    starratingisPresent = true
                                }, label: {
                                    VStack{
                                        if ProductDetailsResponseModel.averageRatting == 0 {
                                            Text("Add Rating")
                                                .font(.system(size: 12))
                                                .frame(width: 80,height: 20,alignment: .center)
                                                //.background(Color.black.opacity(0.5))
                                                .cornerRadius(6)
                                                .foregroundColor(Color.gray.opacity(0.8))
                                                .padding(.trailing,12)
                                        }else {
                                            HStack{
                                                HStack{
                                                    Image(systemName: "star.fill")
                                                        .font(.system(size: 10))
                                                        .foregroundColor(Color.white)
                                                        .padding(.leading,6)
                                                    Text("\(ProductDetailsResponseModel.averageRatting ?? 0)")
                                                        .font(.system(size: 12))
                                                        .padding(.trailing,6)
                                                        .foregroundColor(Color.white)
                                                }.padding(.all,2)
                                                   .background(Color.orange)
                                                    .cornerRadius(6)
                                                Text("\(ProductDetailsResponseModel.totalReview ?? 0) Ratings")
                                                    .font(.system(size: 10))
                                                    .foregroundColor(Color.gray.opacity(0.8))
                                                    .padding(.trailing,9)
                                            }
                                         
                                           
                                        }
             
                                    } .padding(.trailing,12)
                                }).fullScreenCover(isPresented: $starratingisPresent,onDismiss: {
                                    ProductDetailsApi(Productid: "\(productIdTemp)")
                                }){
        // StarRatingUIView()
                                    orderReviewPageUIView( ProductDetailsResponseModel: $ProductDetailsResponseModel, tempProductId: $productIdTemp, productIdTemp: $productIdTemp, ratings: $DataFound, barRate: 0)
                                }
                           
                                    
                            }
                            HStack {
                                Text("\(ProductDetailsResponseModel.productname ?? "")")
                                    //.font(.system(size: 14).bold())
                                    .font(.custom("SourceSansPro-Bold", size: 16).bold())
                                    .lineLimit(1)
                                    .foregroundColor(Color("backColor"))
                                    .padding(.leading,12)
                                Spacer()
                            }

                        }
                        //Image slider
                        VStack{
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    TabView {
                                        ForEach(ProductDetailsResponseModel.images ?? [],id: \.self){item in
                                           
                                                AsyncImage(url: URL(string: "\(item.url)")) { image in
                                                    image.resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: UIScreen.main.bounds.width-20, height: 280)
                                                        .padding(.top,12)
                                                        .padding(.bottom,12)


                                                } placeholder: {
                                                    Image("user (1)")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 35, height: 35)
                                                        .cornerRadius(25)
                                                        .padding(.leading,20)
                                                        .padding(.top,10)
                                                }
                                           }
                                    } .frame(width: UIScreen.main.bounds.width, height: 280)
                                    .tabViewStyle(PageTabViewStyle())
                               
                                    

                                }
                            }
//
                        }.frame(width: UIScreen.main.bounds.width,height: 280)
                            .background(Color.white)
                        VStack{
                            HStack {
                                Text("USD")
                                    .font(.system(size: 14))
                                    .padding(.leading,12)
                                Text("\(ProductDetailsResponseModel.productSellingprice ?? "")")
                                    .font(.system(size: 20).bold())
                                    .foregroundColor(Color.black)
                                Spacer()
                            }
                            if ProductDetailsResponseModel.discountPercent == "0"{
                                
                            }else if ProductDetailsResponseModel.discountPercent != "0"{
                                HStack{
                                    Text("~USD \(ProductDetailsResponseModel.productMrp ?? "")~")
                                        .font(.system(size: 12))
                                        .padding(.leading,12)
                                        .foregroundColor(Color.black.opacity(0.6))
                                    Text("\(ProductDetailsResponseModel.discountPercent ?? "") % Off")
                                        .font(.system(size: 12))
                                        .padding(.trailing,6)
                                        .foregroundColor(Color.green)
                                    Spacer()
                                }
                                
                            }

                        }
                        Rectangle().frame(width: UIScreen.main.bounds.width,height: 3)
                            .foregroundColor(Color("backColor2"))
                        HStack{
                            ForEach(ProductDetailsResponseModel.sizes ?? []){ item in
                                HStack{
                                    Text("\(item.size)")
                                        .font(.system(size: 14))
                                        .padding(.all,5)
                                        .padding(.leading,5)
                                        .padding(.trailing,5)
                                        .foregroundColor(Color.orange)
                                   
                                } .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color("backColor"), lineWidth: 1)
                                )
                                .padding(.leading,12)
                            }
                            
                            Spacer()
                        }
                        Rectangle().frame(width: UIScreen.main.bounds.width,height: 3)
                            .foregroundColor(Color("backColor2"))
                        VStack(spacing: 0){
                            HStack {
                                Text("Product overview and Specifications")
                                    .font(.custom("SourceSansPro-Bold", size: 16))
                                .padding(.leading,12)
                                .padding(.bottom,9)
                                Spacer()
//                                let detailhtml = "\(ProductDetailsResponseModel.productDetailsResponseDescription ?? "")"
//                                Text(detailhtml.html2String)
                               
                            }.background(Color("backColor1"))
                            
                            let htmlText = "\(ProductDetailsResponseModel.productDetailsResponseDescription ?? "")"
                            
                            ZStack{
                                VStack{
                                    
                                    HTMLStringView(htmlContent: "\(htmlText)")
                                        .padding(.leading,12)
                                    let htmlText1 = "\(ProductDetailsResponseModel.specification ?? "")"
                                    // Text(htmlText1.htmlToString)
                                    HTMLStringView(htmlContent: "\(htmlText1)")
                                        .padding(.leading,12)
                                   
                                }
                                .frame(width: UIScreen.main.bounds.width,height: 250,alignment: .center)
                               
                                
                            }
                        }.frame(width: UIScreen.main.bounds.width,alignment: .leading)
                            .background(.white)
                            //.background(Color("backColor1"))
                        VStack{
                            if (ProductDetailsResponseModel.similarproducts?.count == 0 ){
//                                Text("Related Products")
//                                    .font(.custom("SourceSansPro-Bold", size: 22))
//                                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
//                                    .padding(.leading,20)
//                                    .padding(.top,9)
                            }else{
                                Text("Related Products")
                                    .font(.custom("SourceSansPro-Bold", size: 16))
                                    .frame(width: UIScreen.main.bounds.width,alignment: .leading)
                                    .padding(.leading,20)
                                    .padding(.top,9)
                                    //.foregroundColor(.red)
                            }
                           
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(ProductDetailsResponseModel.similarproducts ?? []){item in
                                        Button(action: {
                                            productIdTemp = item.productid ?? ""
                                            productisPresent = true
                                        }, label: {
                                            VStack{
                                                VStack(alignment: .center, spacing: 2){
                                                    HStack{
                                                        Spacer()
                                                        if item.isFav == 0 {
                                                            Image(systemName: "heart")
                                                                .font(.system(size: 14))
                                                                .frame(width: 12,height: 11)
                                                                .padding(.trailing,8)
                                                                .onTapGesture {
                                                                    AddWishApi(ProductID: "\(item.productid ?? "")")
                                                                    print("\(item.isFav ?? 0)")
                                                                }
                                                        }else if item.isFav == 1{
                                                            Image(systemName: "heart.fill")
                                                                .font(.system(size: 14))
                                                                .frame(width: 12,height: 11)
                                                                .padding(.trailing,8)
                                                                .foregroundColor(Color.red)
                                                                .onTapGesture {
                                                                    AddWishApi(ProductID: "\(item.productid ?? "")")
                                                                    print("\(item.isFav ?? 0)")
                                                                }
                                                        }
                                                        //                                                                Image(systemName:"heart")
                                                        //                                                                    .font(.system(size: 12))
                                                        //
                                                        //                                                                    .padding(.trailing,12)
                                                    }
                                                    VStack{
                                                        AsyncImage(url: URL(string: "\(item.imageurl ?? "")")) { image in
                                                            image.resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 107,height: 95)
                                                            
                                                            
                                                        } placeholder: {
                                                            Image("user (1)")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 107,height: 95)
                                                            
                                                        }
                                                    }
                                                    
                                                    HStack{
                                                        Text("\(item.productname ?? "")")
                                                            //.font(.system(size: 12))
                                                            .font(.custom("SourceSansPro-Black",size:12))
                                                            .frame(width: 140,height: 30,alignment: .leading)
                                                            .lineLimit(2)
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
                                                        Text("\(item.productSellingprice ?? "")")
                                                            //.font(.system(size: 12).bold())
                                                            .font(.custom("SourceSansPro-Bold", size: 14))
                                                            .foregroundColor(Color.black)
                                                        
                                                        Spacer()
                                                        if item.discountPercent == "0"{
                                                            
                                                        }else if item.discountPercent != "0"{
                                                            Text("\(item.discountPercent ?? "") % Off")
                                                                .font(.system(size: 10))
                                                                .padding(.trailing,6)
                                                                .foregroundColor(Color.green)
                                                        }
                                                    }
                                                    HStack{
                                                        if item.productMrp != item.productSellingprice{
                                                            Text("~USD\(item.productMrp ?? "")~")
                                                                .font(.system(size: 10))
                                                                .foregroundColor(Color.black.opacity(0.6))
                                                                .padding(.leading,8)
                                                        }else if item.productMrp == item.productMrp{
                                                            
                                                        }
                                                        
                                                        Spacer()
                                                        if item.totalRating != 0 {
                                                            Text("★ \(item.totalRating ?? 0) Ratings")
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
                                        }).fullScreenCover(isPresented: $productisPresent){
                                            ProductPageUIView( text: "",  ProductDetailsResponseModel: ProductDetailsResponse(status: "", msg: "", brandname: "", sellername: "", sellerID: "", productname: "", productDetailsResponseDescription: "", specification: "", discountPercent: "", sizeID: "", productMrp: "", productSellingprice: "", slug: "", isFavorite: 0, cartquantity: "", variants: [], sizes: [], cashbacks: [], images: [], reviews: [], similarproducts: [], attributes: [], totalReview: 0, averageRatting: 0, totalquatity: ""),  productIdTemp: $productIdTemp, AddToCartResponse: AddToCartResponse)
                                        }
                                       
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                Spacer()
                if Int(ProductDetailsResponseModel.cartquantity ?? "0") ?? 0 > 0{
                    VStack(spacing: 0){
                        
                        
                        HStack{
                           
                            Button(action: {
                               
                                GoToCartisPresent = true
                            }, label: {
                                
                                HStack{
                                    Spacer()
                                    Text("GO TO BAG")
                                        .font(.system(size: 20).bold())
                                        .foregroundColor(Color("backColor1"))
                                        .padding(.bottom,12)
                                    Spacer()
                                }.frame(width: UIScreen.main.bounds.width,height: 66,alignment: .center)
                                    
                            }).fullScreenCover(isPresented: $GoToCartisPresent){
                                ContentCartView()
                               // CartView( CartProductListResponseModel: CartProductResponse(status: "", msg: "", subtotal: "", totalshipping: 0, grandtotal: "", data: []), AddressResponseModel: MyAddressResponse(status: "", msg: "", data: []), CheckoutProductItemResponseModel: OrderReviewResponse(status: "", msg: "", walletAmountApplied: "", walletAmountRemaining: "", subtotal: "", totalshipping: "", userwalletamount: "", totalquantity: "", grandtotal: "", name: "", address: "", addresstype: "", zipcode: "", mobileno: "", buildingName: "", city: "", data: [])).tabItem{}
                            }
                           
                            Spacer()
                        }.frame(width:UIScreen.main.bounds.width-20,height: 56)
                            .background(Color.orange)
                       
                    }
                }else{
                    VStack(spacing: 0){
                        
                        
                        HStack{
                            HStack{
                                VStack(spacing: 0){
                                    VStack(spacing: 0){
                                        HStack{
                                            Text("QTY")
                                                .font(.system(size: 18))
                                                .padding(.leading,24)
                                                .foregroundColor(Color.black.opacity(0.5))
                                            Menu {
                                                // Text("Select Profile")
                                                ForEach(options, id:\.self){items in
                                                    
                                                    Button(action: {
                                                        QryIs = items
                                                        //StateIDiS = items.id
                                                        //  getCityApi()
                                                    }, label: {
                                                        Text("\(items )")
                                                    })
                                                    
                                                    
                                                }
                                                
                                                
                                            } label: {
                                                VStack{
                                                    
                                                    Image(systemName: "chevron.down")
                                                        .foregroundColor(Color.black.opacity(0.4))
                                                       
                                                    //.padding(.leading,80)
                                                    // .padding(.leading,12)
                                                    
                                                    
                                                }
                                            }
                                        }
                                        .padding(.leading,12)

                                        HStack{
                                           Spacer()
                                            Text("\(QryIs)")
                                                .font(.system(size: 18).bold())
                                               // .padding(.leading,40)
                                            Spacer()
                                            
       
                                        }.padding(.leading,12)

                                        Spacer()
                                    }.frame(width: 120)
//                                    Text("1")
//                                        .font(.system(size: 18).bold())
//                                        .padding(.bottom,8)
                                }
//
                                
                                
                            }
                            .background(Color("backColor1"))
                            Spacer()
                            VStack{
                                Button(action: {
                                    
                                    AddToCartApi(Productid: "\(productIdTemp)", QTY: "\(selectedQTY)")
                                }, label: {
                                    
                                    HStack{
                                        
                                        Text("ADD TO CART")
                                            .font(.system(size: 20).bold())
                                            .foregroundColor(Color("backColor1"))
                                            .padding(.bottom,12)
                                        
                                    }.frame(height: 68)
                                        .background(Color("backColor"))
                                })
                            }
                            //Spacer()
                        }.frame(width:UIScreen.main.bounds.width,height: 66)
                           
                       
                    }
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


        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "product-details", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "400"{
            }else if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(ProductDetailsResponse.self, from:responseData)
                ProductDetailsResponseModel = postResponse
                print(" Product  List Response:\(ProductDetailsResponseModel)")
                showLoader = false
            }

        }

    }
    func AddWishApi(ProductID:String){
        let parameters = [
            "product_id":ProductID,
            "customerid":NetworkManager.getUserId()
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "wishlist-product", parameters: parameters) { responseData in
            print("Response : ", responseData)
           // HomeApi(Customerid: "\(NetworkManager.getUserId())")
            ProductDetailsApi(Productid: "\(productIdTemp)")
        }
        
    }
    func AddToCartApi(Productid:String,QTY:String){
        let parameters = [
            "basketid":NetworkManager.getBasketID(),
            "quantity":QTY,
            "productid":Productid,
            "size":"\(ProductDetailsResponseModel.sizeID ?? "")"

        ]


        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "add-to-cart", parameters: parameters) { responseJson in
            print("Response : ", responseJson)
            AddToCartResponse = responseJson
            UpdateQTYApi(TypeQty: "\(selectedQTY)")
            if responseJson["message"].stringValue == "200" {
                //Show error msg
                AddToCartResponse = responseJson
               
                let basketid = responseJson["basketid"].stringValue
                UserDefaults.standard.set(responseJson["basketid"].stringValue, forKey: "BasketID")
                print("BasketID is :\(basketid)")
                ProductDetailsApi(Productid: "\(productIdTemp)")
            }else{
                let basketid = responseJson["basketid"].stringValue
                UserDefaults.standard.set(responseJson["basketid"].stringValue, forKey: "BasketID")
                print("BasketID is :\(basketid)")
                ProductDetailsApi(Productid: "\(productIdTemp)")
            }
//            let postResponse = try! JSONDecoder().decode(ProductDetailsResponse.self, from:responseJson)
//            ProductDetailsResponseModel = postResponse
//            print(" Product  List Response:\(ProductDetailsResponseModel)")

        }

    }
    func UpdateQTYApi(TypeQty:String){
        let parameters = [
            "basketid":NetworkManager.getBasketID(),
            "type":TypeQty
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "update-quantity", parameters: parameters) { responseData in
            print("Response : ", responseData)
  
        }
    }
}

struct orderDetailsPageUIView_Previews: PreviewProvider {
    static var previews: some View {
        orderDetailsPageUIView(ProductDetailsResponseModel: ProductDetailsResponse(status: "", msg: "", brandname: "", sellername: "", sellerID: "", productname: "", productDetailsResponseDescription: "", specification: "", discountPercent: "", sizeID: "", productMrp: "", productSellingprice: "", slug: "", isFavorite: 0, cartquantity: "", variants: [], sizes: [], cashbacks: [], images: [], reviews: [], similarproducts: [], attributes: [], totalReview: 0, averageRatting: 0, totalquatity: ""), productIdTemp: .constant("0"))
    }
}

