on run {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}


	
	-- IMPORT OF BASE_VARIABLES SCRIPT (.scptd)

	set baseVariablesPath to (scriptPath & "/base_variables/base_variables.scptd")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	set baseVariables to (load script baseVariablesPath) -- call of the script "base_variables.scptd" in the actual script



	-- CALL TO WRITE ON THE LOG FILE



	set logPath to scriptPath & "/.log" -- create a variable for the path of the log file (name = ".log")
	baseVariables's write_to_file("\n \n -- CALL TO WRITE ON THE LOG FILE \n \n starting script add video rushes \n \n",logPath,true) -- anounce to the starting of the scrip




	set ProjectFolder to (NewProjectFolderPath & "/01_PROJECT")

	set PremiereProWorkflow to (display dialog "Will you work on Premiere Pro workflow" buttons {"No", "Yes"} default button 2 with icon (iconAppPremiereProPpath of baseVariables))
	set PremiereProRessourceFolder to (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO/Premiere Pro")
	set PremiereProFolder to (ProjectFolder & "/Premiere Pro")
	set PremiereProfile to (PremiereProFolder & "/_00_RESSOURCES_ALGO/Template_v1.prproj")
	
	-- CREATE THE DIRECTORY FOR THE VIDEO RUSHES FOLDER


	set ProjectDestinationFolderPath to (NewProjectFolder & "01_PROJECT") as text -- call to the path of the destination for the files selected  from VideoRushesSourceFiles
	baseVariables's write_to_file("var ProjectDestinationFolderPath = " & ProjectDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of ProjectDestinationFolderPath

	set PremiereProDestinationFolderPath to (NewProjectFolder & "01_PROJECT:Premiere Pro") as text -- call to the path of the destination for the files selected  from VideoRushesSourceFiles
	baseVariables's write_to_file("var PremiereProDestinationFolderPath = " & PremiereProDestinationFolderPath & " \n \n",logPath,true) -- write in log file the value of PremiereProDestinationFolderPath
	
	-- DAVINCI = YES
	
	if button returned of PremiereProWorkflow = "Yes" then

		tell application "Finder"
			if (exists (folder ProjectDestinationFolderPath)) then
				if (exists (folder PremiereProDestinationFolderPath)) then
				
					display dialog "A Premiere Pro PROJECT already exit!" buttons {"No", "Yes"} default button 2 with icon (iconAppPremiereProPpath of baseVariables)


				else
					do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/._00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO"))

					-- do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/Premiere Pro/._00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/Premiere Pro/_00_RESSOURCES_ALGO"))

					do shell script "mv " & (quoted form of PremiereProRessourceFolder) & " " & (quoted form of ProjectFolder)

					do shell script "mv " & (quoted form of PremiereProfile) & " " & (quoted form of PremiereProFolder)

					-- RENAME Premiere Pro TEMPLATE FILE

					tell application "Finder"
						set fileAlias to (NewProjectFolder & "01_PROJECT:Premiere Pro:Template_v1.prproj") as text
						set fileAliasPath to (NewProjectFolder & "01_PROJECT:Premiere Pro") as text
						set theFile to "Template_v1.prproj"
						set AppleScript's text item delimiters to "."
						set fileName to name of file fileAlias 
						set fileExtension to last text item of fileName
						set nameWithoutExtension to first text item of fileName 
						set newName to (globalProjectName & "_v1." & fileExtension)
						set name of file theFile of folder fileAliasPath to newName --> rename the file
					end tell

					do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/Premiere Pro/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/Premiere Pro/._00_RESSOURCES_ALGO"))
					do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/._00_RESSOURCES_ALGO"))



				end if
			else
				set ProjectTemplateFolderSourcesPath to (":ECOMMERCE:VIDEO_PROJECT:._00_RESSOURCES_ALGO:02_TREEFOLDER_VIDEO_PROJECT:01_PROJECT") as text -- import le dossier ressource pour 01_PROJECT

				tell application "Finder"
					duplicate ProjectTemplateFolderSourcesPath to NewProjectFolder -- ajoute le dossier Projet qui n'existant pas dans le dossier de projet
				end tell

				do shell script "mv " & (quoted form of PremiereProRessourceFolder) & " " & (quoted form of ProjectFolder)

				do shell script "mv " & (quoted form of PremiereProfile) & " " & (quoted form of PremiereProFolder)
			
				-- RENAME Premiere Pro TEMPLATE FILE

				tell application "Finder"
					set fileAlias to (NewProjectFolder & "01_PROJECT:Premiere Pro:Template_v1.prproj") as text
					set fileAliasPath to (NewProjectFolder & "01_PROJECT:Premiere Pro") as text
					set theFile to "Template_v1.prproj"
					set AppleScript's text item delimiters to "."
					set fileName to name of file fileAlias 
					set fileExtension to last text item of fileName
					set nameWithoutExtension to first text item of fileName 
					set newName to (globalProjectName & "_v1." & fileExtension)
					set name of file theFile of folder fileAliasPath to newName --> rename the file
				end tell

				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/Premiere Pro/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/Premiere Pro/._00_RESSOURCES_ALGO"))
				do shell script "mv " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/_00_RESSOURCES_ALGO")) & " " & (quoted form of (NewProjectFolderPath & "/01_PROJECT/._00_RESSOURCES_ALGO"))


			end if
		end tell

	end if

	
	


	-- RUN SCRIPT 2.1.3-add-workflow.applescript 


	set scriptAddWorkflowPath to (scriptPath & "2.1.3-add-workflow.applescript")  -- create a variable for the path of the folder which contain the script "base_variables.scptd"
	run script scriptAddWorkflowPath with parameters {scriptPath, NewProjectFolderPath, NewProjectFolder, globalProjectName}


end run