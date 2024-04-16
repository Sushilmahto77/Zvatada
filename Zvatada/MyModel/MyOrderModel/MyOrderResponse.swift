//
//  MyOrderResponse.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myOrderResponse = try? newJSONDecoder().decode(MyOrderResponse.self, from: jsonData)

import Foundation

// MARK: - MyOrderResponse
struct MyOrderResponse: Codable {
    let status, msg: String
    let data: [DatumO]?
}

// MARK: - Datum
struct DatumO: Identifiable,Codable {
    var id = UUID()
    let orderid: String
    let productimage: String
    let productname, sellingprice, quantity, shipprice: String?
    let approveStatus, orderdate: String

    enum CodingKeys: String, CodingKey {
        case orderid, productimage, productname, sellingprice, quantity, shipprice
        case approveStatus = "approve_status"
        case orderdate
    }
}

