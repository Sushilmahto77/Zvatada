//
//  CategoriesUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
let w11 = UIScreen.main.bounds.width
struct CategoriesUIView: View {
    @State var CategoryListResponseModel:CategoryListResponse
    @State var TempCategorysubListResponseModel = "0047"
    @State var menu = false
    @State var num = "Electronics"
    @State var TempIdSubCat:String = ""
    @State var SearchisPresent = false
    @State var SignUpisPresented = false
    var body: some View {
        ZStack{
            Color("backColor1")
           // Color(.red)
            if(num == "Electronics"){
                ElectronicsUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), TempCategorysubListResponseModel: $TempCategorysubListResponseModel, TempIdSubCat: TempIdSubCat, searchText: "")
            } else if(num == "Home & Garden"){
                ElectronicsUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), TempCategorysubListResponseModel: $TempCategorysubListResponseModel, TempIdSubCat: TempIdSubCat, searchText: "")
            }else if(num == "Fashion"){
                ElectronicsUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), TempCategorysubListResponseModel: $TempCategorysubListResponseModel, TempIdSubCat: TempIdSubCat, searchText: "")
           } else if(num == "Gaming"){
               ElectronicsUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), TempCategorysubListResponseModel: $TempCategorysubListResponseModel, TempIdSubCat: TempIdSubCat, searchText: "")
           } else if(num == "Beauty"){
               ElectronicsUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), TempCategorysubListResponseModel: $TempCategorysubListResponseModel, TempIdSubCat: TempIdSubCat, searchText: "")
           } else if(num == "Miscellaneous "){
               ElectronicsUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), TempCategorysubListResponseModel: $TempCategorysubListResponseModel, TempIdSubCat: TempIdSubCat, searchText: "")
           }
          
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
                        SearchPageUIView(CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCatId: "")
                    }
                   
                }
               
                   
                SideCategoryMenu(menu: $menu, CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), num: $num, TempCategorysubListResponseModel: $TempCategorysubListResponseModel)
              
                
                Spacer()
            }
            
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
               
            }
    }
    
    
}

//struct CategoriesUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []), tempCategoryList: ""))
//    }
//}

struct SideCategoryMenu:View {
    @State var c1 = [Color.blue, Color.white, Color.white,Color.white,Color.white,Color.white]
    @Binding var menu:Bool
    @State var CategoryListResponseModel : CategoryListResponse
    @Binding var num:String
    @Binding var TempCategorysubListResponseModel :String
    @State var DataFound = 0
    @State var showLoader = false
    var body: some View{
        
        HStack {
            ZStack(alignment: .leading){
               //Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 0.03561775258)).edgesIgnoringSafeArea(.all)
                Color("backColor2")
                VStack {
                    VStack{
                        
                       
                        ForEach(CategoryListResponseModel.data){ item in
                            VStack{
                                Button(action: {
                                    TempCategorysubListResponseModel = item.catID
                                    num = item.categoryname
                                    
                                    print("name is:\(num)")
                                                     }, label: {
                                    HStack{
                                       
                                        Text("\(item.categoryname)")
                                            .font(.system(size:10).bold())
                                            .foregroundColor(Color.black)
                                            .padding(.all,9)
                                        Spacer()
                                    }.frame(height: 66)
                                    .background(num == item.categoryname ? .white:Color("backColor2"))
                                    .onTapGesture {
                                        TempCategorysubListResponseModel = item.catID
                                        num = item.categoryname
                                        print("name is :\(TempCategorysubListResponseModel)")
                                        menu.toggle()
                                        c1 = [Color.blue, Color.white, Color.white, Color.white, Color.white,Color.white]
                                    }
                                })
                               
                            }
                        }
               
                        Spacer()
                        
                    }.frame(width: w11/3.9,height: 380, alignment: .center)
                       // .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)))
                        .background(Color("backColor2"))
                        .padding(.top,28)
                    Spacer()
                }
                    //.padding(.bottom,150)
               
              
            }.frame(width: w11/3.9,height: 380, alignment: .leading)
                .padding(.top,20)
            .onAppear{
                CategoryApi(catid: "0")
               // showLoader = true
        }
            Spacer()
        }
    }
    func CategoryApi(catid:String){
        let parameters = [
            "cat_id":catid
           
        ]
        
        
        NetworkManager.postRequestWithUtiityTokenReturnData(remainingUrl: "category-list", parameters: parameters) { responseData in
            print("Response : ", responseData)
            let swiftyJsonVar = try! JSON(data: responseData)
            if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(CategoryListResponse.self, from:responseData)
                CategoryListResponseModel = postResponse
                print(" Category List Response:\(CategoryListResponseModel)")
                showLoader = false
            }else{
                
            }
           
           
            
        }
       
       
        
    }
}
