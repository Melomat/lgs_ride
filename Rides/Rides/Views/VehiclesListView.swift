//
//  VehiclesListVIew.swift
//  Rides
//
//  Created by Matthias Mellouli on 2024-09-12.
//

import SwiftUI

struct VehiclesListView: View {
    
    @Namespace private var pickerAnimation
    
    @State private var viewModel = ViewModel()
    @State private var scrollOffset = 0.0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                list
            }
            .background(.appBackground)
            .navigationDestination(for: Vehicle.self, destination: { vehicle in
                VehicleDetailsView(vehicle: vehicle)
            })
        }
    }
}

// MARK: Subviews
extension VehiclesListView {
    
    @ViewBuilder
    private var header: some View {
        VStack {
            HStack {
                TextField("How Many Vehicles to Fetch?", text: $viewModel.sizeInput)
                    .padding(.leading)
                
                Button {
                    viewModel.fetchVehicles()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal, 4)
                        .toButtonShape()
                }
                .buttonStyle(BouncyButtonStyle())
            }
            .padding(5)
            .background(
                Color.appBackground
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.1), radius: 5.0, x: 0, y: 1)
            )
            
        }
        .padding()
        .zIndex(1)
        .background(
            Color.appBackground
                .ignoresSafeArea()
                .shadow(color: .black.opacity(headerShadowOpacity), radius: 10)
        )
    }
    
    @ViewBuilder
    private var list: some View {
        // We use a scrollView and LazyVStack instead of a List because we want to get the
        // Scroll offset which is not so simple with a List
        ScrollView  {
            
            filterCell
            
            LazyVStack {
                ForEach(viewModel.vehicles) { vehicle in
                    vehicleCell(vehicle: vehicle)
                }
            }
        }
        .listStyle(.plain)
        .animation(.smooth, value: viewModel.vehicles)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            self.scrollOffset = value
        }
    }
    
    @ViewBuilder
    private var filterCell: some View {
        VStack {
            Text("Filter By")
                .font(.footnote)
                .foregroundStyle(.appBlue)
            
            // We don't use the default picker to be able to customize the UI
            HStack {
                ForEach(ViewModel.SortingOption.allCases, id: \.self) { sortingOption in
                    Button {
                        withAnimation(.smooth(duration: 0.2)) {
                            viewModel.sortingOption = sortingOption
                        }
                    } label: {
                        Text(sortingOption.rawValue)
                            .foregroundStyle(viewModel.sortingOption == sortingOption ? .white : .appBlue)
                            .font(viewModel.sortingOption == sortingOption ? .footnote.bold() : .footnote)
                            .padding(12)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    .matchedGeometryEffect(id: sortingOption, in: pickerAnimation, isSource: viewModel.sortingOption == sortingOption)
                }
            }
            .background {
                Capsule()
                    .fill(.appBackground)
                    .shadow(color: .black.opacity(0.1), radius: 5.0, x: 0, y: 1)
                    
                Capsule()
                    .fill(Color.orange)
                    .padding(5)
                    .matchedGeometryEffect(id: viewModel.sortingOption, in: pickerAnimation, isSource: false)
                    .shadow(color: .black.opacity(0.15), radius: 3.0, x: 0, y: 1)

            }
        }
        .padding()
        .background(GeometryReader { geometry in
            // this will allow us to know the scroll position
            Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .scrollView).origin.y)
        })
    }
    
    private func vehicleCell(vehicle: Vehicle) -> some View {
        NavigationLink(value: vehicle) {
            VStack(alignment: .leading) {
                Text(vehicle.makeAndModel)
                    .font(.title3.bold())
                
                Text(vehicle.vin)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .background(.appBackground)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: Computed properties
extension VehiclesListView {
    private var headerShadowOpacity: CGFloat {
        let maxOffset: CGFloat = 50 // We want the shadow to be full when scrolled 50 pixels
        let maxOpacity: CGFloat = 0.2 // The max shadow opacity
        var opacity = -scrollOffset / maxOffset * maxOpacity
        opacity = min(maxOpacity, opacity)
        return opacity
    }
}

// MARK: PreferenceKey
extension VehiclesListView {
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat { 0 }
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }
}

#Preview {
    VehiclesListView()
}
