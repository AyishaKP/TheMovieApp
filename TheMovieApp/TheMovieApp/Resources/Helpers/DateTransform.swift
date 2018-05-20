//
//  DateTransform.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import ObjectMapper

class DateTransform: DateFormatterTransform {
    /**
    - Used to make a date string to swift date transformation
      while parsing a date string in json response.
    - Parameter dateFormat needs to be passed to the initializer
      to support any date format that can be received from backend.
     */
    init(dateFormat: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        super.init(dateFormatter: dateFormatter)
    }
}
