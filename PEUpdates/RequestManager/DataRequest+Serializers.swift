//
//  DataRequest+Serializers.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-06-05.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Alamofire


extension DataRequest {
    
    static func hartleysJsonResponseSerializer() -> DataResponseSerializer<Any> {
        return DataResponseSerializer(serializeResponse: { (_, response, data, error) -> Result<Any> in
            guard error == nil else { return .failure(error!) }
            
            guard let validData = data, validData.count > 0 else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
            }
            
            let jString = String(data: validData, encoding: .utf8)
            let cString = jString?.replacingOccurrences(of: "\r\n", with: "")
            let jData = cString?.data(using: .utf8)
            
            guard let jsonData = jData else {
                return .failure(Errors.unexpectedResponseDataStructureError())
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
                return .success(json)
            } catch {
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
            }
        })
    }
}
