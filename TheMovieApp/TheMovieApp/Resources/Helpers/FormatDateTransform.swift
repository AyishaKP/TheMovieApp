//
//  FormatDateTransform.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import ObjectMapper

class FormatDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String

    private var formatter: DateFormatter

    public init(mask: String) {
        self.formatter = DateFormatter()
        self.formatter.dateFormat = mask
    }

    open func transformFromJSON(_ value: Any?) -> Date? {
        guard let string = value as? String else { return nil }
        return self.formatter.date(from: string)
    }

    open func transformToJSON(_ value: Date?) -> String? {
        guard let date = value else { return nil }
        return self.formatter.string(from: date)
    }
}
