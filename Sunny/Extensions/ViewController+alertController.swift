//
//  ViewController+alertController.swift
//  Sunny
//
//  Created by Ivan Akulov on 25/02/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        
        var temp = ""
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            
            if cityName != "" {
                let path = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=c5d805597c6dac8b6f66c745a9bfce2c"
                let urlString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                guard let url = URL(string: urlString!) else { return }
                
                URLSession.shared.dataTask(with: url) { data, responce, error in
                    
                    guard let data = data else { return}
                    guard error == nil else { return }
                    print(data)
                    
                    do {
                        let weather = try JSONDecoder().decode(params.self, from: data)
                        print("\n\n\n\n")
                        print(weather)
                        temp = String(Int((weather.main?.temp)! - 273.15))
                        var feelsLikeTemp = Int((weather.main?.feels_like)! - 273.15)
                        print(temp)
                        DispatchQueue.main.sync {
                            self.temperatureLabel.text = String(temp)
                            self.feelsLikeTemperatureLabel.text = String(feelsLikeTemp)
                            self.cityLabel.text = cityName
                        }
                    
                    } catch let error {
                        print(error)
                    }
                }.resume()
                
                
                
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
        
    }
    
    
}


