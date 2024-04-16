//
//  MyAddressResponse.swift
//  Zvatada
//
//  Created by Sushil Mahto on 12/11/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myAddressResponse = try? newJSONDecoder().decode(MyAddressResponse.self, from: jsonData)

import Foundation

// MARK: - MyAddressResponse
struct MyAddressResponse: Codable {
    let status, msg: String
    let data: [DatumAddress]
}

// MARK: - Datum
struct DatumAddress: Identifiable,Codable {
    let id: String
    let addresstype: String?
    let defaultAddress, name, address: String?
    let buildingName: String?
    let mobileno, zipcode, city: String?

    enum CodingKeys: String, CodingKey {
        case id, addresstype
        case defaultAddress = "default_address"
        case name, address
        case buildingName = "building_name"
        case mobileno, zipcode, city
    }
}

