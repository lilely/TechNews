//
//  TNNetworkAPIRequest.swift
//  TechNews
//
//  Created by 金星 on 2020/2/29.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Alamofire
import Foundation

public class TNNetworkAPIRequest<T: Codable> {
    var url: URL?
    var method: HTTPMethod
    var parameters: [String:Any]?
    var body: [String:Any]?
    var headers: [String:String] = [:]
    
    init(_ url: String,_ method: HTTPMethod) {
        self.method = method
        let charSet = NSMutableCharacterSet()
        charSet.formUnion(with: CharacterSet.urlQueryAllowed)
        charSet.addCharacters(in: "#")
        guard let encodingURL = url.addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet) else {
            return
        }
    
        guard let finalURL = URL(string:encodingURL) else {
            return
        }
        self.headers["Content-Type"] = "application/json"
        self.url = finalURL
    }
    
    func parameters(_ params: [String:Any]) ->Self {
        self.parameters = params
        return self
    }
    
    func data(_ body: [String:Any]) -> Self {
        self.body = body;
        return self
    }
    
    func headers(_ headers:[String:String]) -> Self {
        self.headers = self.headers.merging(headers, uniquingKeysWith: { _, new in new })
        return self
    }
    
    func start(_ completion: @escaping (Result<T?>) -> Void){
        guard let url = self.url else {
            let error = HTTPError()
            completion(.failure(error))
            return
        }
        TNNetworkMiddlewareManager.default.respondTo(self)
        Alamofire.request(url, method: self.method, parameters: self.body, encoding: JSONEncoding.default, headers: self.headers).validate().responseData { (response) in
            switch response.result {
                case let .success(body):
                    let httpReponse = try? JSONDecoder().decode(HTTPResponse<T>.self,from: body)
                    //print(httpReponse?.data ?? "not found")
                    completion(.success(httpReponse?.data))
                    break
                
                case let .failure(error):
                    print(error)
                    completion(.failure(error))
                    break
                }
        }
    }
}
