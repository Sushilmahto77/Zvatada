//
//  AddToCartResponse.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addToCartResponse = try? newJSONDecoder().decode(AddToCartResponse.self, from: jsonData)

import Foundation

// MARK: - AddToCartResponse
struct AddToCartResponse: Identifiable,Codable {
    var id = UUID()
    let status: Int?
    let message: String?
    let basketid, totalCartQty: Int?

    enum CodingKeys: String, CodingKey {
        case status, message, basketid
        case totalCartQty = "total_cart_qty"
    }
}

