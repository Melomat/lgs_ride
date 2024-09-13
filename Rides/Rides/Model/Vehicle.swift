//
//  Vehicle.swift
//  Rides
//
//  Created by Matthias Mellouli on 2024-09-12.
//

import Foundation

struct Vehicle: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let uid: UUID
    let vin: String
    let makeAndModel: String
    let color: String
    let transmission: String // This could be an enum
    let driveType: String // This could be an enum
    let fuelType: String // This could be an enum
    let carType: String // This could be an enum
    let carOptions: [String]
    let specs: [String]
    let doors: Int
    let mileage: Int
    let kilometrage: Int
    let licensePlate: String

    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case vin
        case makeAndModel = "make_and_model"
        case color
        case transmission
        case driveType = "drive_type"
        case fuelType = "fuel_type"
        case carType = "car_type"
        case carOptions = "car_options"
        case specs
        case doors
        case mileage
        case kilometrage
        case licensePlate = "license_plate"
    }
}
