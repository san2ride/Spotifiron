//
//  ViewController.swift
//  SpotifySwiftApp
//
//  Created by Taylor Frost on 6/17/16.
//  Copyright © 2016 Taylor Frost. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ArtistTextField: UITextField!
    @IBOutlet weak var ArtistTableView: UITableView!
    
    let session = NSURLSession.sharedSession()
    var artistsArray = [Artist]()
    var currentArtist = [Artist]()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print("textFieldShouldReturn")
        
        if let theString = textField.text {
            
            print(theString)
            
            self.fetchArtists(theString)
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func fetchArtists(query: String) {
        
        print("The query string is \(query)")
        
        let artistsURLString = "https://api.spotify.com/v1/search?q=\(query)&type=artist"
        
        if let url = NSURL(string: artistsURLString) {
            
            let task = self.session.dataTaskWithURL(url, completionHandler: {
                
                (data, response, error) in
                
                
                if error != nil {
                    print("An error occurred")
                    return
                }
                
                do {
                    
                    if let data = data {
                        if let dict = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary {
                            
                            if let artistsDict = dict["artists"] as? JSONDictionary {
                                
                                if let itemsArray = artistsDict["items"] as? JSONArray {
                                    
                                    
                                    for itemDict in itemsArray {
                                        
                                        let currentArtist = Artist()
                                        
                                        if let name = itemDict["name"] as? String {
                                            print(name)
                                            currentArtist.name = name
                                            
                                        } else {
                                            print("I could not parse the name")
                                        }
                                        
                                        if let artistID = itemDict["id"] as? String {
                                            print(artistID)
                                            currentArtist.artistID = artistID
                                        } else {
                                            print("I couldnt parse the artist id")
                                        }
                                        
                                        if let href = itemDict["href"] as? String {
                                            print(href)
                                            currentArtist.href = href
                                        } else {
                                            print("I could not parse the href")
                                        }
                                        
                                        if let popularity = itemDict["popularity"] as? Int {
                                            print(popularity)
                                            currentArtist.popularity = popularity
                                        } else {
                                            print("I could not parse the popularity")
                                        }
                                        
                                        if let type = itemDict["type"] as? String {
                                            print(type)
                                            currentArtist.type = type
                                        } else {
                                            print("I could not parse the item")
                                        }
                                        
                                        self.artistsArray.append(currentArtist)
                                    }
                                    
                                    print(self.artistsArray.count)
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        self.ArtistTableView.reloadData()
                                    })
                                    
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
                    
                }
            })
            
            task.resume()
            
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.artistsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let artist = self.artistsArray[indexPath.row]
        
        cell.textLabel?.text = artist.name
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("AlbumSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AlbumSegue" {
            
            if let destinationVC = segue.destinationViewController as? AlbumViewController {
                destinationVC.theArtist = currentArtist
            }
    
    }
    }


}

