//
//  SecondScreenModel.swift
//  ExchangeRateApp
//
//  Created by Sveta on 22.12.2021.
//

import Foundation

struct ConverterCellModel {
    let currency: Valute
    let amount: Decimal
}

protocol ISecondScreenModel {
    func itemsCount() -> Int
    func itemAtIndex(_ index: Int) -> ConverterCellModel
    func convert(from: Valute, number: Decimal, to: Valute) -> Decimal
    func updateAmount(_ amount: Decimal)
    func addNewValute(_ valute: Valute)
    func updateValute(_ valute: Valute, at index: Int)
    func removeValute(_ index: Int)
}

final class SecondScreenModel: ISecondScreenModel {
    
    private var currencyData: [ConverterCellModel] = []

    init() {
        let currencyFrom = Valute(id: "R01239", charCode: "EUR", name: "Евро", nominal: 1, previous: 83.1541, value: 83.1223)
        let currencyTo = Valute(id: "R01235", charCode: "USD", name: "Доллар США", nominal: 1, previous: 73.7901, value: 73.3583)
        self.currencyData.append(ConverterCellModel(currency: currencyFrom, amount: 0))
        self.currencyData.append(ConverterCellModel(currency: currencyTo, amount: 0))
    }
    
    func itemsCount() -> Int {
        return currencyData.count
    }
    
    func itemAtIndex(_ index: Int) -> ConverterCellModel {
        return self.currencyData[index]
    }
    
    func convert(from: Valute, number: Decimal, to: Valute) -> Decimal {
        let firstRate = Decimal(from.value)/Decimal(from.nominal)
        let secondRate = Decimal(to.value)/Decimal(to.nominal)
        let amount = firstRate/secondRate
        return amount * number
    }
    
    func updateAmount(_ amount: Decimal) {
        let model = currencyData[0]
        currencyData[0] = ConverterCellModel(currency: model.currency, amount: amount)
    
        for index in 1..<currencyData.count {
            let toModel = currencyData[index]
            let convertedAmount = convert(from: model.currency, number: amount, to: toModel.currency)
            currencyData[index] = ConverterCellModel(currency: toModel.currency, amount: convertedAmount)
        }
    }
    
    func addNewValute(_ valute: Valute) {
        let model = currencyData[0]
        let convertedAmount = convert(from: model.currency, number: model.amount, to: valute)
        let toModel = ConverterCellModel(currency: valute, amount: convertedAmount)
        self.currencyData.append(toModel)
    }
    
    func updateValute(_ valute: Valute, at index: Int) {
        guard index < currencyData.count else {
            return
        }

        let model = currencyData[0]
        let convertedAmount = convert(from: model.currency, number: model.amount, to: valute)
        currencyData[index] = ConverterCellModel(currency: valute, amount: convertedAmount)
    }
    
    func removeValute(_ index: Int) {
        currencyData.remove(at: index)
    }
}
