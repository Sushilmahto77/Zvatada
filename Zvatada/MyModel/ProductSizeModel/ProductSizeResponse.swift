//
//  ProductSizeResponse.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productSizeResponse = try? newJSONDecoder().decode(ProductSizeResponse.self, from: jsonData)

import Foundation

// MARK: - ProductSizeResponse
struct ProductSizeResponse: Codable {
    let status, msg: String
    let data: [DatumP]
}

// MARK: - Datum
struct DatumP: Codable {
    let productMrp, productSellingprice, discountPercent, productSize: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case productMrp = "product_mrp"
        case productSellingprice = "product_sellingprice"
        case discountPercent = "discount_percent"
        case productSize = "product_size"
        case id
    }
}

