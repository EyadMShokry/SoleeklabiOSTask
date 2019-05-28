//
//  Client.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/26/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import Foundation

class Client {
    
    class func shared() -> Client {
        struct Singleton {
            static var shared = Client()
        }
        return Singleton.shared
    }
    
    
    func getCountriesNamesAndCapitals(completionHandler: @escaping(_ result: [Dictionary<String, String>]?, _ error: NSError?) -> Void) {
        let url = buildURLFromParameters([RESTCountriesParameterKeys.Fields:   RESTCountiresParameterValues.Fields])
        
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                func sendError(_ error: String) {
                    print(error)
                    let userInfo = [NSLocalizedDescriptionKey: error]
                    completionHandler(nil, NSError(domain: "getCountriesNamesAndCapitals", code: 1, userInfo: userInfo))
                }
                
                guard (error == nil) else {
                    sendError("An Error happened with your Request: \(error!.localizedDescription)")
                    return
                }
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                    sendError("Your Request returned status code other than 2XX!")
                    return
                }
                
                guard let data = data else {
                    sendError("No data returned from your Request")
                    return
                }
                
                do {
                    if let countriesArray = try JSONSerialization.jsonObject(with: data) as? [Dictionary<String, String>] {
                      completionHandler(countriesArray, nil)
                    }
                } catch let error as NSError{
                    sendError("An Error happend while decoding Data: \(error.localizedDescription)")
                }
            }.resume()
    }
    
    
    private func buildURLFromParameters(_ parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.host = RESTCountries.APIHost
        components.scheme = RESTCountries.APIScheme
        components.path = RESTCountries.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}
