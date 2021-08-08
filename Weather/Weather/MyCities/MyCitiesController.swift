//
//  MyCitiesController.swift
//  Weather
//
//  Created by Valery on 05.08.2021.
//

import UIKit

class MyCitiesController: UITableViewController {

    var cities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addCity(segue: UIStoryboardSegue) {
        //Проверяем идентификатор, чтобы убедиться, что это нужный переход
        if segue.identifier == "addCity" {
            //Получаем ссылку на контроллер, с которого осуществлен переход
            guard let allCitiesController = segue.source as? AllCititesController else { return }

            //Получаем индекс выделенной ячейки
            if let indexPath = allCitiesController.tableView.indexPathForSelectedRow {
                //Получаем город по индексу
                let city = allCitiesController.cities[indexPath.row]
                //Проверяем, что такого города нет в списке
                if !cities.contains(city) {
                //Добавляем город в список выделенных городов
                cities.append(city)
                //Обновляем таблицу
                tableView.reloadData()
                }
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCitiesCell", for: indexPath) as? MyCitiesCell else { return UITableViewCell() }
        let city = cities[indexPath.row]

        cell.myCityLabel.text = city

        return cell
    }



    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Если была нажата кнопка удалить
        if editingStyle == .delete {
            //Удаляем город из массива
            cities.remove(at: indexPath.row)
            //И удаляем строку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

    }


}
