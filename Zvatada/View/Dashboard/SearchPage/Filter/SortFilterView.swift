//
//  SortFilterView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 23/11/22.
//

import SwiftUI

struct SortFilterView: View {
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
                    ForEach(SortLists, id: \.self){item in
                        //VStack{
                        Button(action: {
                            sortValue = item.value
                            num = item.name
                            print("name is:\(num)")
                           isChecked = false
                        }, label: {
                            HStack{
                                if num != item.name{
                                    Image(systemName: isChecked ? "square": "square")
                                         .font(.system(size: 20))
                                         .padding(.leading,9)
                                }else if num == item.name {
                                    Image(systemName: isChecked ? "checkmark.square": "square")
                                         .font(.system(size: 20))
                                         .padding(.leading,9)
                                }else {
                                    Image(systemName: isChecked ? "square": "checkmark.square")
                                         .font(.system(size: 20))
                                         .padding(.leading,9)
                                }
                              
                                Text("\(item.name)")
                                    .font(.system(size: 14).bold())
                                Spacer()
                            }.frame(width: UIScreen.main.bounds.width / 2 - 10, alignment: .center)
                                //.background(.white)
                                .padding(.top,8)
                                .foregroundColor(Color.black)
                                .onTapGesture {
                                    sortValue = item.value
                                    num = item.name
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
    }
}

//struct SortFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortFilterView( searchText: "")
//    }
//}
