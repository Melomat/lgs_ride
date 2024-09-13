//
//  VehiclesListView + ViewModel.swift
//  Rides
//
//  Created by Matthias Mellouli on 2024-09-12.
//

import Foundation
import Observation

extension VehiclesListView {
    
    @Observable 
    class ViewModel {
        var vehicles: [Vehicle] = []
        var sizeInput: String = ""
        var sortingOption = SortingOption.vin {
            didSet {
                vehicles = vehicles.sorted(using: KeyPathComparator(self.sortingOption.associatedVehicleKeyPath))
            }
        }
    }
}

// MARK: Data Fetching
extension VehiclesListView.ViewModel {
    
    private var requestSizeInput: String {
        //We Want to make sure that data can be fetched even with an empty input
        sizeInput.isEmpty ? "1" : sizeInput
    }
    
    func fetchVehicles() {
        guard let url = URL(string: "https://random-data-api.com/api/vehicle/random_vehicle?size=\(requestSizeInput)") else { return }
        
        // For a bigger App with multiple requests and types, I like to go with a protocol base
        // net working layer, and I usually use Alamofire
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            //This should never happen since we are in the root view of the app but you never know
            guard let self else { return }
            
            if let data = data {
                if let decodedVehicles = try? JSONDecoder().decode([Vehicle].self, from: data) {
                    DispatchQueue.main.async {
                        // We sort the vehicles based on the selected sorting option
                        self.vehicles = decodedVehicles.sorted(using: KeyPathComparator(self.sortingOption.associatedVehicleKeyPath))
                    }
                } else {
                    print(error)
                }
            }
        }.resume()
    }
}

//MARK: Helpers
extension VehiclesListView.ViewModel {
}

// MARK: Sorting Option
extension VehiclesListView.ViewModel {
    enum SortingOption: String, CaseIterable, Identifiable {
        case vin = "VIN"
        case carType = "Car Type"
        
        var id: Self { self }
        
        // The associated Vehicle Keypath will be used for sorting the vehicles
        var associatedVehicleKeyPath: KeyPath<Vehicle, String> {
            switch self {
            case .vin: return \.vin
            case .carType: return \.carType
            }
        }
    }
}
