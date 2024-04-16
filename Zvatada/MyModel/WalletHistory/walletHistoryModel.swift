//
//  walletHistoryModel.swift
//  Zvatada
//
//  Created by Sushil Mahto on 30/08/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let walletHistoryModel = try? JSONDecoder().decode(WalletHistoryModel.self, from: jsonData)

import Foundation

// MARK: - WalletHistoryModel
struct WalletHistoryModel: Codable {
    let status, msg, walletAmount: String?
    let data: [WalletHistoryDatum]

    enum CodingKeys: String, CodingKey {
        case status, msg
        case walletAmount = "wallet_amount"
        case data
    }
}

// MARK: - Datum
struct WalletHistoryDatum: Identifiable,Codable {
    var id=UUID()
    let orderID: String?
    let debit, credit, remarks, adddate: String

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case debit, credit, remarks, adddate
    }
}

// MARK: - Encode/decode helpers



