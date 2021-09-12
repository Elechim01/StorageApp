//
//  Home.swift
//  Home
//
//  Created by Michele Manniello on 12/09/21.
//

import SwiftUI

struct Home: View {
    
    @State var currentTab = "Home"
    @State var showMenu = false
    var body: some View {
        AdaptableStack(showMenu: $showMenu) {
            MainContent(showMenu: $showMenu)
        } menuView: {
            SideMenu(currentTab: $currentTab)
        } sideView: {
            SideView()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//Extension For Getting Screen Size...
//for both mac and ios...
extension View{
    func getRect() -> CGRect {
        #if os(macOS)
        return NSScreen.main!.visibleFrame
        #else
        return UIScreen.main.bounds
        #endif
    }
    func isMacOS() -> Bool {
//        getting IOS or macOS....
        #if os(iOS)
        return false
        #else
        return true
        #endif
    }
}

// Buildig custom Stack View for adapting For Both mac And IOS...
struct AdaptableStack<Content: View,MenuView: View,SideView: View>: View {
    var content: Content
    var menuView : MenuView
    var sideView: SideView
    
//    For Slide Menu IOS...
    @Binding var showMenu : Bool
    
    init(showMenu : Binding<Bool>, @ViewBuilder content : @escaping ()-> Content,@ViewBuilder menuView : @escaping ()-> MenuView,@ViewBuilder sideView : @escaping ()-> SideView){
        self._showMenu = showMenu
        self.content = content()
        self.menuView = menuView()
        self.sideView = sideView()
    }
    
    var body: some View{
        ZStack{
//            SideMenu(currentTab: $currentTab)
//            Checking for IOS Or MAcOS...
            #if os (iOS)
//            Modifications...
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    content
                    
                    sideView
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                .padding()
            }
            .background(Color("gray").ignoresSafeArea())
            .overlay(
                menuView
                    .clipped()
                    .frame(width: getRect().width / 1.6)
                    .background(Color("gray").ignoresSafeArea())
                    .offset(x: showMenu ? 0 : -getRect().width )
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.black
                                    .opacity( showMenu ? 0.35 : 0)
                                    .ignoresSafeArea()
                                    .onTapGesture {
                                        withAnimation {
                                            showMenu.toggle()
                                        }
                                    })
            )
            #else
//            Same As Just Now...
            HStack{
                menuView
                //        Max Width...
                .frame(width: 210)
                .background(Color("gray").ignoresSafeArea())
                
                content
                
                sideView
            }
            .frame(width: getRect().width / 1.3, height: getRect().height - 100, alignment: .leading)

            .background(Color.white.ignoresSafeArea())
    //        Applyng Button Style to Whole View...
            .buttonStyle(PlainButtonStyle())
            #endif
        }
        .preferredColorScheme(.light)
    }
}
