//
//  CloudModelManager.swift
//  nifty_sample_code_swift
//
//  Created by NAGAMINE HIROMASA on 2016/03/09.
//  Copyright © 2016年 NAGAMINE HIROMASA. All rights reserved.
//

import Foundation

struct CloudModelManager {
    static var noteList: [Note] = []
    static var needSyncNoteList: [Note] = []

    static func initializeNCMB() {
        guard let bundle: NSBundle = NSBundle.mainBundle(),
            let resourcePath: String = bundle.pathForResource("Info", ofType: "plist"),
            let resources: NSDictionary = NSDictionary(contentsOfFile: resourcePath) else {
                return
        }

        let applicationKey: String = resources.objectForKey("applicationKey") as? String ?? ""
        let clientKey: String = resources.objectForKey("clientKey") as? String ?? ""
        NCMB.setApplicationKey(applicationKey, clientKey: clientKey)
    }

    static func addNote(note: Note) {
        needSyncNoteList.append(note)
    }

    static func needSave() -> Bool {
        return needSyncNoteList.count > 0
    }

    static func sync() {
        if needSave() {
            needSyncNoteList = save()
        }

        noteList = fetchNotes()
    }

    static func fetchNotes() -> [Note] {
        let fetchedResult:[Note] = []
        return fetchedResult
    }

    static func save() -> [Note] {
        var failedList: [Note] = []

        for note in needSyncNoteList {
            if note.save() == false {
                failedList.append(note)
            }
        }

        return failedList
    }

    static func saveObjectInBackgound(object object: NCMBObject) {

        object.saveInBackgroundWithBlock { (error) -> Void in
            if (error != nil) {
                print("[Save Failed] error - \(error.description)")
            }
            else {
                print("[Save Success] object - \(object)")
            }
        }
    }
}