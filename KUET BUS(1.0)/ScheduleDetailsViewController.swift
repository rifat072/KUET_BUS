//
//  ScheduleDetailsViewController.swift
//  KUET BUS(1.0)
//
//  Created by CSE_KUET_12 on 11/29/18.
//  Copyright © 2018 Rifat. All rights reserved.
//

import UIKit

class ScheduleDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TripAll[myIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as!
            ScheduleCollectionViewCell
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

        cell.title.text = "  " + TripAll[myIndex][indexPath.row].index0
        cell.campustime.text = TripAll[myIndex][indexPath.row].index1
        cell.khulnatime.text = TripAll[myIndex][indexPath.row].index2
        cell.remark.text = TripAll[myIndex][indexPath.row].index3
        

        return cell
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
