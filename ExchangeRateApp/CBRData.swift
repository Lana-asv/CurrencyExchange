//
//  CBRData.swift
//  ExchangeRateApp
//
//  Created by Sveta on 15.12.2021.
//

import Foundation

struct CBRData: Codable {
    let date, previousDate: String
    let previousURL: String
    let timestamp: String
    let valute: [String: Valute]

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousDate = "PreviousDate"
        case previousURL = "PreviousURL"
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}

struct Valute: Codable {
    let id: String
    let charCode: String
    let name: String
    let nominal: Int64
    let previous: Double
    let value: Double

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case charCode = "CharCode"
        case name = "Name"
        case nominal = "Nominal"
        case previous = "Previous"
        case value = "Value"
    }
}

extension Valute {
    init(valuteEntity: ValuteEntity) {
        self.id = valuteEntity.identifier
        self.charCode = valuteEntity.charCode
        self.name = valuteEntity.name
        self.nominal = valuteEntity.nominal
        self.previous = valuteEntity.previous
        self.value = valuteEntity.value
    }
}


