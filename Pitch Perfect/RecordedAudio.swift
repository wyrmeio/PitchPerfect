//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Idris Jafer on 6/2/15.
//  Copyright (c) 2015 Wrme. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(path:NSURL,title:String){
        
        self.filePathUrl=path
        self.title=title
        
    }
}
