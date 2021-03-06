//
//  FISU_applicationTests.swift
//  FISU_applicationTests
//
//  Created by Arnaud ZARAGOZA on 22/02/2016.
//  Copyright © 2016 Arnaud ZARAGOZA. All rights reserved.
//

import XCTest
@testable import FISU_application

// The tests worked before the utilisation of the core data but not now.
class FISU_applicationTests: XCTestCase {
    
     func getMontagne() -> Place {
        let place = Place()
        place.title = "Montagne"
        place.latitude = 40
        place.longitude = 2
        place.subTitle = "Montagne description"
        
        return place
    }
    
     func getCom() -> Place {
        let place = Place()
        place.title = "Comedie"
        place.latitude = 43.6109200
        place.longitude = 3.8772300
        place.subTitle = "Place de la Comédie"
        
        return place
    }
    
    
     func getActivityCategory() -> ActivityCategory {
        let cat = ActivityCategory()
        cat.name = "category de test"
        return cat
    }
    
     func getActivitySki() -> Activity {
        let ski = Activity()
        
        //ski.setValue("Ski", forKey: "name")
        ski.name = "Ski"
        ski.descriptionActivity = "Ski dans la montagne"
        ski.going = false
        ski.beginning = stringToDate("02-23-2016 08:30").timeIntervalSince1970
        ski.ending = stringToDate("02-23-2016 09:30").timeIntervalSince1970
        ski.category = self.getActivityCategory()
        ski.location = self.getMontagne()
        
        return ski
    }
    
    func getActivityRepas() -> Activity {
        let repas = Activity()
        repas.name = "Repas"
        repas.descriptionActivity = "Repas description"
        repas.going = true
        repas.beginning = stringToDate("02-23-2016 12:30").timeIntervalSince1970
        repas.ending = stringToDate("02-23-2016 14:00").timeIntervalSince1970
        repas.category = self.getActivityCategory()
        repas.location = self.getCom()
        
        return repas
    }
    
    func getActivityRando() -> Activity {
        let rando = Activity()
        rando.name = "Rando"
        rando.descriptionActivity = "Rando description"
        rando.going = true
        rando.beginning = stringToDate("02-23-2016 10:30").timeIntervalSince1970
        rando.ending = stringToDate("02-23-2016 11:00").timeIntervalSince1970
        rando.category = self.getActivityCategory()
        rando.location = self.getCom()
        
        return rando
    }
    
    func getActivityRandoFin() -> Activity {
        let rando = Activity()
        rando.name = "Rando d'adieux"
        rando.descriptionActivity = "Rando d'adieux description"
        rando.going = true
        rando.beginning = stringToDate("02-24-2016 10:30").timeIntervalSince1970
        rando.ending = stringToDate("02-24-2016 11:00").timeIntervalSince1970
        rando.category = self.getActivityCategory()
        rando.location = self.getCom()
        
        return rando
    }
    
    func getActivityRandoDebut() -> Activity {
        let rando = Activity()
        rando.name = "Rando de début"
        rando.descriptionActivity = "Rando de début description"
        rando.going = true
        rando.beginning = stringToDate("02-22-2016 10:30").timeIntervalSince1970
        rando.ending = stringToDate("02-22-2016 11:00").timeIntervalSince1970
        rando.category = self.getActivityCategory()
        rando.location = self.getCom()
        
        return rando
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProgramme() {
        let programme = Programme()
        let ski = self.getActivitySki()
        let miam = self.getActivityRepas()
        let rando = self.getActivityRando()
        
        XCTAssertEqual(programme.numberOfDays(), 0)
        
        // add one
        programme.addActivity(ski)
        XCTAssertEqual(programme.numberOfDays(), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(ski.begin), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(0), 1)
        XCTAssertNil(programme.numberOfActivityForDay(1))
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 0), ski)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 0), ski)
        
        // add the same
        programme.addActivity(ski)
        XCTAssertEqual(programme.numberOfDays(), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(ski.begin), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(0), 1)
        XCTAssertNil(programme.numberOfActivityForDay(1))
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 0), ski)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 0), ski)
        
        // add new activity same day
        programme.addActivity(miam)
        XCTAssertEqual(programme.numberOfDays(), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(ski.begin), 2)
        XCTAssertEqual(programme.numberOfActivityForDay(0), 2)
        XCTAssertNil(programme.numberOfActivityForDay(1))
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 0), ski)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 0), ski)
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 1), miam)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 1), miam)
        
        // add same day, disorder hour
        programme.addActivity(rando)
        XCTAssertEqual(programme.numberOfDays(), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(ski.begin), 3)
        XCTAssertEqual(programme.numberOfActivityForDay(0), 3)
        XCTAssertNil(programme.numberOfActivityForDay(1))
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 0), ski)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 0), ski)
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 1), rando)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 1), rando)
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 2), miam)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 2), miam)
        
        // a new day
        let randoDeFin = self.getActivityRandoFin()
        programme.addActivity(randoDeFin)
        XCTAssertEqual(programme.numberOfDays(), 2)
        XCTAssertEqual(programme.numberOfActivityForDay(randoDeFin.begin), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(1), 1)
        XCTAssertNil(programme.numberOfActivityForDay(2))
        XCTAssertEqual(programme.getAtIndex(1, activityIndex: 0), randoDeFin)
        XCTAssertEqual(programme.getAtDate(randoDeFin.begin, index: 0), randoDeFin)
        
        XCTAssertEqual(programme.numberOfActivityForDay(rando.begin), 3)
        XCTAssertEqual(programme.numberOfActivityForDay(0), 3)
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 0), ski)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 0), ski)
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 1), rando)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 1), rando)
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 2), miam)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 2), miam)
        
        // add activity before all
        let randoDeDebut = self.getActivityRandoDebut()
        programme.addActivity(randoDeDebut)
        XCTAssertEqual(programme.numberOfDays(), 3)
        XCTAssertEqual(programme.numberOfActivityForDay(randoDeDebut.begin), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(0), 1)
        XCTAssertNil(programme.numberOfActivityForDay(3))
        XCTAssertEqual(programme.getAtIndex(0, activityIndex: 0), randoDeDebut)
        XCTAssertEqual(programme.getAtDate(randoDeDebut.begin, index: 0), randoDeDebut)
        
        XCTAssertEqual(programme.numberOfActivityForDay(rando.begin), 3)
        XCTAssertEqual(programme.numberOfActivityForDay(1), 3)
        XCTAssertEqual(programme.getAtIndex(1, activityIndex: 0), ski)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 0), ski)
        XCTAssertEqual(programme.getAtIndex(1, activityIndex: 1), rando)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 1), rando)
        XCTAssertEqual(programme.getAtIndex(1, activityIndex: 2), miam)
        XCTAssertEqual(programme.getAtDate(ski.begin, index: 2), miam)
        
        XCTAssertEqual(programme.numberOfActivityForDay(randoDeFin.begin), 1)
        XCTAssertEqual(programme.numberOfActivityForDay(2), 1)
        XCTAssertEqual(programme.getAtIndex(2, activityIndex: 0), randoDeFin)
        XCTAssertEqual(programme.getAtDate(randoDeFin.begin, index: 0), randoDeFin)

        
        
        
    }
    
    func testDayWithActivity() {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        // convert string into date
        let date = dateFormatter.dateFromString("02-23-2016 00:00") as NSDate!
        
        let dayWithActivities = DayWithActivities(day: date)
        
        let ski = self.getActivitySki()
        //let conf = Activity(name: "Conf intro", place: Place.polytech, begin: "02-22-2016 08:30", end: "02-23-2016 11:30")
        let miam = self.getActivityRepas()
        let rando = self.getActivityRando()
        
        XCTAssertEqual(dayWithActivities.numberOfActivity(), 0)
        
        // Simple add
        XCTAssertEqual(dayWithActivities.addActivity(ski), 0)
        XCTAssertEqual(dayWithActivities.getActivityAtIndex(0), ski)
        XCTAssertEqual(dayWithActivities.numberOfActivity(), 1)
        XCTAssertEqual(dayWithActivities.contains(ski), true)
        
        // Add an already existing activity
        XCTAssertEqual(dayWithActivities.addActivity(ski), nil)
        XCTAssertEqual(dayWithActivities.numberOfActivity(), 1)
        XCTAssertEqual(dayWithActivities.getActivityAtIndex(0), ski)
        
        // Add a second activity
        XCTAssertEqual(dayWithActivities.addActivity(miam), 1)
        XCTAssertEqual(dayWithActivities.numberOfActivity(), 2)
        XCTAssertEqual(dayWithActivities.getActivityAtIndex(0), ski)
        XCTAssertEqual(dayWithActivities.getActivityAtIndex(1), miam)
        
        // Add a thrid activity and reorder the activities
        XCTAssertEqual(dayWithActivities.addActivity(rando), 1)
        XCTAssertEqual(dayWithActivities.numberOfActivity(), 3)
        XCTAssertEqual(dayWithActivities.getActivityAtIndex(0), ski)
        XCTAssertEqual(dayWithActivities.getActivityAtIndex(1), rando)
        XCTAssertEqual(dayWithActivities.getActivityAtIndex(2), miam)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    
    private func stringToDate (date : String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        // convert string into date
        return dateFormatter.dateFromString(date) as NSDate!
    }
    
}
