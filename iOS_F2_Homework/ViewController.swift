//
//  ViewController.swift
//  iOS_F2_Homework
//
//  Created by Joshua Winskill on 9/29/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var studentArray = [Person]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadFromArchive()
        
        if studentArray.isEmpty {
            self.loadFromPList()
            self.saveToArchive()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let vc = segue.destinationViewController as DetailView
            var selectedIndexPath = self.tableView.indexPathForSelectedRow()
            var selectedPerson = self.studentArray[selectedIndexPath!.row]
            vc.student = selectedPerson
        }
    }
    
    func loadFromArchive() {
        // Get path to app's documents directory
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        // Attempt to unarchive the object graph
        if let peopleFromArchive = NSKeyedUnarchiver.unarchiveObjectWithFile(documentsPath + "/archive") as? [Person] {
            self.studentArray = peopleFromArchive
        }
        
    }
    
    func saveToArchive() {
        // Get path to documents directory
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        // Archive
        NSKeyedArchiver.archiveRootObject(self.studentArray, toFile: documentsPath + "/archive")
    }
    
    func populateArray() {
        for var i = 0; i < 5; i++ {
            let newPerson: Person = Person(firstName: "First\(i + 1)", lastName: "Last\(i + 1)", student: true)
            studentArray.append(newPerson)
        }
    }
    
    func loadFromPList() {
        // Get the path to our PList
        let path = NSBundle.mainBundle().pathForResource("studentList", ofType: "plist")
        
        // Create an array from the PList file
        let plistArray = NSArray(contentsOfFile: path!)
        
        // Loop through the PList to populate the array
        for person in plistArray {
            let firstNameFromPList = person["firstName"] as String
            let lastNameFromPList = person["lastName"] as String
            let student = Person(firstName: firstNameFromPList, lastName: lastNameFromPList, student: true)
            self.studentArray.append(student)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let personToBeLoaded = studentArray[indexPath.row]
        cell.textLabel!.text = personToBeLoaded.fullName()
        return cell
    }


}

