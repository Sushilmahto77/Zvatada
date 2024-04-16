//
//  ElectronicsUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 07/11/22.
//

import SwiftUI
import SwiftyJSON
struct ElectronicsUIView:View{
    @State var DataFound = 0
    @State var CategoryListResponseModel:CategoryListResponse
    @Binding var TempCategorysubListResponseModel :String
    @State var TempIdSubCat:String
    @State var searchText:String
    @State var showLoader = false

    var body: some View{
        VStack{
            if DataFound == 1{
                NoProductFound(CategoryListResponseModel: $CategoryListResponseModel, TempIdSubCat: "", SearchText: "")
            }else if DataFound == 2{
                Electronics1UIView(CategoryListResponseModel: $CategoryListResponseModel, TempIdSubCat: "", SearchText: "")
            }
            if self.showLoader{
                GeometryReader{_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                   
            }
        }.onAppear{
            SubCategoryApi(catid: "\(TempCategorysubListResponseModel)")
            showLoader = true
        }
    }
    func SubCategoryApi(catid:String){
        let parameters = [
            "cat_id":catid

        ]


        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "category-list", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(CategoryListResponse.self, from:responseData)
                CategoryListResponseModel = postResponse
                print(" subCategory List Response:\(CategoryListResponseModel)")
                showLoader = false
                DataFound = 2
            }else{
                DataFound = 1
                showLoader = false
            }
          

        }

    }
}

struct Electronics1UIView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @Binding var CategoryListResponseModel:CategoryListResponse
    @State var TempIdSubCat:String
    @State var SearchText:String
    @State var subCategoryisPresent = false
    @State var brandIDis:String = ""
    @State var sizeIDis:String = ""
    var body: some View {
      ZStack {
          Color("backColor1")
          VStack{
              ScrollView (.vertical,showsIndicators: false){
                  VStack{
                      LazyVGrid(columns: columns, spacing: 0) {
                          ForEach(CategoryListResponseModel.data ){item in
                              Button(action: {
                                  TempIdSubCat = item.catID
                                      subCategoryisPresent = true
                              }, label: {
                                  VStack {
                                      VStack(spacing: 0){
                                          AsyncImage(url: URL(string: "\(item.image)")) { image in
                                              image.resizable()
                                                  .aspectRatio(contentMode: .fit)
                                                  .frame(width: 80, height: 80)
                                                  .cornerRadius(6)
                                              
                                              
                                          } placeholder: {
                                              Image("user (1)")
                                                  .resizable()
                                                  .aspectRatio(contentMode: .fit)
                                                  .frame(width: 35, height: 35)
                                                  .cornerRadius(25)
                                                  .padding(.leading,20)
                                                  .padding(.top,10)
                                          }
                                          
                                          
                                      }.frame(width: UIScreen.main.bounds.width / 3 )
                                         // .background(Color.yellow)
                                      Text("\(item.categoryname)")
                                          .font(.system(size: 12))
                                          .foregroundColor(Color.black)
                                      Spacer()
                                  }
                              }).fullScreenCover(isPresented: $subCategoryisPresent){
                                  
                                  subCategoryPage(ProSearchtext: $SearchText, ProductTempId: "", CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCategorysubID: $TempIdSubCat, TempProductId: $TempIdSubCat, brandIDis: $brandIDis, sizeIDis: $sizeIDis)
                              }
                              //.frame(width: 250,alignment: .center)
                              
                          }
                      }
                  }
              }.frame(width: 280, alignment: .center)
                  .padding(.top,160)
              Spacer()
          }
          
     
      } .padding(.leading,100)
    

}

}

//struct ElectronicsUIView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        NoProductFound()
//    }
//}
struct NoProductFound:View{
    @Binding var CategoryListResponseModel:CategoryListResponse
    @State var TempIdSubCat:String
    @State var SearchText:String
    @State var subCategoryisPresent = false
    @State var brandIDis:String = ""
    @State var sizeIDis:String = ""
    var body: some View{
        VStack{
            Button(action: {
                subCategoryisPresent = true
            }, label: {
                VStack{
                    Text("View Products")
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color.white)
                }.frame(width: 200,height: 56,alignment: .center)
                    .background(Color("backColor"))
                    .cornerRadius(6)
                    .padding(.leading,100)
            }).fullScreenCover(isPresented: $subCategoryisPresent){
                
                subCategoryPage(ProSearchtext: $SearchText, ProductTempId: "", CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCategorysubID: $TempIdSubCat, TempProductId: $TempIdSubCat, brandIDis: $brandIDis, sizeIDis: $sizeIDis)
            }
        }
    }
}
