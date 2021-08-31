//
//  EntityADetailView.swift
//  EntityADetailView
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

struct EntityADetailView: View
{
	@State var entityA: EntityA
	
    var body: some View
	{
		Text( "\(entityA.name) with ID:\n \(entityA.objectID)." )
			.font(.largeTitle)
			.bold()
    }
}
