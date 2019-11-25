//
//  GoogleMapsViewController.swift
//  MyTravel
//
//  Created by hale on 18.11.2019.
//  Copyright © 2019 hale. All rights reserved.
//

import Foundation
import UIKit

import FirebaseDatabase
import GoogleMaps

class GoogleMapsViewController: UIViewController {
 
    //Real time DB definition
      private var rootref: DatabaseReference!
      private var roothandle: DatabaseHandle!
    //
    // google maps definition
       private var gMap: GMSMapView!
       var mapZoom: Float = 10
       var mapUIView: UIView!
    //-----
    

    @IBAction func zoomIn(_ sender: UIButton) {
       
        mapZoom = mapZoom + 1
                        self.gMap.animate(toZoom: mapZoom)
    
    }
    @IBAction func zoomOutPressed(_ sender: UIButton) {
    
       mapZoom = mapZoom - 1
                       self.gMap.animate(toZoom: mapZoom)
    
    }
    @IBAction func addLocationPressed(_ sender: UIButton) {
            
        //Json dan zoom in zoom out okumayı dene.
        
         mapZoom = mapZoom + 1
                    self.gMap.animate(toZoom: mapZoom)
     
         print("add test location pressed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
         
              createDB()
              getCities()
              loadGoogleMaps()
              
       
          view.addSubview(mapUIView)  //Bu cünkü bir çeşit view. UIView'dan türüyor.
        
       
          mapUIView.frame =  CGRect(x: 10, y: 20, width: 300, height: 500)//
          mapUIView.center.x = self.view.center.x
        //mapUIView.center.y = self.view.center.y/2
          
    }
    
    /*Google Maps area*/
    
    private func loadGoogleMaps(){
        
         // Create a GMSCameraPosition that tells the map to display the
         // coordinate -33.86,151.20 at zoom level 6.
         let camera = GMSCameraPosition.camera(withLatitude: 41.02, longitude: 28.98, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
         mapView.backgroundColor = UIColor.gray
         gMap = mapView
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapUIView = gMap
          //view = gMap

    }
    private func loadGoogleMapsMarker(mapView:GMSMapView,city: City){
        
        let  marker = GMSMarker()
     
        marker.position = CLLocationCoordinate2D(latitude:city.latitude, longitude: city.longitude)
        marker.title = city.name
        marker.snippet = city.dateSnippet
        marker.map = mapView
      
    }
    /*End of Google Maps area*/
    
    /*Firebase area*/
    func createDB(){
          // db = Firestore.firestore()
           self.rootref = Database.database().reference()
           
           //print("db is created")
       
       }
    
    func getCountries(){
        
          // print ("select country test")
           
           roothandle = rootref.child("Countries").observe(.childAdded, with: { (data) in
           let countries : NSArray = (data.value as? NSArray)!
              
               for item  in countries {
                  
                   let countryName = item
                   //print(countryName)
               }
           
           })
       }
    
    
    func getContinents(){
        
        roothandle = rootref.child("Continent").observe(.childAdded,with: {(data) in
            let continents: NSArray = (data.value as? NSArray)!
            
            for item in continents{
                //print(item)
               
            }
        })
        
    }
    func getCities(){
        
        roothandle = rootref.child("Cities").observe(.childAdded,with:{(data)in
           let cities: NSArray = (data.value as? NSArray)!
           
            self.convertToCity(a: cities)
           
        })
      
        
    }
     
     private func convertToCity (a : NSArray){
         var countryId: String? = "0"
         var cityId: String? = "0"
         var cityName: String? = "No name"
         var cityLat:String? = "no lat"
         var cityLong: String? = "no long"
         var cityDate: String = "date"
         
        var sum = 0
         for number in 0..<a.count
        {
             
             var cityClass = City()
             sum = number
       
             let check = a[sum] as? Dictionary<String, Any>
             
             
             if let id = check!["Id"] as? String{
                 cityId = id
                 cityClass.id = Int(cityId!)!
                 //print(cityClass.id)
             }
    
             
             
             if let country_Id = check!["CountryId"] as? String{
                 countryId = country_Id
                 cityClass.countryId = Int(countryId!)!
                 //print(cityClass.countryId)
             }
             

             if let city_name = check!["Name"] as? String{
                 cityName = city_name
                 cityClass.name =  cityName!
                // print(cityClass.name)
             }
            
             
             if let lat = check!["Latitude"] as? String{
                 cityLat = lat
                cityClass.latitude = CLLocationDegrees(cityLat!)!
                // print(cityClass.latitude)
             }
             
             if let long = check!["Longitude"] as? String{
                 cityLong = long
                cityClass.longitude = CLLocationDegrees(cityLong!)!
                // print(cityClass.longitude)
             }
             
             if let cdate = check!["Year"] as? String{
                 cityDate = cdate
                 let shortenDate = String(cityDate.prefix(10))
                 cityClass.dateSnippet = shortenDate
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
                 dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
                 //according to date format your date string
                 guard let date = dateFormatter.date(from: shortenDate) else {
                     continue
                 }
                 cityClass.date = date
                // print(cityClass.date) //Convert String to Date
              }
           
                loadGoogleMapsMarker(mapView: gMap, city: cityClass)
         
          }/*end of for*/
         
       
     } /* convertToCity*/
    
    /*End of Firebase area*/
    
      @IBAction func ZoomInButtonPressed(_ sender: UIButton) {
             let nextZoom = mapZoom + 1
             gMap.animate(toZoom: nextZoom)
         }
    
} /*end of class*/

/*extension GoogleMapsViewController: GMSMapViewDelegate{
    func mapView(_mapView: GMSMapView, didChange position: GMSCameraPosition){
        mapZoom = gMap.camera.zoom
    }
    
}*/
