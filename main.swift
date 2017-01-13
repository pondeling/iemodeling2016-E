//
//  main.swift
//  modeling_vector_transform
//
//  Created by ゆうき はませ on 2017/01/13.
//  Copyright © 2017年 hamase. All rights reserved.
//

import Foundation
var presX : Float = 1;//get from accel code
var presY : Float = 1;//get from accel code
var presZ : Float = 0;//get from accel code
var bX    : Float = 0;//get from accel code
var bY    : Float = 0;//get from accel code
var bZ    : Float = 1;//get from accel code

var basisAbs : Float = 1;//must be calculated by "BasisAbsXYZ"


func findPresentGravitationalVector(presentX:Float,presentY:Float,presentZ:Float,basisX:Float,basisY:Float,basisZ:Float) ->(Float){
    let presAbs = PresentAbsXYZ(presentX: presX, presentY: presY, presentZ: presZ)//present accel abs
    let presSubToBasis = presentSubToBasis(presentX: presentX, presentY: presentY, presentZ: presentZ, basisX: basisX, basisY: basisY, basisZ: basisZ)//present substruction to basis
    let gravitationalVector = (presAbs*presAbs-presSubToBasis*presSubToBasis+basisAbs*basisAbs)/(2*basisAbs)//ここに関しては計算した
    return gravitationalVector
}

func findPresentHorizonalVector(presentX:Float,presentY:Float,presentZ:Float,basisX:Float,basisY:Float,basisZ:Float) ->(Float){
    let presAbs = PresentAbsXYZ(presentX: presX, presentY: presY, presentZ: presZ)
    let gravVec = findPresentGravitationalVector(presentX: presX, presentY: presY, presentZ: presZ, basisX: bX, basisY: bY, basisZ: bZ)
    let horizonalVector = sqrtf(presAbs*presAbs-gravVec*gravVec)
    return horizonalVector
}

func PresentAbsXYZ(presentX:Float,presentY:Float,presentZ:Float) -> (Float){
    var abs : Float = 0
    abs = presentX*presentX+presentY*presentY+presentZ*presentZ
    abs = sqrtf(abs)
    return abs
}

func BasisAbsXYZ(basisX:Float,basisY:Float,basisZ:Float) -> (Float){
    var abs : Float = 0
    abs = basisX*basisX+basisY*basisY+basisZ*basisZ
    abs = sqrtf(abs)
    return abs
}

func presentSubToBasis(presentX:Float,presentY:Float,presentZ:Float,basisX:Float,basisY:Float,basisZ:Float) -> (Float){
    var abs : Float = 0;
    let subX = presentX-basisX;
    let subY = presentY-basisY;
    let subZ = presentZ-basisZ;
    abs = (subX*subX)+(subY*subY)+(subZ*subZ)
    abs = sqrtf(abs)
    return abs
}

//以下、例。

basisAbs = BasisAbsXYZ(basisX: bX, basisY: bY, basisZ: bZ)

print("PresentSubIs \(presentSubToBasis(presentX: presX, presentY: presY, presentZ: presZ, basisX: bX, basisY: bY, basisZ: bZ))")
print("PresentAbsIs \(PresentAbsXYZ(presentX: presX, presentY: presY, presentZ: presZ))")
print("BasisAbsIs \(BasisAbsXYZ(basisX: bX, basisY: bY, basisZ: bZ))")
print("GravitationalVectorIs \(findPresentGravitationalVector(presentX: presX, presentY: presY, presentZ: presZ, basisX: bX, basisY: bY, basisZ: bZ))")
print("HorizonalVectorIs \(findPresentHorizonalVector(presentX: presX, presentY: presY, presentZ: presZ, basisX: bX, basisY: bY, basisZ: bZ))")
