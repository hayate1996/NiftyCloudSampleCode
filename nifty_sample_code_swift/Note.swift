//
//  Note.swift
//  nifty_sample_code_swift
//
//  Created by NAGAMINE HIROMASA on 2016/03/11.
//  Copyright © 2016年 NAGAMINE HIROMASA. All rights reserved.
//

import Foundation

class Note: NCMBObject {
    var title: String = ""
    var detail: String = ""
    var date: NSDate = NSDate()

    init(title: String, detail: String, date: NSDate) {
        super.init(className: ClassName.Note.rawValue)
        self.title = title
        self.detail = detail
        self.date = date
    }

    func initialize() {
        title = objectForKey("title").string
        detail = objectForKey("detail").string
        date = objectForKey("date").date
    }

    func save() -> Bool{
        setObject(title, forKey: "title")
        setObject(detail, forKey: "detail")
        setObject(date, forKey: "date")

        var saveError: NSError? = nil
        self.save(&saveError)

        print("[Note: save] \(self.description)")
        guard let _error = saveError else {
            return true
        }

        print("[Note: saveError] \(self.objectId) - \(_error.description)")
        return false
    }
}
