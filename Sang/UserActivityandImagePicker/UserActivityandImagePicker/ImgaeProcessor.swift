//
//  ImgaeProcessor.swift
//  UserActivityandImagePicker
//
//  Created by tranquocsang on 4/7/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit


class Filter{
    var rgba = [UInt8](count:5, repeatedValue: 0)
}


let redFilter: Filter = Filter()
let greenFilter: Filter = Filter()
let blueFilter: Filter = Filter()
let alphaFilter: Filter = Filter()
let yellowFilter: Filter = Filter()



class ImageProcessor{
    
    var filterSequenceList: [String] = []
    
    //This Dictionary is later used to accept strings to set the filter the processor will apply.
    
    var filtersAvailable: [String: Filter] = [
        "redFilter": redFilter,
        "greenFilter": greenFilter,
        "blueFilter": blueFilter,
        "yellowFilter": yellowFilter,
        "alphaFilter": alphaFilter,
    ]
    
    func InitFilter(){
        redFilter.rgba[0] = 45
        greenFilter.rgba[1] = 45
        blueFilter.rgba[2] = 45
        alphaFilter.rgba[3] = 50
        yellowFilter.rgba[1] = 50
        yellowFilter.rgba[2] = 50

    }
    
    func addFilterToSequence(filterName: String){
        InitFilter()
        filterSequenceList.append(filterName)
    }
    
    func appyFilters(image: UIImage) -> UIImage{
        
        var filters: [Filter] = []
        
        // A list if filters gets populated according to the array of strings entered.
        for name in filterSequenceList{
            filters.append(filtersAvailable[name]!)
        }
        
        let rgbaImage = RGBAImage(image: image)!
        
        // Loop through each pixel
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                // Loop through each filter
                for filter in filters{
                    for value in 0...4 {
                        
                        if(filter.rgba[value] != 0 ){
                            
                            switch value{
                                
                            case 0:
                                
                                pixel.red = filter.rgba[value]
                                rgbaImage.pixels[index] = pixel
                                
                            case 1:
                                
                                pixel.green = filter.rgba[value]
                                rgbaImage.pixels[index] = pixel
                                
                            case 2:
                                
                                pixel.blue = filter.rgba[value]
                                rgbaImage.pixels[index] = pixel
                                
                            case 3:
                                
                                pixel.alpha = filter.rgba[value]
                                rgbaImage.pixels[index] = pixel
                                
                            default:
                                
                                print("Nothing to change")
                                
                            }
                        }
                    }
                }
            }
        }
        let newImage = rgbaImage.toUIImage()!
        return newImage
    }
}