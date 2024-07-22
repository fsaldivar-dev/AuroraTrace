//
//  HttpRequestTransformable.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation

struct HttpRequestTransform: Transformable {
    typealias InputType = HttpRequestDto
    typealias OutputType = HttpRequest
    
    static func transform(_ input: HttpRequestDto) -> HttpRequest {
        .init(id: input.id,
              method: input.method,
              url: input.host,
              path: input.path,
              headers: input.headers,
              query: input.query,
              host: input.host,
              port: input.port,
              scheme: input.scheme,
              body: input.body.transfrom(),
              content: input.content,
              fullURL: input.fullURL,
              timestampStart: input.timestampStart.transform(),
              timestampEnd: input.timestampEnd.transform(),
              cookies: input.cookies,
              sslState: input.sslState.transform())
    }
    
}

extension HttpRequestDto {
    func transform() -> HttpRequest {
        return HttpRequestTransform.transform(self)
    }
}
