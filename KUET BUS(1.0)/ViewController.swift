//
//  ViewController.swift
//  KUET BUS(1.0)
//
//  Created by Rifat on 11/20/18.
//  Copyright © 2018 Rifat. All rights reserved.
//
import UIKit
import CoreData

struct TripToShow{
    let index0: String
    let index1: String
    let index2: String
    let index3: String
    init(Index0: String , Index1: String, Index2: String, Index3: String){
        index0 = Index0
        index1 = Index1
        index2 = Index2
        index3 = Index3
    }
}

var TripsData : [TripToShow] = []

var TripAll = [[TripToShow]](repeating: [TripToShow](repeating: TripToShow(Index0: "",Index1:"", Index2: "", Index3: ""), count: 1), count: 5)

struct Nearby{
    let title: String
    let time: String
    let remark: String
    let destination: String
    let destination2: String
    
    init(_title: String,_time: String, _destination: String,_destination2: String, _remark: String) {
        title = _title
        time = _time
        destination = _destination
        destination2 = _destination2
        remark = _remark
    }
}

var NearByKhulna: [Nearby] = []
var NearByKuet: [Nearby] = []


class ViewController: UIViewController {
    
    
    
    struct BusDescription: Decodable {
        let apiTitle: String?
        let apiDescription: String?
        let apiCreationDate: String?
        let developedBy: String?
        let url: String?
        let autoModifiedOn: String?
        let additionalNote: String?
        let values: Value
    }
    
    struct Value: Decodable{
        let Morning: [Trip]
        let Noon: [Trip]
        let Afternoon: [Trip]
        let Night: [Trip]
        let Saturday: [Trip]
    }
    
    struct Trip: Decodable{
        let index0: String?
        let index1: String?
        let index2: String?
        let index3: String?
    }

    func DeleteData(entity:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult> (entityName:entity)
        request.includesPropertyValues = false;
        do {
            let items = try context.fetch(request) as! [NSManagedObject]
            for item in items {
                context.delete(item)
            }
            try context.save()
        } catch  {
            print("Failed")
        }
    }
    

    func isNearby(time:String)->Bool{
        let Time = GetTime(str: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd h:mm a"
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "YYYY-MM-dd"
        
        var dateString = formatter.string(from: now)
        dateString += " "+Time
        
        let date = dateFormatter.date(from: dateString)
        let interval = date?.timeIntervalSinceNow
        let t = Int(interval!)/60
        if(t<1000 && t>=0){
            return true
        }
        else{
            return false
        }
    }
    
    func GetTime(str: String) -> String {
        var arr = str.components(separatedBy: ", ")
        if(arr.count == 1){
            return arr[0]
        }
        else{
            return arr[1]
        }
    }
    func getDestination2(str: String) -> String{
        var arr = str.components(separatedBy: ", ")
        if(arr.count == 1){
            return ""
        }
        else{
            return arr[0]
        }
    }
    

    
    func LoadData(entity:String, id: Int){
        TripAll[id].removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult> (entityName:entity)
        request.returnsObjectsAsFaults = false;
        do {
            let result = try context.fetch(request)
            var cnt = 0
            for data in result as! [NSManagedObject] {
                
                let temp = TripToShow(Index0: data.value(forKey: "trip_name") as! String,Index1: data.value(forKey: "start_campus") as! String,Index2: data.value(forKey: "start_khulna_time") as! String,Index3: data.value(forKey: "remarks") as! String)
                if(cnt != 0){
                    TripAll[id].append(temp)
                    if(isNearby(time: data.value(forKey: "start_campus") as! String)){
                        NearByKuet.append(Nearby(_title: data.value(forKey: "trip_name") as! String, _time: data.value(forKey: "start_campus") as! String, _destination: "Khulna", _destination2: getDestination2(str: data.value(forKey: "start_khulna_time")as! String),_remark: data.value(forKey: "remarks") as! String))
                        NearByKhulna.append(Nearby(_title: data.value(forKey: "trip_name") as! String, _time: GetTime(str: data.value(forKey: "start_khulna_time") as! String) , _destination: "Khulna", _destination2: getDestination2(str: data.value(forKey: "start_khulna_time") as! String), _remark: data.value(forKey: "remarks") as! String))
                    }
                }
                
                cnt = cnt + 1
                
                //print(data.value(forKey:"trip_name") as! String, data.value(forKey: "start_campus") as! String, data.value(forKey: "start_khulna_time"),data.value(forKey: "remarks") as! String)
            }
        } catch  {
            print("Failed")
        }
    }
    
    func SaveData(entity:String,trip_name:String, start_campus:String, start_khulna_time:String,remarks:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entity, in: context)
        let newrecord = NSManagedObject(entity: entity!, insertInto: context)
        newrecord.setValue(trip_name, forKey: "trip_name")
        newrecord.setValue(start_campus, forKey: "start_campus")
        newrecord.setValue(start_khulna_time, forKey : "start_khulna_time")
        newrecord.setValue(remarks, forKey : "remarks")
        do {
            try context.save()
        } catch  {
            print("Failed saving")
        }
    }
    
    func JsonParse(){
        
        
        let jsonUrlString = "https://script.googleusercontent.com/macros/echo?user_content_key=qoewmzekN7EjTD753WBD1Z_Ve_B0rCvvCnkuNqxJvBFPheX2Sp3tHCuZxaIzc17qbjJulLT9GOQeeP0QJ8xugL8QTHTp-Lj9m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnA4pYc6ryj8COOkQV7W5DxR0VUwzhItFQede_pq8mT2-DhK9GunvXrgK0fRfo0-HI_wSrHcae_pi&lib=MeRHtBj1FCHOrk7QgO_aaFlqR9hX156uw"
        guard let url = URL(string: jsonUrlString) else{ return }
        URLSession.shared.dataTask(with: url){(data,
            response, err) in
            guard let data = data else {return}
            do{
                DispatchQueue.main.async {
                    self.DeleteData(entity: "Morning")
                    self.DeleteData(entity: "Noon")
                    self.DeleteData(entity: "Afternoon")
                    self.DeleteData(entity: "Night")
                    self.DeleteData(entity: "Saturday")
                    
                    
                }
                let busdescription = try JSONDecoder().decode(BusDescription.self, from: data)
                for trip in busdescription.values.Morning{
                    
                    DispatchQueue.main.async {
                        self.SaveData(entity:"Morning",trip_name:trip.index0!, start_campus:trip.index1!, start_khulna_time:trip.index2!, remarks:trip.index3!)
                    }
                    
                }
                for trip in busdescription.values.Night{
                    DispatchQueue.main.async {
                        self.SaveData(entity:"Night",trip_name:trip.index0!, start_campus:trip.index1!, start_khulna_time:trip.index2!, remarks:trip.index3!)
                    }
                }
                for trip in busdescription.values.Noon{
                    DispatchQueue.main.async {
                        self.SaveData(entity:"Noon",trip_name:trip.index0!, start_campus:trip.index1!, start_khulna_time:trip.index2!, remarks:trip.index3!)
                    }
                }
                for trip in busdescription.values.Afternoon{
                    DispatchQueue.main.async {
                        self.SaveData(entity:"Afternoon",trip_name:trip.index0!, start_campus:trip.index1!, start_khulna_time:trip.index2!, remarks:trip.index3!)
                    }
                }
                for trip in busdescription.values.Saturday{
                    //print(trip.index0,trip.index1,trip.index2,trip.index3);
                    DispatchQueue.main.async {
                        self.SaveData(entity:"Saturday",trip_name:trip.index0!, start_campus:trip.index1!, start_khulna_time:trip.index2!, remarks:trip.index3!)
                    }
                }
                
            }catch let jsonErr{
                print("Error serializing json :", jsonErr)
            }
            
            }.resume()
        DispatchQueue.main.async {
            self.LoadData(entity: "Morning",id: 0)
            self.LoadData(entity: "Noon",id: 1)
            self.LoadData(entity: "Afternoon",id: 2)
            self.LoadData(entity: "Night",id: 3)
            self.LoadData(entity: "Saturday",id: 4)
        }
        DispatchQueue.main.async {
            ///for debuggin purposse
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.JsonParse()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            self.performSegue(withIdentifier: "nextsplash", sender: nil)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
