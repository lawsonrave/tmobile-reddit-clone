//
//  HomeVM.swift
//  Lawson TMobile Challenge Reddit Clone
//
//  Created by ravebizz on 5/2/21.
//

import Foundation

class HomeVM {
    
    var updateUIClosure: (() -> Void)?
    
    init() {
        updateUIClosure?()
    }
    
    func getData(completionHandler: ((Posts?) -> Void)?) {
        let url = URL(string: "http://www.reddit.com/.json")!
        getTask(completionHandler: completionHandler, url: url)
    }
    
    func getMoreData(afterLink: String = "", completionHandler: ((Posts?) -> Void)?) {
        let url = URL(string: "http://www.reddit.com/.json?after=\(afterLink)")!
        getTask(completionHandler: completionHandler, url: url)
    }
    
    func getTask(completionHandler: ((Posts?) -> Void)?, url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decodedData = try? JSONDecoder().decode(Posts.self, from: data)
            DispatchQueue.main.async {
                completionHandler?(decodedData)
            }
        }
        task.resume()
    }
    
}
