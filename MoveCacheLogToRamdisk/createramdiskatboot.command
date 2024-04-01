#!/bin/sh

# !!! This script is dedicated for user jsheng !!!
# change the following variables to suit your environment

_user="jsheng"
_file_mode="${_user}:staff"

while [ ! -d /Volumes ]
do
	echo "waiting..."
	sleep 0.5
done
if [ ! -d /Volumes/RamDisk ]; then
	echo "creating ramdisk..."
	sleep 0.5
	diskutil partitionDisk $(hdiutil attach -nomount ram://$((2048*2000))) 1 GPTFormat APFS 'RamDisk' '100%'

#	mkdir -p /Volumes/RamDisk/Logs/
#	sudo rm -rf /private/var/log
#	ln -s /Volumes/RamDisk/Logs /private/var/log

#	sudo rm -rf /Library/Logs
#	sudo ln -s /Volumes/RamDisk/Logs /Library/Logs


#	mkdir -p /Volumes/RamDisk/Downloads
#	sudo rm -rf /Users/${_user}/Downloads
#	sudo ln -s /Volumes/RamDisk/Downloads /Users/${_user}/Downloads
#	sudo chown ${_file_mode} /Users/${_user}/Downloads 

	declare -a arr=(
#		"Adobe Camera Raw 2"
#		"Adobe_CCXProcess.node"
#		"askpermissiond"
#		"BraveSoftware"
#		"com.adobe.acc.AdobeDesktopService"
#		"com.adobe.acc.ads.helper"
#		"com.adobe.bridge10"
#		"com.adobe.headlights.LogTransport2App"
#		"com.apple.akd"
#		"com.apple.AMPLibraryAgent"
#		"com.apple.AppleMediaServices"
#		"com.apple.appstore"
#		"com.apple.appstoreagent"
#		"com.apple.cache_delete"
#		"com.apple.commerce"
#		"com.apple.helpd"
#		"com.apple.iBooksX"
#		"com.apple.icloud.fmfd"
#		"com.apple.iCloudHelper"
#		"com.apple.imfoundation.IMRemoteURLConnectionAgent"
#		"com.apple.InstallAssistant.macOS1016"
#		"com.apple.installer"
#		"com.apple.installer.osinstallersetupd"
#		"com.apple.nbagent"
#		"com.apple.nsurlsessiond"
#		"com.apple.parsecd"
#		"com.apple.passd"
#		"com.apple.proactive.eventtracker"
#		"com.apple.remindd"
#		"com.apple.Spotlight"
#		"com.apple.touristd"
#		"com.apple.VideoConference"
#		"com.apple.XprotectFramework.AnalysisService"
#		"com.brave.Browser"
#		"com.crashlytics.data"
#		"com.dustinrue.ControlPlane"
#		"com.flixtools.flixtools"
#		"com.Google.GoogleDrive"
		"com.google.GoogleEarthPro"
#		#"com.google.Keystone"
#		"com.google.SoftwareUpdate"
#		"com.intel.PowerGadget"
#		"com.MattRajca.RetinaCapture"
#		"com.microsoft.autoupdate.fba"
#		"com.microsoft.autoupdate2"
#		"com.microsoft.edgemac"
		"com.microsoft.teams"
#		"com.operasoftware.Installer.Opera"
#		"com.operasoftware.Opera"
#		"com.panic.Transmit"
#		"com.plausiblelabs.crashreporter.data"
#		"com.runningwithcrayons.Alfred"
#		"com.spotify.client"
#		"com.teamviewer.TeamViewer"
#		"CSXS"
#		"FamilyCircle"
#		"familycircled"
#		#"GeoServices"
		"Google Earth"
		"Google"
		"com.firefox.Browser"
		"com.tencent.qq"
#		"knowledge-agent"
#		"ksfetch"
#		"Maps"
#		"Microsoft"
#		"Microsoft Edge"
#		"net.freemacsoft.AppCleaner"
#		"net.pornel.ImageOptim"
#		"node"
#		#"PassKit"
#		"TeamViewer"
#		"Transmit"
	)
	
	for i in "${arr[@]}"
	do
		mkdir -p "/Volumes/RamDisk/Caches/$i"
		if [[ -L "/Users/${_user}/Library/Caches/$i" && -d "/Users/${_user}/Library/Caches/$i" ]]
		then
			echo "$i is already a symlink"
		else
			rm -rf "/Users/${_user}/Library/Caches/$i"
			ln -s "/Volumes/RamDisk/Caches/$i" /Users/${_user}/Library/Caches
			echo "$i CREATED"
		fi

		#Experiments show if there is no directory ~/Library/Caches/Google/Chrome/Default exist, 
		#Chrome will not create subdirectory Cache_Data at all. It's confusing who created 
		#the directory at the first time, isn't Chrome itslef? Maybe it's a issue with the logic 
		#of the code flow.	
		if [[ $i == "Google" ]] 
		then
			mkdir -p "/Volumes/RamDisk/Caches/$i/Chrome/Default"
		fi

		# QQ report no such download directory or dose not have enough permission there
		if [[ $i == "com.tencent.qq" ]]
		then
			chown ${_file_mode} /Volumes/RamDisk/Caches/$i
		fi
	done
fi
