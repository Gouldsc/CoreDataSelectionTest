//
//  GroupSourceListRowView.swift
//  GroupSourceListRowView
//
//  Created by Scott Gould on 9/2/21.
//

import SwiftUI

struct GroupSourceListRowView: View
{
	@State var group: Group
	
	var body: some View
	{
		HStack
		{
			Image( systemName: "folder" )
			NavigationLink( group.name, destination: GroupDetailView( group: group ) )
		}
	}
}
