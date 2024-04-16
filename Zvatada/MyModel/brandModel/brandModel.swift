//
//  brandModel.swift
//  Zvatada
//
//  Created by Sushil Mahto on 03/04/24.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let brandModel = try? JSONDecoder().decode(BrandModel.self, from: jsonData)

import Foundation

// MARK: - BrandModel
struct BrandModel: Codable {
    let status, msg: String
    let data: [brandDatum]
}

// MARK: - Datum
struct brandDatum: Identifiable,Codable ,Hashable{
    let id, name: String
    let image: String
}

