//
//  dogImageModel.swift
//  dogsFromAPI
//
//  Created by Никита Рыжкин on 28.11.2021.
//

import Foundation

struct DogImage: Decodable {
    let fileSizeBytes: Int
    let url: String
}
