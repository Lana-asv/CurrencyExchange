//
//  Network.swift
//  ExchangeRateApp
//
//  Created by Sveta on 13.12.2021.
//

import Foundation

final class NetworkNewsManager {
    
//    https://api.currencyscoop.com/v1/historical?api_key=d12509d883a51cdead2d47deb84c6d0c&base=RUB&date=2021-12-14
    
    func fetchNews(completionHandler: @escaping ([Rate]) -> Void) {
           
           let urlString = "https://api.currencyscoop.com/v1/latest?api_key=d12509d883a51cdead2d47deb84c6d0c&base=RUB"
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

            let rate = self.parseJSON(withData: data)
            DispatchQueue.main.async {
                completionHandler(rate)
            }
           }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> [Rate] {
        let decoder = JSONDecoder()
        do {
            let welcomeData = try decoder.decode(CurrentData.self, from: data)
            
            var news = [Rate]()
            for result in [welcomeData.response] {
                if let newsItem = Rate(data: result) {
                    news.append(newsItem)
                }
            }
            return news
        } catch let error as NSError {
            print(error)
        }
        return []
    }
}
