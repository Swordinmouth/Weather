//
//  AllCititesController.swift
//  Weather
//
//  Created by Valery on 05.08.2021.
//

import UIKit

class AllCititesController: UITableViewController {

    var cities = [ "Moscow",
                   "Krasnoyarsk",
                   "London",
                   "Paris",
                   "Мурманск",
                   "Нижний Новгород",
                   "Владимир",
                   "Ростов",
                   "Томск",
                   "Владивосток",
                   "Курск",
                   "Абакан",
                   "Азов",
                   "Александров",
                   "Алексин"

    ]


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? AllCitiesCell else { fatalError() }
        let city = cities[indexPath.row]

        cell.cityName.text = city

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
