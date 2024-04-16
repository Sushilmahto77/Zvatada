//
//  SubCategoriesUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 05/11/22.
//

import SwiftUI
import SwiftyJSON
struct subCategoryPage:View{
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @Environment(\.presentationMode) var presentationMode
    @State var DataFound = 0
    @Binding  var ProSearchtext: String
    @State var PsearchText: String = ""
    @State var ProductTempId :String
    @State var CategoryListResponseModel:ProductListResponse
    @Binding var TempCategorysubID :String
    @State var HomePageisPresent = false
    @State var SearchisPresent = false
    @State var CatFilterisPresent = false
    @State var sortFilterisPresent = false
    @State var sizelostFilterisPresent = false
    @State var brandFilterisPresent = false
    @Binding var TempProductId:String
    @Binding var brandIDis:String 
    @Binding var sizeIDis:String
    @State var productDetailisPresent = false
    @State var tapped = false
    @State var showLoader = false
    @State var ProductListDatumResponse:[ProductListDatum] = []
    @State var totalrecords = 0
    @State private var currentPage = 1
    @State var itenCount = 0
    var body: some View{
        ZStack{
            Color("backColor1")
            VStack{
                VStack{
                    VStack{
                        HStack{
                            Button(action: {
                                
                                presentationMode.wrappedValue.dismiss()
                                brandIDis = ""
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
                                SearchPageUIView( ProSearchtext: PsearchText, CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCatId: TempCategorysubID)
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
                if (DataFound == 2){
                    NoDataFoundPage()
                    
                }else if (DataFound == 1){
                   
                    //SubCategoriesUIView(CategoryList1ResponseModel: $CategoryListResponseModel, text: $searchText, TempProductId: $TempCategorysubID, TempCategorysubID: $TempCategorysubID)
                    VStack{
                        HStack(spacing: 14){
                            Button(action: {
                                CatFilterisPresent = true
                            }, label: {
                                HStack{
                                    Text("Category")
                                        .font(.system(size: 16))
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 12))
                                }.padding(.all,5)
                                    .background(Color("backColor2"))
                                    .cornerRadius(6)
                                    .foregroundColor(Color.black)
                            }).sheet(isPresented: $CatFilterisPresent,onDismiss:{
                                ProductListApi(searchtext: "\(ProSearchtext)", catid: "\(TempCategorysubID)", SortValue: "\(TempCategorysubID)", brand: "", size: "")
                            }){
                                CategoriesFilterView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), tempCatFilterId: $TempCategorysubID, catProductID: $TempCategorysubID, num: "", searchText: "", brandIDis: $brandIDis, sizeIDis: $sizeIDis)
                            }
                            Button(action: {
                                brandFilterisPresent = true
                            }, label: {
                                HStack{
                                    Text("Brand")
                                        .font(.system(size: 16))
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 12))
                                }.padding(.all,5)
                                    .background(Color("backColor2"))
                                    .cornerRadius(6)
                                    .foregroundColor(Color.black)
                            }).sheet(isPresented: $brandFilterisPresent, content: {
                                BrandFilterView(catID: $TempCategorysubID, sortValue: $TempCategorysubID, searchText: "", BrandResponseModel: BrandModel(status: "", msg: "", data: []), brandIDis: $brandIDis, sizeIDis: $sizeIDis)
                            })

                            Button(action: {
                                ProductTempId = TempCategorysubID
                                sortFilterisPresent = true
                            }, label: {
                                HStack{
                                    Text("Sort")
                                        .font(.system(size: 16))
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 12))
                                }.padding(.all,5)
                                    .background(Color("backColor2"))
                                    .cornerRadius(6)
                                    .foregroundColor(Color.black)
                            }).sheet(isPresented: $sortFilterisPresent ,onDismiss:{
                                ProductListApi(searchtext: "\(ProSearchtext)", catid: "\(TempCategorysubID)", SortValue: "\(TempProductId)", brand: "\(brandIDis)", size: "\(sizeIDis)")
                            }){
                                SortFilterView( catID: $ProductTempId, sortValue: $TempCategorysubID, isChecked: false, num: "", searchText: "", brandIDis: $brandIDis, sizeIDis: $sizeIDis)
                                //
                            }
                           Button(action: {
                               sizelostFilterisPresent = true
                           }, label: {
                               HStack{
                                   Text("Size")
                                       .font(.system(size: 16))
                                   Image(systemName: "arrowtriangle.down.fill")
                                       .font(.system(size: 12))
                                       .foregroundColor(Color.black)
                               }.padding(.all,5)
                                   .background(Color("backColor2"))
                                   .cornerRadius(6)
                                   .foregroundColor(Color.black)
                           }).sheet(isPresented: $sizelostFilterisPresent, content: {
                               SizeFilterView(SizelistResponseModel: SizelistModel(status: "", msg: "", data: []), catID: $TempCategorysubID, sortValue: $TempCategorysubID, searchText: "", brandIDis: $brandIDis, sizeIDis: $sizeIDis)
                           })

                        }
                        VStack{
                            ScrollView (.vertical,showsIndicators: false){
                                VStack{
                                    LazyVGrid(columns: columns, spacing: 0) {
                                        // ForEach(CategoryListResponseModel.data){item in

                                        // ForEach(CategoryList1ResponseModel.data.filter({ searchText.isEmpty ? true : $0.categoryname.contains(searchText) })) { item in
                                        ForEach(ProductListDatumResponse){item in
                                            Button(action: {
                                                TempProductId = item.productid
                                                productDetailisPresent = true
                                            }, label: {
                                                VStack {
                                                    HStack{
                                                        Spacer()

                                                        if item.isFav == 0{

                                                            Image(systemName: "heart")
                                                                .font(.system(size: 16))
                                                                .padding(.all,6)
                                                                .onTapGesture {
                                                                    AddWishApi(ProductID: "\(item.productid)")
                                                                    print("Tapped")
                                                                    tapped = true
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { tapped = false }
                                                                }

                                                        }else{
                                                            Image(systemName: "heart.fill")
                                                                .font(.system(size: 16))
                                                                .padding(.all,6)
                                                                .foregroundColor(Color.red)
                                                                .onTapGesture {
                                                                    print("Tapped 1")
                                                                    AddWishApi(ProductID: "\(item.productid)")
                                                                    tapped = true
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { tapped = false }
                                                                }
                                                        }

                                                    }
                                                    VStack(spacing:0){
                                                        VStack {
                                                            AsyncImage(url: URL(string: "\(item.imageurl)")) { image in
                                                                image.resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 150, height: 154)


                                                            } placeholder: {
                                                                Image("user (1)")
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 150, height: 154)
                                                                    .cornerRadius(25)
                                                                    .padding(.leading,20)
                                                                    .padding(.top,10)
                                                            }
                                                            //                                                Image(item.image)
                                                            //                                                    .resizable()
                                                            //                                                    .aspectRatio(contentMode: .fit)
                                                            //                                                    .frame(width: 160, height: 164)

                                                        }//.background(Color.yellow)
                                                        VStack(alignment: .leading,spacing: 0) {
                                                            HStack {
                                                                Text("\(item.productname)")
                                                                    .font(.system(size: 12))
                                                                    .multilineTextAlignment(.leading)
                                                                    .lineLimit(2)

                                                                    .foregroundColor(Color.black)
                                                                    .padding(.leading,6)
                                                                Spacer()

                                                            }.frame(width:UIScreen.main.bounds.width / 2 - 10,height: 32)


                                                            HStack{

                                                                Text("USD")
                                                                    .font(.system(size: 14))
                                                                    .padding(.leading,6)
                                                                    .foregroundColor(Color.gray)

                                                                Text("\(item.productSellingprice)")
                                                                    .font(.system(size: 14).bold())
                                                                    .foregroundColor(Color.black)
                                                                Spacer()
                                                                //                                                    Text("30% OFF")
                                                                //                                                     .font(.system(size: 12).bold())
                                                                //                                                        .padding(.trailing,11)
                                                                //                                                        .foregroundColor(Color.green)
                                                            }
                                                            //                                                HStack{
                                                            //
                                                            //                                                    Text("USD")
                                                            //                                                        .font(.system(size: 9))
                                                            //                                                        .padding(.leading,6)
                                                            //                                                        .foregroundColor(Color.gray)
                                                            //
                                                            //                                                       Text("1,119.99")
                                                            //                                                        .font(.system(size: 9).bold())
                                                            //                                                          .foregroundColor(Color.gray)
                                                            //                                                    Spacer()
                                                            //                                                    Text("★ 4.7 (5K)")
                                                            //                                                     .font(.system(size: 10).bold())
                                                            //                                                        .padding(.trailing,11)
                                                            //                                                        .foregroundColor(Color.green)
                                                            //                                                }

                                                            Spacer()

                                                        }.frame(width: 170, height: 80, alignment: .leading)

                                                        //.background(Color.green)



                                                    }
                                                    .frame(width: UIScreen.main.bounds.width / 2 - 10, height: 200, alignment: .center)



                                                }.onAppear{
                                                    itenCount = ProductListDatumResponse.count
                                                }
                                            }).fullScreenCover(isPresented: $productDetailisPresent){
                                                ProductPageUIView( ProductDetailsResponseModel: ProductDetailsResponse(status: "", msg: "", brandname: "", sellername: "", sellerID: "", productname: "", productDetailsResponseDescription: "", specification: "", discountPercent: "", sizeID: "", productMrp: "", productSellingprice: "", slug: "", isFavorite: 0, cartquantity: "0", variants: [], sizes: [], cashbacks: [], images: [], reviews: [], similarproducts: [], attributes: [], totalReview: 0, averageRatting: 0, totalquatity: "0"), productIdTemp: $TempProductId)
                                            }


                                            .background(Color.white)
                                            .cornerRadius(8)
                                            .padding(.top,6)
                                        }
                                    }
                                    Spacer()
                                    let a =  totalrecords/20
                                    let b = a-1
                                    if currentPage < b {
                                        VStack{
                                            Text("Load More..")
                                                .font(.system(size: 14).bold())
                                                .foregroundColor(Color.white)
                                        }.frame(width: 180,height: 40)
                                            .background(Color("backColor"))
                                            .cornerRadius(12)
                                            .padding(.top,9)
                                            .padding(.bottom,9)
                                            .onTapGesture{

                                                if totalrecords != itenCount {
                                                    currentPage += 1
                                                }

                                                NextProductListApi(searchtext: "\(ProSearchtext)", catid: "\(TempCategorysubID)", SortValue: "\(TempProductId)", brand:  "\(brandIDis)", index: "\(currentPage)", size: "\(sizeIDis)")
                                            }
                                    }
                                }
                                //.rotationEffect(.init(degrees: 180))
                            }.frame(width: UIScreen.main.bounds.width-12)

                                .refreshable {
                                    do {
                                        // Fetch and decode JSON into news items
                                        let a =  totalrecords/20
                                        let b = a-1
                                        if currentPage < b {
                                            NextProductListApi(searchtext: "\(ProSearchtext)", catid: "\(TempCategorysubID)", SortValue: "\(TempProductId)", brand:  "\(brandIDis)", index: "\(currentPage)", size: "\(sizeIDis)")
                                        }
                                    } catch {
                                        // Something went wrong; clear the news
                                        print("2")
                                    }
                                }
                        }
                        //.rotationEffect(.init(degrees: 180))




                    }
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
               // ProductListApi(searchtext: "\(ProSearchtext)", catid: "\(TempProductId)",SortValue: "\(TempCategorysubID)")
                ProductListApi(searchtext: "\(ProSearchtext)", catid: "\(TempCategorysubID)",SortValue: "\(TempProductId)", brand: "\(brandIDis)", size: "\(sizeIDis)")
                showLoader = true
              }
    }
    func ProductListApi(searchtext:String,catid:String,SortValue:String,brand:String,size:String){
        let parameters = [
            "basketid":NetworkManager.getBasketID(),
            "customerid":NetworkManager.getUserId(),
            "cat_id":catid,
            "sortby":SortValue,
            "brand":brand,
            "index":"0",
            "searchtext":searchtext,
            "size":size,

        ]


        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "product-list", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].intValue == 200{
                let postResponse = try! JSONDecoder().decode(ProductListResponse.self, from:responseData)
                CategoryListResponseModel = postResponse
                print(" subCategory List Response:\(CategoryListResponseModel.totalrecords)")
                totalrecords = CategoryListResponseModel.totalrecords
                for customer in  CategoryListResponseModel.data {

                    let customer2 = ProductListDatum( productid: customer.productid, productname: customer.productname, imageurl: customer.imageurl, discountPercent: customer.discountPercent, qty: customer.qty, totalRating: customer.totalRating, sizeID: customer.sizeID, productMrp: customer.productMrp, productSellingprice: customer.productSellingprice, itemincart: customer.itemincart, isFav: customer.isFav, bestSeller: customer.bestSeller)
                    ProductListDatumResponse.append(customer2)

                }
                DataFound = 1
                showLoader = false
            }else{
                DataFound = 2
                showLoader = false
            }
           

        }

    }
    func NextProductListApi(searchtext:String,catid:String,SortValue:String,brand:String,index:String,size:String){
        let parameters = [
            "basketid":NetworkManager.getBasketID(),
            "customerid":NetworkManager.getUserId(),
            "cat_id":catid,
            "sortby":SortValue,
            "brand":brand,
            "index":index,
            "searchtext":searchtext,
            "size":size,

        ]


        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "product-list", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].intValue == 200{
                let postResponse = try! JSONDecoder().decode(ProductListResponse.self, from:responseData)
                CategoryListResponseModel = postResponse
                print(" subCategory List Response:\(CategoryListResponseModel.totalrecords)")
                totalrecords = CategoryListResponseModel.totalrecords
                for customer in  CategoryListResponseModel.data {

                    let customer2 = ProductListDatum( productid: customer.productid, productname: customer.productname, imageurl: customer.imageurl, discountPercent: customer.discountPercent, qty: customer.qty, totalRating: customer.totalRating, sizeID: customer.sizeID, productMrp: customer.productMrp, productSellingprice: customer.productSellingprice, itemincart: customer.itemincart, isFav: customer.isFav, bestSeller: customer.bestSeller)
                    ProductListDatumResponse.append(customer2)

                }
                DataFound = 1
                showLoader = false
            }else{
                DataFound = 2
                showLoader = false
            }


        }

    }
    func GiveRateback(postID: Int, newRateBAck: Int) {
        if let index = ProductListDatumResponse.firstIndex(where: { $0.isFav == postID }) {
           // ProductListDatumResponse[index].isFav = newRateBAck
            //TrandingDatumResponse[index].ratebackScore  = newisLike
        }
    }
    func AddWishApi(ProductID:String){
        let parameters = [
            "product_id":ProductID,
            "customerid":NetworkManager.getUserId()
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnJson(remainingUrl: "wishlist-product", parameters: parameters) { responseData in
            print("Response : ", responseData)
           // ProductListApi(searchtext: "\(ProSearchtext)", catid: "\(TempProductId)",SortValue: "\(TempCategorysubID)", brand: "\(brandIDis)")
            ProductListDatumResponse = []
            ProductListApi(searchtext: "\(ProSearchtext)", catid: "\(TempCategorysubID)",SortValue: "\(TempProductId)", brand: "\(brandIDis)", size: "\(sizeIDis)")
    showLoader = false
        }
        
    }
}


//struct SubCategoriesUIView_Previews: PreviewProvider {
//    static var previews: some View {
//       // SubCategoriesUIView()
//       // NoDataFoundPage()
//        subCategoryPage()
//    }
//}


struct NoDataFoundPage:View{
    var body: some View{
        VStack{
            Text("No results found!")
                .font(.system(size: 16).bold())
                .foregroundColor(Color.gray)
                .padding(.top,300)
        }
    }
}
