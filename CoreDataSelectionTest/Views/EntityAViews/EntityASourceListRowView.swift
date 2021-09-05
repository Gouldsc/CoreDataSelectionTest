//
//  EntityASourceListRowView.swift
//  EntityASourceListRowView
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

struct EntityASourceListRowView: View
{
	@State var entityA: EntityA
	var name: String
	{
		get
		{
			entityA.name
		}
		set
		{
			entityA.name = newValue
			PersistenceController.shared.save()
		}
	}
	@State var isToggled: Bool
	
	var body: some View
	{
		HStack
		{
			Image( systemName: "swift" )
			NavigationLink( name, destination: EntityADetailView( entityA: $entityA ) )
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
				entityA.isActivated = true
				
			case false:
				entityA.isActivated = false
		}
		PersistenceController.shared.save()
	}
}
