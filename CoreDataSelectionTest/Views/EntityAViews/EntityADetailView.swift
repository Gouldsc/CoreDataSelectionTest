//
//  EntityADetailView.swift
//  EntityADetailView
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

struct EntityADetailView: View
{
	@Environment( \.managedObjectContext ) private var viewContext

	@Binding var entityA: EntityA
	
    var body: some View
	{
		VStack
		{
			Text( "\(entityA.name)" )
			.font( .title )
			.frame( alignment: .center )
			
			Text( "ID:\n \(entityA.objectID)." )
				.font( .title3 )
				.bold()
		}
		.padding()
		.foregroundColor( entityA.isActivated ? .accentColor : .secondary )
    }
}
