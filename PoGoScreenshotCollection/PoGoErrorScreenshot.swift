//
//  PoGoErrorScreenshot.swift
//  PoGoScreenshotCollection
//
//  Created by Marco Knipfer on 27.09.17.
//  Copyright © 2017 Marco Knipfer. All rights reserved.
//

import Foundation
import UIKit

class PoGoErrorScreenshot: NSObject, NSCoding {
    var id: Int
    var image: UIImage?
    static let defaultNumberOfErrors = 33
//    var description: String
    
    struct PropertyKeys {
        static let id = "id"
        static let image = "image"
    }
    
    init(id: Int, image: UIImage?) {
        if let image = image {
            self.image = image
        } else {
            self.image = nil
        }
        self.id = id
        super.init()
    }
    
    init(id: Int) {
        self.id = id
        self.image = nil
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
//        if let id = aDecoder.decodeObject(forKey: PropertyKeys.id) as? Int {
        let id = aDecoder.decodeInteger(forKey: PropertyKeys.id)
        print("decoded id: \(id)")

        let image = aDecoder.decodeObject(forKey: PropertyKeys.image) as? UIImage
        self.init(id: id, image: image)

    }
    
    func encode(with aCoder: NSCoder) {
        print("saving to disk: id=\(id), image=\(image)")
        aCoder.encode(id, forKey: PropertyKeys.id)
        aCoder.encode(image, forKey: PropertyKeys.image)
    }
    
    static func defaulArray() -> [Int: PoGoErrorScreenshot] {
        var array = [Int: PoGoErrorScreenshot]()
        for id in 1..<(defaultNumberOfErrors + 1) {
            array[id] = PoGoErrorScreenshot(id: id)
        }
        return array
    }
    
    // MARK: Saving

    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveUrl = documentsDirectory.appendingPathComponent("poGoErrorScreenshots")
    
    static func saveToDisc(poGoErrorScreenshotDictionary: [Int: PoGoErrorScreenshot]) {
        let poGoErrorScreenshotArray: [PoGoErrorScreenshot] = Array(poGoErrorScreenshotDictionary.values)

        NSKeyedArchiver.archiveRootObject(poGoErrorScreenshotArray, toFile: archiveUrl.path)
    }
    
    static func loadFromDisc() -> [Int: PoGoErrorScreenshot]? {
        var poGoErrorScreenshotDictionary = [Int: PoGoErrorScreenshot]()
        
        // MARK: TODO: Why does this not work? poGoErrorScreenshots is always empty
        if let poGoErrorScreenshots = NSKeyedUnarchiver.unarchiveObject(withFile: archiveUrl.path) as? [PoGoErrorScreenshot], !poGoErrorScreenshots.isEmpty {
            for poGoErrorScreenshot in poGoErrorScreenshots{
                poGoErrorScreenshotDictionary[poGoErrorScreenshot.id] = poGoErrorScreenshot
            }
            print("Loaded \(poGoErrorScreenshots.count) errorScreenshots")
            return poGoErrorScreenshotDictionary
        } else {
            return nil
        }
    }
}

