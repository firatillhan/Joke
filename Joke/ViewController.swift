//
//  ViewController.swift
//  Joke
//
//  Created by Fırat İlhan on 14.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var jokeNoLabel: UILabel!
    @IBOutlet weak var joke1Label: UILabel!
    @IBOutlet weak var joke2Label: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        joke1Label.isHidden = true
        joke2Label.isHidden = true
        joke()
       
    }
    
    
    @IBAction func changeButton(_ sender: Any) {
        joke()
    }
    
    func joke() {
        
        let url = URL(string: "https://v2.jokeapi.dev/joke/Programming")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if  error != nil {
                print("Hata:\(String(describing: error))")
            } else {
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async{
                           // print(jsonResponse["joke"])
                            print("***")
                           
                                self.jokeNoLabel.text = "Joke"
                           
                                    
                            if let tek = jsonResponse["type"]{
                                if tek as! String == "single" {
                                   
                                    print("şaka tipi: Tek")
                                    
                                    self.joke1Label.isHidden = false
                                    self.joke2Label.isHidden = true
                                   
                                   
                                   
                                    if let saka = jsonResponse["joke"] {
                                        self.joke1Label.text = "\(saka)"
                                        print(saka)
                                    }
                                }
                            }
                            
                            if let cift = jsonResponse["type"] {
                                if cift as! String == "twopart" {
                                   
                                    print("şaka tipi: Çift")
                                   
                                    
                                   // self.joke2Label.isHidden = false
                                    
                                    
                                    
                                    if let setup = jsonResponse["setup"] {
                                        self.joke1Label.isHidden = false
                                        self.joke1Label.text = "* \(setup)"
                                    }
                                  
                                    if let delivery = jsonResponse["delivery"]{
                                        self.joke2Label.text = "* \(delivery)"
                                        self.joke2Label.isHidden = false
                                        
                                    }
                                }
                            }
                            
                            
                       
                            print("***")
                        }
                    } catch {
                        print("error")
                    }

                } else {
                    print("data nil")
                }
            }
            
        }
        task.resume()
    } //fonk bitiş
} //class bitiş
