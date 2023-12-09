//
//  Utils.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import UIKit

class Utils {
    
    static let screenSize: CGRect = UIScreen.main.bounds
    
    class func movieDateString(from date: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        if let movieDate = formatter.date(from: date){
            formatter.dateFormat = "yyyy"
            return formatter.string(from: movieDate)
        }
        return StringConstants.Utils.unknownDate
    }
    
    class func durationString(time: Int?) -> String{
        guard let duration = time else{
            return StringConstants.Utils.unknownTime
        }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        
        return formatter.string(from: TimeInterval(duration) * 60) ?? StringConstants.Utils.unknownTime
    }
}
