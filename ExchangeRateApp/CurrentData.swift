//
//  CurrentData.swift
//  ExchangeRateApp
//
//  Created by Sveta on 13.12.2021.
//

import Foundation

//let api_key = d12509d883a51cdead2d47deb84c6d0c
//https://api.currencyfreaks.com/latest?apikey=e888a42bc2ca46f386c8c67dbd4c69f0=PKR,GBP,EUR,INR&base=RUB
//https://api.currencyfreaks.com/latest?apikey=e888a42bc2ca46f386c8c67dbd4c69f0&base=RUB


struct CurrentData: Codable {
    let meta: Meta
    let response: Response
}

struct Meta: Codable {
    let code: Int
    let disclaimer: String
}

struct Response: Codable {
    let date: String
    let base: String
    let rates: [String: Double]
}
