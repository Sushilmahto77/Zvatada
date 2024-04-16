//
//  sizelistModel.swift
//  Zvatada
//
//  Created by Sushil Mahto on 04/04/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sizelistModel = try? JSONDecoder().decode(SizelistModel.self, from: jsonData)

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let sizelistModel = try? JSONDecoder().decode(SizelistModel.self, from: jsonData)

import Foundation

// MARK: - SizelistModel
struct SizelistModel: Codable {
    let status, msg: String
    let data: [SizelistDatum]
}

// MARK: - Datum
struct SizelistDatum: Identifiable,Codable {
    let id, size: String
}
