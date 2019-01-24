//
//  CityesController.swift
//  Weather
//
//  Created by Alexandra Gorshkova on 22/01/2019.
//  Copyright © 2019 Alexandra Gorshkova. All rights reserved.
//

import UIKit

class CityesController: UITableViewController{//,UITableViewDelegate,UITableViewDataSource {
    let weatherService = Service()
    var weathers = [WeatherClass]()
    let dateFormatter = DateFormatter()
    var cityesCoreDate = [
        "Moscow",
        "Novosibirsk",
        "Surgut",
        "Iskitim",
        "Tyumen",
        "Omsk",
        "Tomsk",
        "Krasnoyarsk",
        "London",
        "Paris"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let application =  UIApplication.shared.delegate as! AppDelegate
        
        let context = application.persistentContainer.viewContext
        var loadCities = [String]()
        do {
            let cities = try context.fetch(Weather.fetchRequest()) as! [Weather]
            if (cities.count != 0) {
                for city in cities {
                    if (city.name != nil) {
                        loadCities.append(city.name!)
                    }
                }
            } else {
                for city in cityesCoreDate {
                    let weater = Weather(context: context)
                    weater.name = city
                    do {
                        try context.save()
                    } catch {
                        print("oh no!")
                    }
                    loadCities.append(city)
                }
            }
        } catch {
            print("oh no!")
        }
        
        for city in loadCities {
            requestAndSaveCity(city: city, application: application)
        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func requestAndSaveCity(city: String, application: AppDelegate) {
        weatherService.loadWeather(city: city) { [weak self] weathers in
            var weather = WeatherClass()
            weather.cityName = city
            weather.startDate = weathers[0].date
            weather.endDate = weathers[weathers.count - 1].date
            weather.temp = self?.calculateTemp(list: weathers) ?? 0.0
            weather.weatherIcon = "03d"
            self?.weathers.append(weather)
            self?.tableView?.reloadData()
        }
    }
    
    func calculateTemp(list: [WeatherClass]) -> Double {
        var temp = 0.0
        for index in 0...list.count - 1 {
            temp += list[index].temp
        }
        return temp / Double(list.count)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityesCell
      //  let city = cityes[indexPath.row]
       // cell.name.text = city
        
        let weather = weathers[indexPath.row]
        var temp = NSString(format: "%.1f", weather.temp)
        cell.temperature.text = "\(temp) C"
        dateFormatter.dateFormat = "dd.MMM.yyyy HH.mm"
        let startDateD = Date(timeIntervalSince1970: TimeInterval(weather.startDate))
        let endDateD = Date(timeIntervalSince1970: TimeInterval(weather.endDate))
        let startDate = dateFormatter.string(from: startDateD)
        let endDate = dateFormatter.string(from: endDateD)
        cell.start.text = startDate
        cell.end.text = endDate
        cell.name.text = weather.cityName
        
        cell.imege.image = UIImage(named: weather.weatherIcon)

        return cell
    }
   
    @IBAction func addCity(segue: UIStoryboardSegue) {
     
        if segue.identifier == "addCity"{
            let allCityesController = segue.source as! AllCityesController
            if let indexPath = allCityesController.tableView.indexPathForSelectedRow {
                let city = allCityesController.cityes[indexPath.row]
                
                let application =  UIApplication.shared.delegate as! AppDelegate
                let context = application.persistentContainer.viewContext
                let weater = Weather(context: context)
                weater.name = city
                do {
                    try context.save()
                } catch {
                    print("oh no!")
                }
                requestAndSaveCity(city: city, application: application)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
     //тут удаление 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension CityesController: UITableViewDelegate {
    
//}

//extension CityesController: UITableViewDataSource{
    
//}
