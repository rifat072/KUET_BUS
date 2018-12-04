//
//  NearByKhulnaViewController.swift
//  KUET BUS(1.0)
//
//  Created by Rifat on 12/3/18.
//  Copyright © 2018 Rifat. All rights reserved.
//

import UIKit

class NearByKhulnaViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NearByKhulna.count
    }
    
    func getFormat(seconds: Int) -> (Int, Int) {
        return (seconds/3600,(seconds%3600)/60)
    }
    
    func timeInterval(time:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd h:mm a"
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "YYYY-MM-dd"
        
        var dateString = formatter.string(from: now)
        dateString += " " + time
        
        let date = dateFormatter.date(from: dateString)
        let interval = date?.timeIntervalSinceNow
        let t = Int(interval!)
        let (h,m) = getFormat(seconds: t)
        let ret = "\(h) Hr \(m) Min"
        
        return ret
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbykhulnacell", for: indexPath) as!
        NearbyKhulnaCollectionViewCell
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
        
        cell.title.text = "  " + NearByKhulna[indexPath.row].title
        cell.time.text = NearByKhulna[indexPath.row].time
        cell.timeleft.text = timeInterval(time: NearByKhulna[indexPath.row].time)
        cell.destination.text = NearByKhulna[indexPath.row].destination
        cell.remark.text = NearByKhulna[indexPath.row].remark;
        cell.destination2.text = NearByKhulna[indexPath.row].destination2
        cell.index = indexPath
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
