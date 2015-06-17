//
//  Project.swift
//  srvup
//
//  Created by Justin Mitchel on 6/15/15.
//  Copyright (c) 2015 Coding for Entrepreneurs. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class Project:NSObject {
    var title:String
    var url:String
    var id:Int
    var slug:String?
    var projectDescription: String?
    var imageUrlString: String?
    // var videoSet = [JSON]()
    var lectureSet = [Lecture]()
    
    init(title:String, url:String, id:Int) {
        self.title = title
        self.url = url
        self.id = id
    }
    
    func image() -> UIImage? {
        if self.imageUrlString != nil {
            let url = NSURL(string: self.imageUrlString!)!
            let imageData = NSData(contentsOfURL: url)!
            let image = UIImage(data: imageData)
            return image
        }
        
        return nil
    }
    
    func createLectures(theArray:[JSON]) {
        if self.lectureSet.count == 0 && theArray.count > 0 {
            for i in theArray {
                var lecture = Lecture(title: i["title"].string!, url: i["url"].string!, id: i["id"].int!, slug: i["slug"].string!, order: i["order"].int!, embedCode: i["embed_code"].string!)
                
                lecture.shareMessage = i["share_message"].string
                lecture.timestamp = i["timestamp"].string
                if i["comment_set"].array != nil {
                    lecture.commentSet = i["comment_set"].array!
                }
                if i["free_preview"].bool != nil {
                    lecture.freePreview = i["free_preview"].bool!
                }
                self.lectureSet.append(lecture)
            }
        }
        
    }
    
}

class Lecture: NSObject {
    var title: String
    var url: String
    var id: Int
    var slug: String
    var order: Int
    var embedCode: String
    var freePreview = false
    var shareMessage: String?
    var timestamp: String?
    var commentSet = [JSON]()
    
    init(title:String, url:String, id:Int, slug:String, order:Int, embedCode:String) {
        self.title = title
        self.url = url
        self.id = id
        self.slug = slug
        self.order = order
        self.embedCode = embedCode
    }
    
    
    
}