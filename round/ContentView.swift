
//  ContentView.swift
//  round
//
//  Created by 陳昱豪 on 2020/4/26.
//  Copyright © 2020 Chen_Yu_Hao. All rights reserved.
//

import SwiftUI
import GLKit

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        var path = Path()

        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        return path
    }
    }
func posx(degree:Double,radius:CGFloat) -> CGFloat {
    return radius*CGFloat(cos((degree-90)*Double.pi/180))
}
func posy(degree:Double,radius:CGFloat) -> CGFloat {
    return radius*CGFloat(sin((degree-90)*Double.pi/180))
}

struct ContentView: View {
    @State private var degree:Double=180
    private var radius:CGFloat=130
    var body: some View {
        VStack {
            ZStack{
                Arc(startAngle: .degrees(0), endAngle: .degrees(degree), clockwise: true)
                    .strokeBorder(Color.init(red: 209/255, green: 200/255, blue: 244/255), lineWidth: 40).frame(width:300)
                ZStack{
                    Circle().foregroundColor(Color.white).frame(width:40).offset(x:posx(degree: degree, radius: radius),y:posy(degree: degree, radius: radius))
                    Circle().foregroundColor(Color.init(red: 100/255, green: 1/255, blue: 171/255)).frame(width:40).offset(x:posx(degree: degree, radius: radius),y:posy(degree: degree, radius: radius))
                    Circle().foregroundColor(Color.white).frame(width:22).offset(x:posx(degree: degree, radius: radius),y:posy(degree: degree, radius: radius))


                }

            }
            Slider(value: self.$degree, in: 0...360).frame(width:300)

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
