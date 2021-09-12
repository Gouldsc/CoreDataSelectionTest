//
//  EntityCDetailView.swift
//  EntityCDetailView
//
//  Created by Scott Gould on 9/2/21.
//

import SwiftUI

struct EntityCDetailView: View
{
	@ObservedObject var entityC: EntityC
	
	var body: some View
	{
		VStack
		{
			Text( "\(entityC.name)" )
				.font( .title )
				.frame( alignment: .center )
			
			Text( "ID:\n \(entityC.objectID)." )
				.font( .title3 )
				.bold()
			
			Text( "userOrder: \(entityC.userOrder)." )
				.font( .title3 )
				.bold()
		}
		.padding()
		.foregroundColor( entityC.isActivated ? .accentColor : .secondary )
//		.focusedSceneValue( \.entityC, entityC )
	}
}
