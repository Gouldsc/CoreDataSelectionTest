//
//  EntityCSourceListRowView.swift
//  EntityCSourceListRowView
//
//  Created by Scott Gould on 9/2/21.
//

import SwiftUI

struct EntityCSourceListRowView: View
{
	@State var entityC: EntityC
	@State var isToggled: Bool
	
	var body: some View
	{
		HStack
		{
			Image( systemName: "tag" )
			NavigationLink( entityC.name, destination: EntityCDetailView( entityC: $entityC ) )
			Spacer()
			Toggle( "title", isOn: $isToggled )
				.onChange( of: self.isToggled, perform:
				{
					updateIsActivatedStatus( to: $0 )
				} )
				.labelsHidden()
		}
	}
	
	private func updateIsActivatedStatus( to: Bool )
	{
		switch isToggled
		{
			case true:
				entityC.isActivated = true
				
			case false:
				entityC.isActivated = false
		}
		PersistenceController.shared.save()
	}
}
