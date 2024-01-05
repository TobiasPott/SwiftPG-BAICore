//
//  File.swift
//  
//
//  Created by Irmunsul on 21.12.23.
//
import SwiftUI

public extension View {
    static var anyEmpty: AnyView {
        AnyView(EmptyView())
    }
    static var anySpacer: AnyView {
        AnyView(Spacer())
    }
}
