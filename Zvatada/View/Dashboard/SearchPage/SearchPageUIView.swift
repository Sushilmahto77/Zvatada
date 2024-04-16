//
//  SearchPageUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 05/11/22.
//

import SwiftUI
import SwiftyJSON
struct SearchPageUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @State  var ProSearchtext: String = ""
    @State private var searchText = ""
    @State var CategoryPagePresent = false
    @State var CategoryListResponseModel:ProductListResponse
    @State var TempCatId :String
    @State var brandIDis = ""
    @State var sizeIDis:String = ""
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
                                    .foregroundColor(Color.black)
                                    .padding(.top,48)
                                //.padding(.leading,20)
                            }
                            .padding(.leading,24)
                           // ForEach(CategoryListResponseModel.data){item in
//                            ForEach(CategoryListResponseModel.data.filter({ searchText.isEmpty ? true : $0.productname.contains(searchText) })) { item in
//
//                            }
                            HStack{
                                TextField("Search for what you are looking for", text: $ProSearchtext)
                                    .onSubmit {
                                        CategoryPagePresent = true
                                      
                                        if LocalStorage.myValue == ""{
                                            LocalStorage.myValue = self.ProSearchtext
                                        }else {
                                            let savedStr = LocalStorage.myValue
                                            let newStr = "\(LocalStorage.myValue)#\(self.ProSearchtext)"
                                            LocalStorage.myValue = newStr
                                            
                                        }
                                       print("\(ProSearchtext)")
                                    }
                                    .submitLabel(.search)
                                    .padding(7)
                                    .padding(.horizontal, 10)
                                    .font(.system(size: 15))
                                    .frame( height: 45)
                                    .background(Color("backColor1"))
                                    .cornerRadius(6)
                                    .fullScreenCover(isPresented: $CategoryPagePresent,onDismiss: {
                                        presentationMode.wrappedValue.dismiss()
                                    }){
                                        subCategoryPage(ProSearchtext: $ProSearchtext, PsearchText: "", ProductTempId: "", CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []),TempCategorysubID: $TempCatId, TempProductId: $TempCatId, brandIDis: $brandIDis, sizeIDis: $sizeIDis)
                                    }
                            }.shadow(color: .black, radius:1, x:0.1,y: 0.1)
                            // LSearchBar(text: $searchText)
                                .padding(.top,48)
                            
                            
                            Spacer()
                           /* Button(action: {
                                
                                CategoryPagePresent = true
                                //ProductListApi( Searchtext: "\(searchText)")
                            }, label: {
                                VStack{
                                    Button(action: {
                                        CategoryPagePresent = true
                                      
                                        if LocalStorage.myValue == ""{
                                            LocalStorage.myValue = self.ProSearchtext
                                        }else {
                                            let savedStr = LocalStorage.myValue
                                            let newStr = "\(LocalStorage.myValue)#\(self.ProSearchtext)"
                                            LocalStorage.myValue = newStr
                                            
                                        }
                                    }, label: {
                                        Image(systemName: "magnifyingglass")
                                            .font(.system(size: 25))
                                            .frame(width: 48,height: 48)
                                            .background(Color("backColor"))
                                            .cornerRadius(6)
                                            .foregroundColor(Color.white)
                                            .padding(.trailing,20)
                                            .padding(.top,48)
                                    }).fullScreenCover(isPresented: $CategoryPagePresent,onDismiss: {
                                        presentationMode.wrappedValue.dismiss()
                                    }){
                                        subCategoryPage(ProSearchtext: $ProSearchtext, PsearchText: "", ProductTempId: "", CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []),TempCategorysubID: $TempCatId, TempProductId: $TempCatId)
                                    }
                                    
                                }
                                
                            }).fullScreenCover(isPresented: $CategoryPagePresent){
                                ContentView()
                            }*/
                       // }
                        }
                        
                        
                    }
                }.frame(width: UIScreen.main.bounds.width,height: 120)
                   // .background(Color("backColor"))
                    
                VStack(alignment: .leading){
                    HStack{
                        Text("Recent Searches")
                            .font(.system(size: 16).bold())
                            .foregroundColor(Color.black.opacity(0.6))
                            .padding(.leading,20)
                        Spacer()
                        Button(action: {
                            LocalStorage.removeValue()
                            
                        }, label: {
                           Image(systemName: "trash")
                                .font(.system(size: 20))
                                .padding(.trailing,20)
                                .foregroundColor(Color.black.opacity(0.6))
                        }).fullScreenCover(isPresented: $CategoryPagePresent,onDismiss: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            subCategoryPage(ProSearchtext: $ProSearchtext, PsearchText: "", ProductTempId: "", CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []),TempCategorysubID: $TempCatId, TempProductId: $TempCatId, brandIDis: $brandIDis, sizeIDis: $sizeIDis)
                        }
                    }
                    if LocalStorage.myValue.isEmpty {
                        
                    }else {
                        let savedStr = LocalStorage.myValue
                        let strAr = savedStr.split(separator: "#")
                        ForEach(strAr ,id: \.self){ str in
                            Button(action: {
                                ProSearchtext = "\(str)"
                                CategoryPagePresent = true
                            }, label: {
                                
                                Text(str)
                                    .font(.system(size: 14))
                                    .padding(.all,5)
                                    .padding(.leading,6)
                                    .padding(.trailing,6)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(6)
                                    .padding(.leading,20)
                                    .padding(.top,12)
                                    .foregroundColor(Color.black)
                            })
                        }
                        
                       
                    }
                }
                   
                
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear{
               
            }
    }
    
   
}
struct strArray: Identifiable,Codable {
    let id: String
    
}
//struct SearchPageUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchPageUIView(CategoryListResponseModel: ProductListResponse(status: "", msg: "", categoryname: "", sellername: "", bannerurl: "", totalrecords: 0, data: []), TempCatId: "")
//    }
//}
struct LSearchBar: View {
    @Binding var text: String
    
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            
            TextField("Search for what you are looking for", text: $text)
                .padding(7)
                //.padding(.horizontal, 25)
                .font(.system(size: 15))
                .frame( height: 45)
                .background(Color("backColor1"))
                
                .cornerRadius(8)
                .cornerRadius(8)
//                .overlay(
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                            .padding(.leading, 8)
//
//                        if isEditing {
//                            Button(action: {
//                                self.text = ""
//
//                            }) {
//                                Image(systemName: "multiply.circle.fill")
//                                    .foregroundColor(.gray)
//                                    .padding(.trailing, 8)
//                            }
//                        }
//                    }
//                )
                //.padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                   // Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }.padding(.top,9)
            .padding(.bottom,9)
    }
}
