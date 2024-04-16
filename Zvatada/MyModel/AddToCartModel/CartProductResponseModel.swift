//
//  CartProductResponseModel.swift
//  Zvatada
//
//  Created by Sushil Mahto on 15/11/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let cartProductResponse = try? newJSONDecoder().decode(CartProductResponse.self, from: jsonData)

import Foundation

// MARK: - CartProductResponse
struct CartProductResponse: Codable {
    let status:String
    let  msg, subtotal: String
    let totalshipping: Int
    let grandtotal: String
    let data: [DatumCartProduct]
}

// MARK: - Datum
struct DatumCartProduct:Identifiable, Codable {
 
    let productid, productname: String?
    let imageurl: String?
    let discountPercent, qty, sizeID, productMrp: String?
    let productSellingprice, id: String?
    let itemincart, isFav: Int?
    

    enum CodingKeys: String, CodingKey {
        case productid, productname, imageurl
        case discountPercent = "discount_percent"
        case qty
        case sizeID = "size_id"
        case productMrp = "product_mrp"
        case productSellingprice = "product_sellingprice"
        case id, itemincart
        case isFav = "is_fav"
    }
}

