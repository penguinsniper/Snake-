//
//  HighScore+CoreDataProperties.swift
//  Snake🐍
//
//  Created by Ryan Lau on 5/3/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//
//

import Foundation
import CoreData


extension HighScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HighScore> {
        return NSFetchRequest<HighScore>(entityName: "HighScore")
    }


}
