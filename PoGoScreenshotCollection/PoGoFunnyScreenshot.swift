//
//  PoGoFunnyScreenshot.swift
//  PoGoScreenshotCollection
//
//  Created by Marco Knipfer on 27.09.17.
//  Copyright © 2017 Marco Knipfer. All rights reserved.
//

import Foundation
import UIKit

class PoGoFunnyScreenshot: NSObject, NSCoding {
    var image: UIImage
    let date: Date
    var note: String?
    
    init(image: UIImage, date: Date, note: String?) {
        self.image = image
        self.date = date
        self.note = note
    }
    
    // MARK: NSObject, NSCoding
    struct PropertyKeys {
        static let image = "image"
        static let date = "date"
        static let note = "note"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let image = aDecoder.decodeObject(forKey: PropertyKeys.image) as? UIImage,
            let date = aDecoder.decodeObject(forKey: PropertyKeys.date) as? Date else { return nil }
        let note = aDecoder.decodeObject(forKey: PropertyKeys.note) as? String
        self.init(image: image, date: date, note: note)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: PropertyKeys.image)
        aCoder.encode(date, forKey: PropertyKeys.date)
        aCoder.encode(note, forKey: PropertyKeys.note)
    }
    
    // MARK: Saving, Loading
    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveUrl = documentsDirectory.appendingPathComponent("poGoFunnyScreenshots")
    
    static func saveToFile(array: [PoGoFunnyScreenshot]) {
        NSKeyedArchiver.archiveRootObject(array, toFile: archiveUrl.path)
    }
    
    static func loadFromFile() -> [PoGoFunnyScreenshot]? {
        if let array = NSKeyedUnarchiver.unarchiveObject(withFile: archiveUrl.path) as? [PoGoFunnyScreenshot] {
            return array
        } else {
            print("Could not get PoGoFunnyScreenshots from File")
            return nil
        }
    }
}
