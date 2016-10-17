//
//  ITunesAPIClient.swift
//  CallingITunesAPI
//
//  Created by Flatiron School on 10/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class ITunesAPIClient{

    class func gettingArtistInformationFromITunesAPI(query: String, Completion: (NSArray)-> ()){
    
    var jsonArray :[NSDictionary] = []
    //the array to store the json information
        
    var url = "https://itunes.apple.com/search?term=\(query)"
    //url to be used
        
    url = url.stringByReplacingOccurrencesOfString(" ", withString: "+")
    //remove all the spaces if inserted with pluses
        
    let nsURL = NSURL(string: url)
    //conversion of the url into a NSURL 
        
    guard let unwrappedNSURL = nsURL else {print("NSURL VERSION OF THE URL DID NOT UNWRAP"); return}
    //unwrap the NSURL version of the URL 
        
    let request = NSURLRequest(URL: unwrappedNSURL)
    //create the request
        
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
        
        guard let unwrappedData = data else {print("DATA DID NOT UNWRAP"); return}
        
        let responseDictionary = try? NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as! NSDictionary
        
        guard let unwrappedResponseDictionary = responseDictionary else {print("RESPONSE DICTIONARY DID NOT UNWRAP"); return}
        
        let resultsArray = unwrappedResponseDictionary["results"] as? NSArray
        
        guard let unwrappedResultsArray = resultsArray else {print("RESULTS ARRAY DID NOT UNWRAP"); return}
        
        for singleDictionary in unwrappedResultsArray {
        
            let castedDictionary = singleDictionary as? NSDictionary
            
            guard let unwrappedCastedDictionary = castedDictionary else {print("CASTED DICTIONARY DID NOT UNWRAP"); return}
            
            jsonArray.append(unwrappedCastedDictionary)
        }
        
        Completion(jsonArray)
        
        }
        task.resume()
    }
}
