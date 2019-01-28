//
//  VStack.swift
//  Calculator
//
//  Created by Lucien Dagher Hayeck on 10/16/15.
//  Copyright (c) 2015 Lucien Dagher Hayeck. All rights reserved.
//

import Foundation

class VStack {
    
    var v: [Double] = []
    
    func push(value:Double){
        v.append(value)
    }
    
    func top()->Double?{
        if v.count == 0{
            return nil
        } else {
            return v[v.count-1]
        }
    }
    
    func pop(){
        v.removeLast()
    }
    
    func isEmpty()->Bool{
        if v.count == 0{
            return true
        } else{
            return false
        }
    }
    
    
}

class OpStack{
    
    var v: [String] = []
    
    func push(value:String){
        v.append(value)
    }
    
    func top()->String?{
        if v.count == 0{
            return nil
        } else {
            return v[v.count-1]
        }
    }
    
    func pop(){
        v.removeLast()
    }
    
    func isEmpty()->Bool{
        if v.count == 0{
            return true
        } else{
            return false
        }
    }


   
}

