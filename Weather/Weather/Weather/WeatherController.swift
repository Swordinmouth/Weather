//
//  WeatherController.swift
//  Weather
//
//  Created by Valery on 08.08.2021.
//

import UIKit

class WeatherController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var weather = [
        WeatherData(temperature: 30, humidity: 0.1),
        WeatherData(temperature: 32, humidity: 0.2),
        WeatherData(temperature: 12, humidity: 0.3),
        WeatherData(temperature: 25, humidity: 0.5),
        WeatherData(temperature: 30, humidity: 0.9),
        WeatherData(temperature: 30, humidity: 0.1),
        WeatherData(temperature: 32, humidity: 0.2),
        WeatherData(temperature: 12, humidity: 0.3),
        WeatherData(temperature: 25, humidity: 0.5),
        WeatherData(temperature: 30, humidity: 0.9),
        WeatherData(temperature: 30, humidity: 0.1),
        WeatherData(temperature: 32, humidity: 0.2),
        WeatherData(temperature: 12, humidity: 0.3),
        WeatherData(temperature: 25, humidity: 0.5),
        WeatherData(temperature: 30, humidity: 0.9)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {

            layout.itemSize = CGSize(width: 200, height: 200)
        }
    }
    @IBAction func selectedDayUpdated(_ sender: Any) {
        weather = (0...20).map{ _ in
            WeatherData(temperature: Int.random(in: -10...10), humidity: Float.random(in: 0.1...0.9))
        }
        collectionView.reloadData()
    }
}

extension WeatherController: UICollectionViewDataSource {


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weather.count
    }

    func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { return UICollectionViewCell() }


        let data = weather[indexPath.row]

        cell.weather.text = String(data.temperature)
        cell.time.text = String(data.humidity)
        
        return cell
    }
}
