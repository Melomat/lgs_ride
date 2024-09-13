//
//  VehicleDetailsView.swift
//  Rides
//
//  Created by Matthias Mellouli on 2024-09-13.
//

import SwiftUI

struct VehicleDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let vehicle: Vehicle
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 10)
    ]
    
    
    var body: some View {
        
        VStack(spacing: -35) {
            ZStack(alignment: .topLeading) {
                Image(.carDetails)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .ignoresSafeArea()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 44, height: 44)
                        .background(.appBackground)
                        .cornerRadius(15)
                        .padding(.leading, 20)
                }
                .buttonStyle(BouncyButtonStyle())
            }
            .frame(height: 300)
            .background(.red)
            
            VStack {
                LazyVGrid(columns: columns) {
                    vehicleCell(text: vehicle.makeAndModel, imageName: "car.side")
                    vehicleCell(text: vehicle.vin, imageName: "qrcode")
                    vehicleCell(text: vehicle.color, imageName: "paintpalette")
                    vehicleCell(text: vehicle.carType, imageName: "pencil.and.list.clipboard.rtl")
                }
                
                Spacer()
            }
            .padding(.top, 30)
            .padding(.horizontal, 20)
            .background(
                Color.appBackground
                    .cornerRadius(30)
                    .ignoresSafeArea()
            )
        }
        .background(.appBackground)
        .navigationBarBackButtonHidden(true)
        
    }
}

// MARK: SubViews
extension VehicleDetailsView {
    
    private func vehicleCell(text: String, imageName: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                Image(systemName: imageName)
                    .foregroundStyle(.appBlue)
            }
            .frame(width: 40, height: 40)
            .background(Circle().fill(.appGray))
            .shadow(color: .black.opacity(0.1), radius: 5.0, x: 0, y: 1)
                
            Text(text)
                .foregroundStyle(.appBlue)
                .font(.footnote)
            
        }
        .frame(height: 120)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.appBackground)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5.0, x: 0, y: 1)
        .padding(.bottom, 20)
    }
}

#Preview {
    let vehicle = Vehicle(
        id: 6059,
        uid: .init(uuidString: "237ce4f7-9e76-4b73-82e5-847fd931a0d3")!,
        vin: "747P1X0M0B2908398",
        makeAndModel: "Dodge Challenger",
        color: "Grey",
        transmission: "Automatic",
        driveType: "4x4/4-wheel drive",
        fuelType: "Ethanol",
        carType: "Coupe",
        carOptions: [
            "Power Windows",
            "Bucket Seats",
            "Cassette Player",
            "A/C: Rear",
            "Moonroof/Sunroof",
            "Power Windows",
            "Bucket Seats"
        ],
        specs: [
            "Variable intermittent windshield wipers w/mist function",
            "Steel side-door impact beams",
            "Chrome bodyside molding",
            "Body color fascias w/bright insert",
            "Air conditioning w/in-cabin microfilter",
            "\"Flipper\" liftgate glass"
        ],
        doors: 4,
        mileage: 61339,
        kilometrage: 50512,
        licensePlate: "ULB-7340"
    )
    return VehicleDetailsView(vehicle: vehicle)
}
