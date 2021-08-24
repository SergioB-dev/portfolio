//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Sergio Bost on 8/17/21.
//

import SwiftUI

final class NetworkManager: ObservableObject {
    @Published var portfoliios = [Portfolio]()
    @Published var portfolioIndex = 0
    @Published var currentPortfolio: Portfolio?
    
    
    #if DEBUG
    var urlString = "http://localhost:8080"
    #endif
    
    #if !DEBUG
    var urlString = "http://localhost:8080"
    #endif
    
    //MARK: - GET PORTFOLIOS
    
    func getAllPortfolios(result: @escaping (Result<[Portfolio], Error>) -> Void) {
        var request = URLRequest(url: URL(string: urlString + "/portfolios")!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {  data, response, error in
            guard error == nil else {
                result(.failure(error!))
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let portfolios = try decoder.decode([Portfolio].self, from: data)
                    result(.success(portfolios))
                    DispatchQueue.main.async {
                        self.portfoliios = portfolios
                        self.currentPortfolio = portfolios[0]
                        print("Pulled \(portfolios.count) portfolios from server.")
                    }
                } catch {
                    result(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    
    func stepBackwards (){
        guard portfolioIndex != 0 else { return }
        portfolioIndex -= 1
        withAnimation {
            currentPortfolio = portfoliios[portfolioIndex]
        }
    }
    
    func stepForward() {
        guard portfolioIndex <= portfoliios.count - 2 else { return }
        portfolioIndex += 1
        withAnimation {
            currentPortfolio = portfoliios[portfolioIndex]
        }
    }
}
