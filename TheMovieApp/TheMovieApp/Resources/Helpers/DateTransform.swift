//
//  DateTransform.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import ObjectMapper

class DateTransform: DateFormatterTransform {

    public init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        super.init(dateFormatter: dateFormatter)
    }
}
