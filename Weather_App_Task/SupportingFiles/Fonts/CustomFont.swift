//  CustomFont.swift
//  Weather_App_Task
//  Created by Nadeen Dames on 04/06/2023.

import Foundation
import SwiftUI
class CustomFont{
    public static var RegularFont : Font{
        return Font.custom("Cairo-Regular", size: 12)
    }
    public static var LargeRegularFont : Font{
        return Font.custom("Cairo-Regular", size: 18)
    }
    
    public static var MeduimRegularFont : Font{
        return Font.custom("Cairo-Regular", size: 16)
    }
    public static var NormalRegularFont : Font{
        return Font.custom("Cairo-Regular", size: 14)
    }
    public static var ExtraLarageRegularFont : Font{
        return Font.custom("Cairo-Regular", size: 24)
    }
    public static var BoldFont : Font{
        return Font.custom("Cairo-Bold", size: 14)
    }
    public static var LargeBoldFont : Font{
        return Font.custom("Cairo-Bold", size: 18)
    }
    public static var MeduimFont : Font{
        return Font.custom("Cairo-Medium", size: 14)
    }
    public static var LargeMeduimFont : Font{
        return Font.custom("Cairo-Medium", size: 18)
    }
    
    public static var ExtraBoldFont : Font{
        return Font.custom("Cairo-Bold", size: 35)
    }
    
    
    
}
