//
//  HighScore+CoreDataClass.swift
//  Snake🐍
//
//  Created by Ryan Lau on 5/3/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//
//

import Foundation
import CoreData

@objc(HighScore)
public class HighScore: NSManagedObject {
    func saveToCoreData() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let entity = NSEntityDescription.entityForName("HighScore", inManagedObjectContext: context)!
        
       
        var theNewHighScore = HighScore(entity: entity, insertIntoManagedObjectContext: context)
        
        
        theNewHighestStreak.highScore = yourHighScoreTrackingVariable
        context.save(nil)
    }
    override func viewDidAppear(animated: Bool) {
        let appDel = (UIApplication.sharedApplication().delegate as AppDelegate)
        let context = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "HighScore")
        request.returnsObjectsAsFaults = false
        let results: NSArray = context?.executeFetchRequest(request, error: nil) as NSArray!
        if results.count == 0 {
            println("results.count was 0")
        } else {
            yourHighScoreTrackingVariable = results[results.count-1].highScore
        }
    }

}
