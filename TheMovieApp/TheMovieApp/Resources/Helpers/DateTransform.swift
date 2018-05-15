//
//  DateTransform.swift
//  TheMovieApp
//
//  Created by Ayisha on 16/05/18.
//  Copyright © 2018 Careem. All rights reserved.
//

import ObjectMapper

class DateTransform: FormatDateTransform {

    public init() {
        super.init(mask: "yyyy-MM-dd")
    }
}
