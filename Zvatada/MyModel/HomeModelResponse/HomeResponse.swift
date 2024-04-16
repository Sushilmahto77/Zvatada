// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeResponse = try? newJSONDecoder().decode(HomeResponse.self, from: jsonData)

import Foundation

// MARK: - HomeResponse
struct HomeResponse: Codable {
    let status, msg: String?
    let sliders: [Slider]?
    let categories: [Category]?
    let productSlab: [ProductSlab]?

    enum CodingKeys: String, CodingKey {
        case status, msg, categories
        case productSlab = "product_slab"
        case sliders
    }
}

// MARK: - Category
struct Category: Identifiable,Codable {
    var id = UUID().self
    let catID: String?
    let isSubCategory: Int?
    let categoryname: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case catID = "cat_id"
        case isSubCategory = "is_sub_category"
        case categoryname, image
    }
}

// MARK: - ProductSlab
struct ProductSlab: Identifiable,Codable {
   // let id : Int?
    let id=UUID()
    let stripname: String?
    let stripbanner: String?
    let products: [Product]?
}

// MARK: - Product
struct Product: Identifiable,Codable {
    let id=UUID()
    let productid, productname: String?
    let imageurl: String?
    let discountPercent: String?
    let qty: Qty
    let totalRating:Int?
    let sizeID, productMrp, productSellingprice: String?
    let  isFav: Int?
    let bestSeller: String?
    let itemincart:Int?

    enum CodingKeys: String, CodingKey {
        case productid, productname, imageurl
        case discountPercent = "discount_percent"
        case qty
        case totalRating = "total_rating"
        case sizeID = "size_id"
        case productMrp = "product_mrp"
        case productSellingprice = "product_sellingprice"
        case itemincart
        case isFav = "is_fav"
        case bestSeller = "best_seller"
    }
}

enum Qty: String, Codable {
    case inStoc = "in stoc"
    case limitatStoc = "limitat stoc"
    case stocEpuizat = "stoc epuizat"
}

// MARK: - Slider
struct Slider: Identifiable,Codable,Hashable {
    let id :Int?
    let url: String?
}

