//
//  AuroraTableRowModelTransform.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import Foundation

struct AuroraTableRowModelTransform: Transformable {
    typealias InputType = HttpRequest
    
    typealias OutputType = AuroraTableView.AuroraTableRowModel
    
    static func transform(_ input: HttpRequest) -> AuroraTableView.AuroraTableRowModel {
        .init(id: input.id,
              url: input.url,
              client: getClient(input.headers),
              method: input.method,
              status: "",
              code: "",
              time: "..",
              duration: "..",
              ssl: input.sslState.rawValue)
    }
    
    private static func getClient(_ headers: [String: String]) -> String {
        return headers["User-Agent"] ?? "uknow"
    }
}

extension HttpRequest {
    func transform() -> AuroraTableView.AuroraTableRowModel {
        AuroraTableRowModelTransform.transform(self)
    }
}
