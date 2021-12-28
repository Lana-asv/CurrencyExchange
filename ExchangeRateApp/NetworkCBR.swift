//
//  NetworkCBR.swift
//  ExchangeRateApp
//
//  Created by Sveta on 15.12.2021.
//

import Foundation

final class NetworkCBRManager {
    
    func fetchRate(completionHandler: @escaping ([Valute]) -> Void) {
           
           let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
           guard let url = URL(string: urlString) else { return }
           
           var request = URLRequest(url: url, timeoutInterval: Double.infinity)
           request.httpMethod = "GET"
           
           let task = URLSession.shared.dataTask(with: request) { (data, responce, error) in
               guard let data = data else {
                   print(String(describing: error))
                    DispatchQueue.main.async {
                        completionHandler([])
                    }
                   return
               }

            let valutes = self.parseJSON(withData: data)
            DispatchQueue.main.async {
                completionHandler(valutes)
            }
           }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> [Valute] {
        let decoder = JSONDecoder()
        do {
            let cbrData = try decoder.decode(CBRData.self, from: data)
            return cbrData.valute.map { return $0.value }
        } catch let error as NSError {
            print(error)
        }
        return []
    }
}
