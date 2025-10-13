//
//  ContentView.swift
//  MapKit
//
//  Created by Cauê Carneiro on 13/10/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 37.3346, longitude: -122.0090), latitudinalMeters: 1300, longitudinalMeters: 1300 ))
    
    let locationManager = CLLocationManager()
    
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var isShowingLookAround = false
    @State private var route : MKRoute?
    
    var body: some View {
        Map(initialPosition: cameraPosition){
            Annotation("Apple Visitor Center", coordinate: .appleVisitorCenter, anchor: .center){
                Image(systemName: "laptopcomputer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(7)
                    .background(.pink.gradient,in:.circle)
                    .contextMenu{
                        Button("Open Look Around", systemImage: "binoculars"){
                            Task {
                                lookAroundScene = await getLookAroundScene(from: .appleVisitorCenter)
                                guard lookAroundScene != nil else { return }
                                isShowingLookAround =  true
                            }
                        }
                        Button("Get Diretions", systemImage: "arrow.turn.down.left"){
                            
                        }
                    }
            }
            
            UserAnnotation()
            
            if let route{
                MapPolyline(route)
                    .stroke(Color.pink, lineWidth: 4)
            }
            
        }
        .tint(.pink)
        .onAppear{
            locationManager.requestWhenInUseAuthorization()
        }
        .mapControls{
            MapUserLocationButton()
            MapCompass()
            MapPitchToggle()
            MapScaleView()
        }
        .mapStyle(.standard(elevation: .realistic))
        .lookAroundViewer(isPresented: $isShowingLookAround, initialScene: lookAroundScene)
        
    }
    func getLookAroundScene(from coordinate: CLLocationCoordinate2D) async -> MKLookAroundScene? {
        do{
            return try await MKLookAroundSceneRequest(coordinate: coordinate).scene
        }catch{
            print("Cannot retrieve Look Around Scene; \(error.localizedDescription)")
            return nil
        }
    }
    func getUserLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        do{
            let update = try await updates.first{$0.location?.coordinate != nil}
            return update?.location?.coordinate
        }catch{
            print("Cannot get user location")
            return nil
        }
    }
}

#Preview {
    ContentView()
}


extension CLLocationCoordinate2D {
    static let appleVisitorCenter = CLLocationCoordinate2D(latitude: 37.332753, longitude: -122.005372)
}
