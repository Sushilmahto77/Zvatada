//
//  ContentView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/11/22.
//

import SwiftUI
import SwiftyJSON
struct ContentView: View {
    @State private var navSelection = 0
//    init() {
//      UITabBar.appearance().unselectedItemTintColor = UIColor.white
//    }
    var body: some View {
        ZStack{
            TabView (selection: self.$navSelection){
                HomeUIView(HomeResponseModel: HomeResponse(status: "", msg: "", sliders: [], categories: [], productSlab: []), ProductSlabModel: ProductSlab(  stripname: "", stripbanner: "", products: []), TempProductID: "", TempIdSubCat: "", searchText: "")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                            .accentColor(Color.red)
                    }.tag(0)
                CategoriesUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []))
                    .tabItem {
                        Image(systemName: "square.grid.2x2.fill")
                        Text("Categories")
                    }.tag(1)
                WhatsHotUIView(HomeResponseModel: HomeResponse(status: "", msg: "", sliders: [], categories: [], productSlab: []), TempProductID: "", TempIdSubCat: "")
                    .tabItem {
                        Image(systemName: "flame.fill")
                        Text("What’s Hot")
                    }
                AccountUIView(tempAddressId: "")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Account")
                    }.tag(2)
                CartView(CartProductListResponseModel: CartProductResponse(status: "", msg: "", subtotal: "", totalshipping: 0, grandtotal: "", data: []), AddressResponseModel: JSON(rawValue: MyAddressResponse(status: "", msg: "", data: [])) ?? [], CheckoutProductItemResponseModel: OrderReviewResponse(status: "", msg: "", walletAmountApplied: "", walletAmountRemaining: "", subtotal: "", totalshipping: "", userwalletamount: "", totalquantity: "", grandtotal: "", name: "", address: "", addresstype: "", zipcode: "", mobileno: "", buildingName: "", city: "", data: []), TempAddressId: "")
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }.tag(3)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
struct ContentCartView: View {
    @State private var navSelection = 0
    var body: some View {
        ZStack{
            TabView (selection: self.$navSelection){
                HomeUIView(HomeResponseModel: HomeResponse(status: "", msg: "", sliders: [], categories: [], productSlab: []), ProductSlabModel: ProductSlab(  stripname: "", stripbanner: "", products: []), TempProductID: "", TempIdSubCat: "", searchText: "")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }.tag(3)
                CategoriesUIView(CategoryListResponseModel: CategoryListResponse(status: "", msg: "", isSubcat: 0, data: []))
                    .tabItem {
                        Image(systemName: "square.grid.2x2.fill")
                        Text("Categories")
                    }.tag(1)
                WhatsHotUIView(HomeResponseModel: HomeResponse(status: "", msg: "", sliders: [], categories: [], productSlab: []), TempProductID: "", TempIdSubCat: "")
                    .tabItem {
                        Image(systemName: "flame.fill")
                        Text("What’s Hot")
                    }
                AccountUIView( tempAddressId: "")
                    .tabItem {
                        Image(systemName: "person.fill")
                        
                        Text("Account")
                    }.tag(2)
                CartView(CartProductListResponseModel: CartProductResponse(status: "", msg: "", subtotal: "", totalshipping: 0, grandtotal: "", data: []), AddressResponseModel: JSON(rawValue: MyAddressResponse(status: "", msg: "", data: [])) ?? [], CheckoutProductItemResponseModel: OrderReviewResponse(status: "", msg: "", walletAmountApplied: "", walletAmountRemaining: "", subtotal: "", totalshipping: "", userwalletamount: "", totalquantity: "", grandtotal: "", name: "", address: "", addresstype: "", zipcode: "", mobileno: "", buildingName: "", city: "", data: []), TempAddressId: "")
                    .tabItem {
                        Image(systemName: "cart.fill")
                           
                        Text("Cart")
                    }.tag(0)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

//struct ContentView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ContentView(CartDetails: CartDetails)
//    }
//}
