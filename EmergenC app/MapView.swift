//
//  MapView.swift
//  EmergenC app
//
//  Created by Francesca Trinchese on 12/12/24.
//
import SwiftUI
import MapKit

//struct MapView: View {
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Example: San Francisco
//        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    )
//
//    var body: some View {
//        Map(coordinateRegion: $region, annotationItems: [PinAnnotation.example]) { pin in
//            MapAnnotation(coordinate: pin.coordinate) {
//                VStack {
//                    Image(systemName: "mappin.circle.fill")
//                        .font(.largeTitle)
//                        .foregroundColor(.red)
//                    Text(pin.title)
//                        .font(.caption)
//                        .padding(5)
//                        .background(Color.white)
//                        .cornerRadius(5)
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct PinAnnotation: Identifiable {
//    let id = UUID()
//    let coordinate: CLLocationCoordinate2D
//    let title: String
//
//    // Example pin
//    static var example = PinAnnotation(
//        coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        title: "Hospital"
//    )
//}

struct MapView: View {

    @State private var position: MapCameraPosition =
        .automatic
    @State private var Hospital: [MKMapItem] = []
    @State private var selection: MapSelection<MKMapItem>?

    var body: some View {
        Map (position: $position, selection: $selection) {
            ForEach(Hospital, id: \.self) {hospital in
                Marker(item: hospital)
                    .tag(MapSelection(hospital))
            }
            .mapItemDetailSelectionAccessory(.callout)
        }

        .task {
            guard let naples = await findCity() else {
                return
            }
            Hospital = await findHospital( in: naples)
        }
        .mapFeatureSelectionAccessory(.callout)

    }


}
private func findCity() async -> MKMapItem? {
let request = MKLocalSearch.Request()
request.naturalLanguageQuery = "naples"
request.addressFilter = MKAddressFilter(
including: .locality)
let search = MKLocalSearch (request: request)
let response = try? await search.start ()
return response?.mapItems.first
}

private func findHospital( in city: MKMapItem
                       ) async -> [MKMapItem] {
let request = MKLocalSearch.Request ()
request.naturalLanguageQuery = "hospital"
let downtown = MKCoordinateRegion (
center: city.placemark.coordinate,
span: .init(
latitudeDelta: 0.08,
longitudeDelta: 0.08
)
)
request.region = downtown
request.regionPriority = .required
let search = MKLocalSearch(request: request)
let response = try? await search.start ()
return response? .mapItems ?? []
}

#Preview {
    MapView()
}
