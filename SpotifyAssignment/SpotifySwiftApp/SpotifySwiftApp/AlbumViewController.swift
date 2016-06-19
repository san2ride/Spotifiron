//
//  AlbumViewController.swift
//  ArtistAPIApp
//
//  Created by don't touch me on 6/17/16.
//  Copyright © 2016 trvl, LLC. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDataSource,  UITableViewDelegate {
    
    @IBOutlet weak var albumView: UITableView!
    
    let session = NSURLSession.sharedSession()
    var albumsArray = [Album]()
    var theArtist = [Artist]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear (animated:Bool){
        super.viewWillAppear (animated)
        
        self.fetchAlbum(theArtist.artistID)
        
    }

    //MARK: Parsing the JSON
    
    func fetchAlbum(query: String)
    {
        
        let artistsURLString = "https://api.spotify.com/v1/artists/%7Bid%7D/albums"
        
        if let url = NSURL(string: artistsURLString)
        {
            
            let task = self.session.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) in
                
                // STEP 1 CHECK FOR ERROR
                if error != nil {
                    print("An error occurred")
                    return
                }
                
                // STEP 2
                
                do {
                    
                    if let data = data {
                        if let dict = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary {
                            
                            
                            if let albumDict = dict["albums"] as? JSONDictionary {
                                
                                if let itemsArray = albumDict["items"] as? JSONArray {
                                    
                                    
                                    for itemDict in itemsArray {
                                        
                                        //print("\n\nThe itemDict == \(itemDict)\n\n")
                                        
                                        let theAlbum = Album()
                                        
                                        if let href = itemDict["href"] as? String {
                                            print(href)
                                            theAlbum.href = href
                                        } else {
                                            print("I could not parse the href")
                                        }
                                        
                                        if let artistID = itemDict["id"] as? String {
                                            print(artistID)
                                            theAlbum.artistID = artistID
                                        } else {
                                            print("I couldnt parse the artist id")
                                        }
                                        
                                        if let name = itemDict["name"] as? String {
                                            print(name)
                                            
                                            theAlbum.name = name
                                        } else {
                                            print("I could not parse the name")
                                        }
                                        
                                        if let type = itemDict["type"] as? String {
                                            print(type)
                                            theAlbum.type = type
                                        } else {
                                            print("I couldnt parse the type")
                                        }
                                        
                                        if let type = itemDict["type"] as? String {
                                            print(type)
                                            theAlbum.type = type
                                        } else {
                                            print("I couldnt parse the type")
                                        }
                                        
                                        self.albumsArray.append(theAlbum)
                                        
                                        //                                            self.tableView.reloadData()
                                    }
                                    
                                    
                                } else {
                                    print("Could not parse items")
                                }
                                
                                
                            } else {
                                print("I couldnt parse the artists")
                            }
                            
                        } else {
                            print("I couldnt get the JSONDictionary")
                        }
                    }
                    
                    
                } catch {
                    // error happened
                }
                
                
                
                
            })
            task.resume()
            
        }
        
        
    }
    
    //MARK: Data Source Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath)
        
        let album = self.albumsArray[indexPath.row]
        
        cell.textLabel?.text = album.name
        
        return cell
    }
    
}







