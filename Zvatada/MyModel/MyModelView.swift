//
//  MyModelView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 05/11/22.
//

import Foundation
import WebKit
import SwiftUI
struct Popular: Identifiable , Hashable{
    var id = UUID()
    var name: String
    var image: String
    var rs:Int
    var rating:String
    var brand:String
    
    
   

   
    }
var product1 = [
    Popular(name: "Ustraa | Fragrance Bundle - Ammunition & Base", image: "per6", rs: 15, rating: "4.5",brand: "U.S POLO ASSN"),
    Popular(name: "Boy's Ustraa | Fragrance Bundle - Ammunition & Base", image: "per7", rs: 15, rating: "4.5",brand: "U.S POLO ASSN"),
    Popular(name: "Ustraa | Fragrance Bundle - Ammunition & Base", image: "p15", rs: 15, rating: "4.5",brand: "U.S POLO ASSN"),
    Popular(name: "Boy's Ustraa | Fragrance Bundle - Ammunition & Base", image: "per9", rs: 15, rating: "4.5",brand: "U.S POLO ASSN"),
    Popular(name: "Ustraa | Fragrance Bundle - Ammunition & Base", image: "per10", rs: 15, rating: "4.5",brand: "U.S POLO ASSN"),
    Popular(name: "Man's Ustraa | Fragrance Bundle - Ammunition & Base", image: "per11", rs: 15, rating: "4.5",brand: "U.S POLO ASSN"),
    ]
struct CategoryList: Identifiable {
    var id = UUID()
    var name: String
    var image: String
 
    }
var productCategory = [
    CategoryList(name: "Electronics", image: "C1"),
    CategoryList(name: "Home & Garden", image: "C2"),
    CategoryList(name: "Fashion", image: "C3"),
    CategoryList(name: "Gaming", image: "C4"),
    CategoryList(name: "Beauty", image: "C5"),
    CategoryList(name: "Miscellaneous", image: "C6"),
 
    ]
struct BestSale: Identifiable , Hashable{
    var id = UUID()
    var name: String
    var image: String
    var rs:Int
    var rating:String
    var brand:String
    
    }
var productList = [
    BestSale(name: "Yoga mat", image: "BS1", rs: Int(10.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSale(name: "13000 mAh PowerCore Power Bank Black", image: "BS2", rs: Int(45.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSale(name: "BLACK + DECKER Humidifier with remote control", image: "BS3", rs: Int(100.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSale(name: "Sony Playstation 5 Console (Disc Version) with controller", image: "BS5", rs: Int(1000.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSale(name: "Xbox Series X 1TB Console (Disc Version) with Controller", image: "BS6", rs: Int(807.50), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSale(name: "24-Piece Stainless Steel Cutlery Set Golden", image: "BS7", rs: Int(25.00), rating: "4.5",brand: "U.S POLO ASSN"),
    ]

struct BestSaleP: Identifiable , Hashable{
    var id = UUID()
    var name: String
    var image: String
    var rs:Int
    var rating:String
    var brand:String
    
    }
var productListG = [
    BestSaleP(name: "BLACK + DECKER Humidifier with remote control", image: "GD1", rs: Int(100.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSaleP(name: "Samsung Galaxy Tab A8 10.5-Inch Grey 3GB RAM 32GB Wifi - International Version", image: "GD2", rs: Int(250.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSaleP(name: "Apple Watch Series 7 GPS 45mm Aluminium Case With Sport Band Midnight", image: "GD3", rs: Int(480.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSaleP(name: "Samsung Galaxy Watch 4 44 mm Black", image: "GD4", rs: Int(1000.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSaleP(name: "Samsung 65-Inch Curved 4K Crystal UHD HDR Smart TV (2020) And Smart Remote Control 65TU8300 Black", image: "GD5", rs: Int(800.00), rating: "4.5",brand: "U.S POLO ASSN"),
    BestSaleP(name: "24-Piece Stainless Steel Cutlery Set Golden", image: "BS7", rs: Int(25.00), rating: "4.5",brand: "U.S POLO ASSN"),
    ]



struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
struct SortList: Identifiable,Hashable {
    let id = UUID()
    let name: String
    let value:String
}
var SortLists = [
    SortList(name: "A to Z",value:"name"),
    SortList(name: "New Arrivals", value: "new"),
    SortList(name: "Price: Low to High", value: "priceasc"),
    SortList(name: "Price: High to Low", value: "pricedesc"),
    
]
