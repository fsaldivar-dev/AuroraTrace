//
//  AuroraTableRowModelTransform.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import Foundation
import UAParserSwift

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
        guard let agent = headers["User-Agent"] ?? headers["user-agent"] else {
            return "Unknown"
        }
        let parser = UAParser(agent: agent)
        return parser.browser?.name ?? parser.engine?.name ?? determineClientApp(from: parser.agent)
    }
    
    static func determineClientApp(from userAgent: String) -> String {
        let components = userAgent.components(separatedBy: CharacterSet(charactersIn: " /()"))
        
        for component in components where component.count > 1 {
            if !component.allSatisfy({ $0.isNumber || $0 == "." }) &&
               !["Mozilla", "AppleWebKit", "KHTML", "Gecko", "like", "Version"].contains(component) {
                return component
            }
        }
        
        return userAgent
    }
}

extension HttpRequest {
    func transform() -> AuroraTableView.AuroraTableRowModel {
        AuroraTableRowModelTransform.transform(self)
    }
}
