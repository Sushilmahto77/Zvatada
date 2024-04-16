//
//  MapAddressUIView.swift
//  Zvatada
//
//  Created by Sushil Mahto on 28/11/22.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine
import MapKit
class LocationViewModel: NSObject, ObservableObject{
  
  @Published var userLatitude: Double = 0
  @Published var userLongitude: Double = 0
  @Published var userTown: String = ""
  
  private let locationManager = CLLocationManager()
  
  override init() {
    super.init()
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
}

extension LocationViewModel: CLLocationManagerDelegate {
    
    struct ReversedGeoLocation {
        let name: String            // eg. Apple Inc.
        let streetName: String      // eg. Infinite Loop
        let streetNumber: String    // eg. 1
        let city: String            // eg. Cupertino
        let state: String           // eg. CA
        let zipCode: String         // eg. 95014
        let country: String         // eg. United States
        let isoCountryCode: String  // eg. US

        var formattedAddress: String {
            return """
            \(name) \(streetNumber) \(streetName), \(city), \(state) \(zipCode) \(country)
            """
        }

        // Handle optionals as needed
        init(with placemark: CLPlacemark) {
            self.name           = placemark.name ?? ""
            self.streetName     = placemark.thoroughfare ?? ""
            self.streetNumber   = placemark.subThoroughfare ?? ""
            self.city           = placemark.locality ?? ""
            self.state          = placemark.administrativeArea ?? ""
            self.zipCode        = placemark.postalCode ?? ""
            self.country        = placemark.country ?? ""
            self.isoCountryCode = placemark.isoCountryCode ?? ""
        }
    }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    userLatitude = location.coordinate.latitude
    userLongitude = location.coordinate.longitude
    getTown(lat: CLLocationDegrees.init(userLatitude), long: CLLocationDegrees.init(userLongitude))

    print(location)
  }
    
    func getTown(lat: CLLocationDegrees, long: CLLocationDegrees) -> Void
    {
        let location = CLLocation.init(latitude: lat, longitude: long)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in

            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }

            let reversedGeoLocation = ReversedGeoLocation(with: placemark)
            print(reversedGeoLocation.name)
            DispatchQueue.main.async {
                self.userTown = reversedGeoLocation.formattedAddress
                
            }
        }

    }
}


struct MapAddressUIView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var locationViewModel = LocationViewModel()
   // @StateObject var locationViewModel = LocationViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var MapAddressget:String = ""
    @State var AddressPageisPresent = false
    var body: some View {
       
            VStack{
                HStack{
                    Text("Map")
                        .font(.system(size: 30).bold())
                        .padding(.leading,12)
                        .padding(.top,12)
                    Spacer()
                    Button(action: {
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                       Image(systemName: "xmark")
                            .font(.system(size: 30))
                            .padding(.trailing,20)
                            .padding(.top,12)
                            .foregroundColor(Color.red)
                    }
                }
                   
                    ZStack{
                       
                        Map(coordinateRegion: $region).overlay(
                            VStack(alignment: .trailing){
                                Spacer()
                                Button(action: {
                                    AddressPageisPresent = true
                                    //presentationMode.wrappedValue.dismiss()
                                    MapAddressget = locationViewModel.userTown
                                }, label: {
                                    HStack{
                                        Text("Get Location")
                                            .font(.system(size: 20).bold())
                                            //.frame(width: 330)
                                            //.multilineTextAlignment(.leading)
                                            //.background(Color.red)
                                        
                                      // Spacer()
                                        
                                    }.frame(width: UIScreen.main.bounds.width-40,height: 58)
                                        .background(Color.blue)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(12)
                                    .padding(.bottom,68)
                                }).fullScreenCover(isPresented: $AddressPageisPresent,onDismiss: {
                                    presentationMode.wrappedValue.dismiss()
                                }){
                                    EditAddressPageUIView(MapAddress: $MapAddressget, tempAddressID: "")
                                }
                               
                            }
                        )
                        
                    }
                
            }.edgesIgnoringSafeArea(.all)
        
    }
}

struct MapAddressUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapAddressUIView()
    }
}






