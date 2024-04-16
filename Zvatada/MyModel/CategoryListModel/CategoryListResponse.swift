//
//  CategoryListResponse.swift
//  Zvatada
//
//  Created by Sushil Mahto on 11/11/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoryListResponse = try? newJSONDecoder().decode(CategoryListResponse.self, from: jsonData)

import Foundation

// MARK: - CategoryListResponse
struct CategoryListResponse: Codable {
    let status, msg: String?
    let isSubcat: Int
    let data: [DatumC]

    enum CodingKeys: String, CodingKey {
        case status, msg
        case isSubcat = "is_subcat"
        case data
    }
}

// MARK: - Datum
struct DatumC: Identifiable,Codable {
    var id = UUID()
    let catID: String
    let isSubCategory: Int
    let categoryname: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case catID = "cat_id"
        case isSubCategory = "is_sub_category"
        case categoryname, image
    }
}

