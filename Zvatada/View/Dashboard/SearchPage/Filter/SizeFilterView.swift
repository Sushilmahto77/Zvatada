//
//  SizeFilterView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 23/11/22.
//

import SwiftUI
import SwiftyJSON
struct SizeFilterView: View {
    @State var SizelistResponseModel:SizelistModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @Environment(\.dismiss) var dismiss
    @Binding var catID :String
    @Binding var sortValue : String
    @State var categoriesPresent = false
    @State var isChecked:Bool = false
    @State var num:String = ""
    @State var searchText:String
  
    @State private var selectedItems: Set<String> = []
    @Binding var brandIDis:String
    var selectedItemsString: String {
            // Convert the set to an array and join its elements with a separator
            return selectedItems.sorted().joined(separator: ", ")
        }
    @Binding var sizeIDis:String
    var body: some View {
        ZStack{
            Color("backColor1")
            VStack{
                HStack {
                    Text("Brand")
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
                    ForEach(SizelistResponseModel.data){item in
                        //VStack{
                        Button(action: {
                           // sortValue = item.value
//                            num = item.name
//                            print("name is:\(num)")
//                           isChecked = false
                            if selectedItems.contains(item.id) {
                                                   selectedItems.remove(item.id)
                                               } else {
                                                   selectedItems.insert(item.id)
                                               }
                        }, label: {
                            HStack{
                                Image(systemName: selectedItems.contains(item.id) ? "checkmark.square" : "square")
                                    .font(.system(size: 20))
                                    .padding(.leading,9)

                                Text("\(item.size)")
                                    .font(.system(size: 14).bold())

                                Spacer()
                            }.frame(width: UIScreen.main.bounds.width / 2 - 10, alignment: .center)
                                .padding(.top,8)
                                .foregroundColor(Color.black)
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
                       sizeIDis = selectedItemsString
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
                       subCategoryPage(ProSearchtext: $searchText, ProductTempId: "", CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []) ,TempCategorysubID:$catID, TempProductId: $sortValue, brandIDis: $brandIDis, sizeIDis: $sizeIDis)
                   }

                }.padding(.top,20)
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
                sizeListApi(catid: "\(catID)")
            }
    }
    func sizeListApi(catid:String){
        let parameters = [

            "cat_id":catid,


        ]
        NetworkManager.postRequestWithUserTokenFixUrlRetunData(remainingUrl: "size-list", parameters: parameters, Token: "\(NetworkManager.getGeneralToken())") { responseData in

            let swiftyJsonVar = try! JSON(data: responseData)
            //  errorMessage =  swiftyJsonVar["message"].stringValue
            //  showLoader = false
            if swiftyJsonVar["status"].stringValue == "200"{
                let postResponse = try! JSONDecoder().decode(SizelistModel.self, from:responseData)
                SizelistResponseModel = postResponse
                print(" subCategory List Response:\(SizelistResponseModel)")
            }
        }

    }
}

struct SizeFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SizeFilterView(SizelistResponseModel: SizelistModel(status: "", msg: "", data: []), catID: .constant(""), sortValue: .constant(""), searchText: "", brandIDis: .constant(""), sizeIDis: .constant(""))
    }
}
