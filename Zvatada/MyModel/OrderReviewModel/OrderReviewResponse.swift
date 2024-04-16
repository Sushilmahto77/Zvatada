//
//  OrderReviewResponse.swift
//  Zvatada
//
//  Created by Sushil Mahto on 18/11/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let orderReviewResponse = try? newJSONDecoder().decode(OrderReviewResponse.self, from: jsonData)

import Foundation

// MARK: - OrderReviewResponse
struct OrderReviewResponse: Codable {
    let status, msg, walletAmountApplied, walletAmountRemaining: String?
    let subtotal, totalshipping, userwalletamount, totalquantity: String?
    let grandtotal, name, address, addresstype: String?
    let zipcode, mobileno, buildingName, city: String?
    let data: [DatumOder]?

    enum CodingKeys: String, CodingKey {
        case status, msg
        case walletAmountApplied = "wallet_amount_applied"
        case walletAmountRemaining = "wallet_amount_remaining"
        case subtotal, totalshipping, userwalletamount, totalquantity, grandtotal, name, address, addresstype, zipcode, mobileno
        case buildingName = "building_name"
        case city, data
    }
}

// MARK: - Datum
struct DatumOder: Identifiable,Codable {
   // var id = UUID()
    let productid, productname: String
    let imageurl: String
    let discountPercent, qty, sizeID, productMrp: String?
    let productSellingprice, id: String?

    enum CodingKeys: String, CodingKey {
        case productid, productname, imageurl
        case discountPercent = "discount_percent"
        case qty
        case sizeID = "size_id"
        case productMrp = "product_mrp"
        case productSellingprice = "product_sellingprice"
        case id
    }
}

