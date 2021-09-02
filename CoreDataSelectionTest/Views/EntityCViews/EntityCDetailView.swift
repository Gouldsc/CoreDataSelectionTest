//
//  EntityCDetailView.swift
//  EntityCDetailView
//
//  Created by Scott Gould on 9/2/21.
//

import SwiftUI

struct EntityCDetailView: View
{
	@State var entityC: EntityC
	
	var body: some View
	{
		Text( "\(entityC.name) with ID:\n \(entityC.objectID)." )
			.font(.largeTitle)
			.bold()
	}
}
