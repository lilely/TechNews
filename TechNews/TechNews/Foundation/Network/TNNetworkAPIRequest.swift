//
//  TNNetworkAPIRequest.swift
//  TechNews
//
//  Created by 金星 on 2020/2/29.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Alamofire
import Foundation

class TNNetworkAPIRequest<T: Codable> {
    var url: URL?
    var method: HTTPMethod
    var parameters: [String:Any]?
    var body: [String:Any]?
    var headers: [String:String]?
    
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
        self.headers?["Content-Type"] = "application/json"
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
        self.headers = headers;
        return self
    }
    
    func start(_ completion: @escaping (T?,Error?) -> Void){
        guard let url = self.url else {
            completion(nil,nil)
            return
        }
        Alamofire.request(url, method: self.method, parameters: self.body, encoding: JSONEncoding.default, headers: self.headers).validate().responseData { (response) in
            switch response.result {
                case let .success(body):
                    let reponse = try? JSONDecoder().decode(HTTPResponse<T>.self,from: body)
                    print(reponse?.data ?? "not found")
                    completion(reponse?.data,nil)
                    break
                
                case let .failure(error):
                    print(error)
                    completion(nil,error)
                    break
                }
        }
    }
}
