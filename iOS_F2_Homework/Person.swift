//
//  Person.swift
//  iOS_F2_Homework
//
//  Created by Joshua Winskill on 9/29/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

import Foundation
import UIKit

class Person : NSObject, NSCoding {
    var firstName: String
    var lastName: String
    var student: Bool
    var studentPicture: UIImage?
    
    init(firstName: String, lastName: String, student: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.student = true
    }
    
    required init(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObjectForKey("firstName") as String
        self.lastName = aDecoder.decodeObjectForKey("lastName") as String
        self.student = aDecoder.decodeBoolForKey("student") as Bool
        if let decodedImage = aDecoder.decodeObjectForKey("studentPicture") as? UIImage {
            self.studentPicture = decodedImage
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.firstName, forKey: "firstName")
        aCoder.encodeObject(self.lastName, forKey: "lastName")
        if self.studentPicture != nil {
            aCoder.encodeObject(self.studentPicture!, forKey: "studentPicture")
        }
    }
    
    
    func fullName()->String {
    return self.firstName + " " + self.lastName
    }
    
}