//
//  CSVScanner.swift
//  Elementary
//
//  Created by Rick on 15/04/2018.
//  Copyright © 2018 Rick Cooper. All rights reserved.
//

import Foundation

class CSVScanner {
    
    class func debug(string:String){
        print("CSVScanner: \(string)")
    }
    
    class func runFunctionOnRowsFromFile(theColumnNames:Array<String>, withFileName theFileName:String, withFunction theFunction:(Dictionary<String, String>)->()) {
        if let strBundle = Bundle.main.path(forResource: theFileName, ofType: "csv") {
            
            let encodingError:NSError? = nil
            
            if let fileObject = try? String(contentsOfFile: strBundle, encoding: String.Encoding.utf8){
                
                var fileObjectCleaned = fileObject.replacingOccurrences(of: "\r", with: "\n")
                
                fileObjectCleaned = (fileObjectCleaned as NSString).replacingOccurrences(of: "\n\n", with: "\n")
                
                let objectArray = fileObjectCleaned.components(separatedBy:"\n")
                
                for anObjectRow in objectArray {
                    
                    let objectColumns = anObjectRow.components(separatedBy:",")
                    
                    var aDictionaryEntry = Dictionary<String, String>()
                    
                    var columnIndex = 0
                    
                    for anObjectColumn in objectColumns {
                        
                        aDictionaryEntry[theColumnNames[columnIndex]] = anObjectColumn.replacingOccurrences(of: "\"", with: "", options: String.CompareOptions.caseInsensitive, range: nil)
                        
                        columnIndex += 1
                    }
                    
                    if aDictionaryEntry.count > 1 {
                        theFunction(aDictionaryEntry)
                    } else {
                        
                        CSVScanner.debug(string: "No data extracted from row: \(anObjectRow) -> \(objectColumns)")
                    }
                }
            } else {
                CSVScanner.debug(string: "Unable to load csv file from path: \(strBundle)")
                
                if let errorString = encodingError?.description {
                    
                    CSVScanner.debug(string: "Received encoding error: \(errorString)")
                }
            }
        } else {
            CSVScanner.debug(string: "Unable to get path to csv file: \(theFileName).csv")
        }
    }
}

//var myCSVContents = Array<Dictionary<String, String>>()
//CSVScanner.runFunctionOnRowsFromFile(theColumnNames: ["year", "color", "country","food"], withFileName: "sample", withFunction: {
//    
//    (aRow:Dictionary<string, string="">) in
//    
//    myCSVContents.append(aRow)
//    
//    textYear += aRow["year"]! + " = " + aRow["color"]! + "\n" //just a text
//    textCountry += aRow["year"]! + " = " + aRow["country"]! + "\n";
//    print(textYear)
//    
//})
