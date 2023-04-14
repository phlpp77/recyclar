////
////  TapView.swift
////  RecyclAR
////
////  Created by Soo Bin on 4/11/23.
////
//
//import SwiftUI
//
//struct TapView: View {
//
//    @State private var isIdentifying = false
//
////    struct CircleButton: View {
////
////        @Binding var isIdentifying: Bool
////
////        var body: some View {
////            Button(action: {}) {
////                Image(systemName: "circle.fill")
////                    .foregroundColor(Color.gray)
////                    .overlay(
////                        Image(systemName: "circle.fill")
////                            .foregroundColor(Color.white)
////                            .scaleEffect(0.45)
////                    )
////                    .font(.system(size: 70))
////                    .frame(width: 70, height: 70)
////                    .opacity(0.22)
////            }
////        }
////
////    }
//
//    var body: some View {
//        VStack {
//            Text(isIdentifying ? "Identifying" : "Tap to Position")
//                .foregroundColor(.white)
//                .font(Font.custom("WorkSans-Bold", size: 24))
//                .padding(.bottom, 16)
//            Button(action: {}) {
//                Image(systemName: "circle.fill")
//                    .foregroundColor(isIdentifying ? Color.green : Color.gray)
//                    .overlay(
//                        Image(systemName: "circle.fill")
//                            .foregroundColor(isIdentifying ? Color.green : Color.white)
//                            .scaleEffect(0.45)
//                    )
//                    .font(.system(size: 70))
//                    .frame(width: 70, height: 70)
//                    .opacity(0.22)
//                    .onTapGesture {
//                        isIdentifying.toggle()
//                    }
//            }
//        }
//        .padding()
//        .frame(width: 380.46, height: 592.11)
//        .background(
//            Color.black
//                .opacity(0.7)
//                .blur(radius: 7.5)
//                .cornerRadius(20)
//        )
//    }
//
//
//}
//
//
//
//struct TapView_Previews: PreviewProvider {
//    static var previews: some View {
//        TapView()
//    }
//}

import SwiftUI

struct TapView: View {
    
    enum TapViewState {
        case tapToPosition
        case identifying
        case scanned
        case objectFound
        
        var title: String {
            switch self {
            case .tapToPosition:
                return "Tap to Position"
            case .identifying:
                return "Identifying"
            case .scanned:
                return "Scanned"
            case .objectFound:
                return "Object Found"
            }
        }
        
        var outterButtonColor: Color {
            switch self {
            case .tapToPosition:
                return .white
            case .identifying:
                return .green
            case .scanned:
                return .blue
            case .objectFound:
                return .blue
            }
        }
        
        var innerButtonColor: Color {
            switch self {
            case .tapToPosition:
                return .white
            case .identifying:
                return Color(#colorLiteral(red: 0.196, green: 0.843, blue: 0.294, alpha: 1.0))
            case .scanned:
                return Color(#colorLiteral(red: 0, green: 0.478, blue: 1, alpha: 1))
            case .objectFound:
                return Color(#colorLiteral(red: 0, green: 0.478, blue: 1, alpha: 1))
            }
        }
        
        var frameColor: Color {
            switch self {
            case .tapToPosition:
                return Color.black.opacity(0.7)
            case .identifying:
                return Color(#colorLiteral(red: 0.196, green: 0.843, blue: 0.294, alpha: 0.5)).opacity(0.7)
            case .scanned:
                return Color(#colorLiteral(red: 0.262, green: 0.723, blue: 0.921, alpha: 0.5)).opacity(0.7)
            case .objectFound:
                return Color.clear
            }
        }
        
    }
    
    @Binding var state: TapViewState
    
    var body: some View {
        VStack {
            Text(state.title)
                .foregroundColor(.white)
                .font(Font.custom("WorkSans-Regular", size: 32))
                .padding(.bottom, 16)
            Button(action: {}) {
                Image(systemName: "circle.fill")
                    .foregroundColor(state.outterButtonColor)
                    .opacity(0.22)
                    .overlay(
                        Image(systemName: "circle.fill")
                            .foregroundColor(state.innerButtonColor)
                            .scaleEffect(state == .identifying ? 0.35 : 0.45)
                    )
                    .font(.system(size: 70))
                    .frame(width: state == .identifying ? 55 : 70, height: state == .identifying ? 55 : 70)
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: state)
                    .onTapGesture {
                        if state == .tapToPosition {
                            withAnimation(Animation.easeOut(duration: 0.5)) {
                                state = .identifying
                            }
                        }
                    }
//                    .overlay(
//                        ZStack {
//                            if state == .identifying {
//                                Image(systemName: "circle.fill")
//                                    .foregroundColor(state.innerButtonColor)
//                                    .scaleEffect(0.45)
//                                    .animation(
//                                        Animation.easeInOut(duration: 1.0)
//                                            .repeatForever(autoreverses: true)
//                                    )
//                            } else {
//                                Image(systemName: "circle.fill")
//                                    .foregroundColor(state.innerButtonColor)
//                                    .scaleEffect(0.45)
//                            }
//                        }
//                    )
//                    .font(.system(size: 70))
//                    .frame(width: 70, height: 70)
//                    .onTapGesture {
//                        if state == .tapToPosition {
//                            withAnimation(Animation.easeOut(duration: 0.5)) {
//                                state = .identifying
//                            }
//                        }
//                    }
            }
        }
        .padding()
        .frame(width: 380.46, height: 592.11)
//        .background(
//            Color.black
//                .opacity(0.7)
//                .blur(radius: 7.5)
//                .cornerRadius(20)
//        )
        .background(
            state.frameColor
            .blur(radius: 7.5))
        .cornerRadius(20)


    }
}

//struct TapView_Previews: PreviewProvider {
//    static var previews: some View {
//        TapView()
//    }
//}
