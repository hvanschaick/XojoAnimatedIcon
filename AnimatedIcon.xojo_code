#tag Class
Protected Class AnimatedIcon
Inherits Canvas
Implements actionNotificationReceiver
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  if self.UpdateTimer.Enabled = true then
		    g.DrawPicture(icon(IconIndex),0,0,g.Width, g.Height, 0, 0, Icon(IconIndex).Width, Icon(IconIndex).Height)
		  else
		    Var p as Picture = self.staticICON
		    if p = nil and self.Backdrop <> nil then
		      p = self.backdrop
		    end
		    if p <> nil then
		      g.DrawPicture(p,0,0,g.Width, g.Height, 0, 0, p.Width, p.Height)
		    end
		  end
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function FolderItemCompare(f1 as FolderItem, f2 as FolderItem) As Integer
		  if f1.Name < f1.Name then
		    return -1
		  elseif f1.Name > f2.Name then
		    return 1
		  end
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Initialize(dirname as string, Interval as integer = 50, stdIcon as Picture = nil) As Boolean
		  Var fname as string
		  Var d as FolderItem
		  Var success as Boolean = false
		  #if DebugBuild
		    d = new FolderItem(dirname)
		  #else
		    try
		      d = SpecialFolder.Resources.Child(dirname)
		    Catch e as NilObjectException
		      MessageBox("Icon resources not found: "+dirname)
		      Return false
		    end Try
		  #EndIf
		  
		  IconFiles.RemoveAllRows
		  if d.Exists then
		    if d.IsFolder then
		      for each f as FolderItem in d.Children
		        IconFiles.AddRow(f) 
		        success = true
		      next
		    end
		    if IconFiles.Count > 1 then
		      for i as integer = 0 to IconFiles.Count  - 2
		        for j as Integer = i+1to IconFiles.Count - 1
		          if FolderItemCompare(IconFiles(i),IconfIles(j)) > 0 then
		            Var f as FolderItem = IconFiles(i)
		            iconFiles(i) = IconFiles(j)
		            IconFiles(j) = f
		          end
		        next
		      next
		    end
		    Icon.RemoveAllRows
		    for i as Integer = 0 to IconFiles.Count - 1
		      Var p as Picture
		      p = Picture.Open(IconFiles(i))
		      Icon.AddRow(p)
		    next
		  end
		  IconFiles.RemoveAllRows // clean up
		  staticICON = stdIcon
		  UpdateTimer = new Timer
		  UpdateTimer.Period = Interval
		  UpdateTimer.RunMode = Timer.RunModes.Multiple
		  UpdateTimer.Enabled = false
		  UpdateTimer.addActionNotificationReceiver(self)
		  return success
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PerformAction()
		  // Part of the actionNotificationReceiver interface.
		  IconIndex = IconIndex + 1
		  if IconIndex > icon.Count -1 then
		    IconIndex = 0
		  end
		  self.Invalidate
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub startAnimation()
		  if UpdateTimer.Enabled = false then // not sure if it is bad to enable multiple times
		    UpdateTimer.Enabled = true
		  end
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub stopAnimation()
		  UpdateTimer.Enabled = false
		  self.Invalidate
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private icon() As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IconFiles() As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IconIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private staticICON As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private UpdateTimer As Timer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group=""
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
