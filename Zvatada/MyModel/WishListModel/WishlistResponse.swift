//
//  WishlistResponse.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let wishListResponse = try? newJSONDecoder().decode(WishListResponse.self, from: jsonData)

import Foundation

// MARK: - WishListResponse
struct WishListResponse: Codable {
    let status, msg: String
    let totalWishlist: Int
    let data: [DatumW]?

    enum CodingKeys: String, CodingKey {
        case status, msg
        case totalWishlist = "total_wishlist"
        case data
    }
}

// MARK: - Datum
struct DatumW: Identifiable,Codable ,Hashable{
    var id = UUID()
    let productid, productname: String
    let imageurl: String
    let discountPercent, qty: String
    let totalRating: Int?
    let sizeID, productMrp, productSellingprice: String
    let itemincart, isFav: Int
    let bestSeller: String

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

