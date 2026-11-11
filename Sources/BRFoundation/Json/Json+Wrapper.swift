//
//  Json+Wrapper.swift
//  BRFoundation
//
//  Created by BR on 2026/4/29.
//


public extension BRWrapper where Base: Encodable {
    
    
    /// 將當前物件轉換為 JSON Data
    func toJSONData(output: JSONEncoder.OutputFormatting = [], date: JSONEncoder.DateEncodingStrategy = .deferredToDate) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = output
        encoder.dateEncodingStrategy = date
        return try encoder.encode(base)
    }
    
    
    /// 將當前物件轉換為 JSON 字串 (方便除錯或 API 傳輸)
    func toJSONString(output: JSONEncoder.OutputFormatting = [.prettyPrinted], date: JSONEncoder.DateEncodingStrategy = .deferredToDate) throws -> String {
        let data = try toJSONData(output: output, date: date)
        guard let string = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "Encoding", code: -1, userInfo: [NSLocalizedDescriptionKey: "無法轉為字串"])
        }
        return string
    }

    
}


public extension BRWrapper where Base: Decodable {
    
    
    /// 從 Json Data 建立實例
    ///
    /// ``` swift
    /// struct User: BRJSONCodable, Equatable {
    ///     let id: Int
    ///     let name: String
    /// }
    ///
    /// let jsonString =
    ///     """
    ///     {
    ///         "id" : 1,
    ///         "name" : "BR"
    ///     }
    ///     """
    ///
    /// if let data = jsonString.data(using: .utf8) {
    ///     let user = try User.fromJSON(data)
    /// }
    /// ```
    static func fromJSON(_ data: Data, decoder: JSONDecoder = JSONDecoder()) throws -> Base {
        return try decoder.decode(Base.self, from: data)
    }
    
    
    /// 從 Json String 轉換成物件
    ///
    /// ```swift
    /// struct User: BRJSONCodable, Equatable {
    ///     let id: Int
    ///     let name: String
    /// }
    ///
    /// let jsonString =
    ///     """
    ///     {
    ///         "id" : 1,
    ///         "name" : "BR"
    ///     }
    ///     """
    ///
    /// let user = try User.fromJSON(jsonString)
    /// ```
    static func fromJSON(_ text: String, decoder: JSONDecoder = JSONDecoder()) throws -> Base {
        guard let data = text.data(using: .utf8) else {
            throw NSError(domain: "JSONDecoding", code: -1, userInfo: [NSLocalizedDescriptionKey: "無法將字串轉為 Data"])
        }
        return try fromJSON(data, decoder: decoder)
    }
    

}
