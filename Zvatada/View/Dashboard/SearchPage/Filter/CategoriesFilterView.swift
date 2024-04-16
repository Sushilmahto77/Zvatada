//
//  CategoriesFilterView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 23/11/22.
//

import SwiftUI
import SwiftyJSON
struct CategoriesFilterView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
   // @Binding var CategoryList1ResponseModel:ProductListResponse
    @State var CategoryListResponseModel:CategoryListResponse
    @Binding var tempCatFilterId :String
    @Binding var catProductID : String
    @State var categoriesPresent = false
    @State var isChecked:Bool = false
    @State var num:String = ""
    @State var searchText:String
    @State var showLoader = false
    @Binding var brandIDis:String
    @Binding var sizeIDis:String
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                HStack {
                    Text("Categories")
                        .font(.system(size: 16).bold())
                       
                        .padding(.leading,20)
                    .padding(.top,25)
                    Spacer()
                    Button(action: {
                       dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16))
                            .foregroundColor(Color.red)
                            .padding(.trailing,20)
                            .padding(.top,25)
                    })
                    
                } //.frame(width: UIScreen.main.bounds.width,height: 24,alignment: .leading)
                Rectangle().frame(width: UIScreen.main.bounds.width,height: 1)
                    .foregroundColor(Color.gray.opacity(0.6))
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(CategoryListResponseModel.data){item in
                        //VStack{
                        Button(action: {
                            catProductID = item.catID
                            num = item.categoryname
                            print("name is:\(num)")
                           isChecked = false
                        }, label: {
                            HStack{
                                if num != item.categoryname{
                                    Image(systemName: isChecked ? "square": "square")
                                         .font(.system(size: 20))
                                         .padding(.leading,9)
                                }else if num == item.categoryname {
                                    Image(systemName: isChecked ? "checkmark.square": "square")
                                         .font(.system(size: 20))
                                         .padding(.leading,9)
                                }else {
                                    Image(systemName: isChecked ? "square": "checkmark.square")
                                         .font(.system(size: 20))
                                         .padding(.leading,9)
                                }
                              
                                Text("\(item.categoryname)")
                                    .font(.system(size: 14).bold())
                                Spacer()
                            }.frame(width: UIScreen.main.bounds.width / 2 - 10, alignment: .center)
                                //.background(.white)
                                .padding(.top,8)
                                .foregroundColor(Color.black)
                                .onTapGesture {
                                    catProductID = item.catID
                                    num = item.categoryname
                                    isChecked = true
                                }
                        })
                           
                            
                        //}.frame(width: UIScreen.main.bounds.width / 2 - 10, alignment: .center)
                    }
                }
                HStack{
                    Button(action: {}, label: {
                        Text("Clear Filter")
                            .font(.system(size: 14).bold())
                            .frame(width: UIScreen.main.bounds.width / 2 - 10, height: 48,alignment: .center)
                            .background(Color.red)
                            .cornerRadius(6)
                            .foregroundColor(Color.white)
                    })
                   Button(action: {
                       categoriesPresent = true
                       //presentationMode.wrappedValue.dismiss()
                   }, label: {
                       Text("Apply Filter")
                           .font(.system(size: 14).bold())
                           .frame(width: UIScreen.main.bounds.width / 2 - 10, height: 48,alignment: .center)
                           .background(Color("backColor"))
                           .cornerRadius(6)
                           .foregroundColor(Color.white)
                   }).fullScreenCover(isPresented: $categoriesPresent,onDismiss: {
                       dismiss()
                   }){
                       
                       subCategoryPage(ProSearchtext: $searchText, ProductTempId: "", CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCategorysubID: $catProductID, TempProductId: $tempCatFilterId, brandIDis: $brandIDis, sizeIDis: $sizeIDis)

                   }
                   
                }.padding(.top,20)
                Spacer()
            }
            if self.showLoader{
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                   
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                ProductListApi(catid: tempCatFilterId)
                showLoader = true
            }
    }
    func ProductListApi(catid:String){
        let parameters = [
          
            "cat_id":catid,
           

        ]
        NetworkManager.postRequestWithUserTokenFixUrlRetunData(remainingUrl: "category-list", parameters: parameters, Token: "\(NetworkManager.getGeneralToken())") { responseData in

            let swiftyJsonVar = try! JSON(data: responseData)
            //  errorMessage =  swiftyJsonVar["message"].stringValue
             showLoader = false
            if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(CategoryListResponse.self, from:responseData)
                CategoryListResponseModel = postResponse
                print(" subCategory List Response:\(CategoryListResponseModel)")
                isChecked = false
                showLoader = false
            }
        }

//        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "category-list", parameters: parameters) { responseData in
//            print("Response : ", responseData)
//            let postResponse = try! JSONDecoder().decode(CategoryListResponse.self, from:responseData)
//            CategoryListResponseModel = postResponse
//            print(" subCategory List Response:\(CategoryListResponseModel)")
//            isChecked = false
//            showLoader = false
// 
//
//        }

    }
}

//struct CategoriesFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesFilterView(CategoryList1ResponseModel: <#Binding<ProductListResponse>#>)
//    }
//}
