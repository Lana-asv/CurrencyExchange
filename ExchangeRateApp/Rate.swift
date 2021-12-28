//
//  Rate.swift
//  ExchangeRateApp
//
//  Created by Sveta on 13.12.2021.
//

struct Rate {
    var rate: [String: Double] = [:]
    
    init?(data: Response) {
        rate = data.rates
    }
}


