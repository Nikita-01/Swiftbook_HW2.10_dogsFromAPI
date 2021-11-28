//
//  ViewController.swift
//  dogsFromAPI
//
//  Created by Никита Рыжкин on 28.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var url = "https://random.dog/woof.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    @IBAction func nextDogButtonPressed() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let dogImage = try JSONDecoder().decode(DogImage.self, from: data)
                guard let imageUrl = URL(string: dogImage.url) else { return }
                
                URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                    guard let data = data else {
                        print(error?.localizedDescription ?? "No error discription")
                        return
                    }
                    
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        self.activityIndicator.stopAnimating()
                    }
                    
                }.resume()
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}

