//
//  NetworkManager.swift
//  WidgetDemo
//
//  Created by Piyush Chopra on 07/07/20.
//

import Alamofire
import Foundation
import Combine

class NetworkManager: ObservableObject {

    func fetchData(_ url: String, completion:@escaping (([String: Any]) -> Void)) {
        Alamofire.request(url)
            .responseJSON{ response in
                DispatchQueue.main.async {
                    guard let rawResponse = response.value as? [[String: Any]] else {
                        guard let rawResponse = response.value as? [String: Any] else {
                            return
                        }
                        completion(rawResponse)
                        return
                    }
                    completion(["data": rawResponse])
                }
            }
    }
}
