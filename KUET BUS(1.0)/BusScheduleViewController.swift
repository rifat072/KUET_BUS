//
//  BusScheduleViewController.swift
//  KUET BUS(1.0)
//
//  Created by kuet on 26/11/18.
//  Copyright © 2018 Rifat. All rights reserved.
//

import UIKit



var schedule = ["Morning", "Noon" , "Afternoon" , "Night" , "Saturday"]
var myIndex = 0


class BusScheduleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = schedule[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        myIndex = indexPath.row

        performSegue(withIdentifier: "segue", sender: self)

        
    }
}


